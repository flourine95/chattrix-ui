# 🏗️ LUỒNG CHẠY CLEAN ARCHITECTURE - LOGIN USE CASE

## 📋 Tổng quan

Document này giải thích chi tiết luồng chạy của **Login UseCase** qua toàn bộ các layer trong Clean Architecture của Chattrix UI.

---

## 🎯 Use Case: ĐĂNG NHẬP (Login)

**Mục tiêu:** User nhập username/email + password → Nhận tokens → Lưu vào secure storage → Hiển thị thông tin user

---

## 🌊 LUỒNG CHẠY ĐẦY ĐỦ (10 BƯỚC)

```
┌─────────────────────────────────────────────────────────────────────┐
│                    PRESENTATION LAYER (UI)                          │
├─────────────────────────────────────────────────────────────────────┤
│  1. LoginScreen (Widget)                                            │
│     ↓ User nhấn nút "Login"                                         │
│  2. AuthNotifier (State Management - Riverpod)                      │
│     ↓ Gọi login()                                                   │
├─────────────────────────────────────────────────────────────────────┤
│                      DOMAIN LAYER (Business Logic)                  │
├─────────────────────────────────────────────────────────────────────┤
│  3. LoginUseCase                                                    │
│     ↓ Gọi repository.login()                                        │
│  4. AuthRepository (Interface)                                      │
│     ↓ Contract định nghĩa login()                                   │
├─────────────────────────────────────────────────────────────────────┤
│                      DATA LAYER (Implementation)                    │
├─────────────────────────────────────────────────────────────────────┤
│  5. AuthRepositoryImpl                                              │
│     ↓ Gọi remoteDataSource.login()                                  │
│  6. AuthRemoteDataSource (Interface)                                │
│     ↓ Contract định nghĩa login()                                   │
│  7. AuthRemoteDataSourceImpl                                        │
│     ↓ HTTP POST request                                             │
├─────────────────────────────────────────────────────────────────────┤
│                      INFRASTRUCTURE                                 │
├─────────────────────────────────────────────────────────────────────┤
│  8. AuthHttpClient (Auto Token Refresh)                             │
│     ↓ Thêm Authorization header tự động                             │
│  9. Backend API                                                     │
│     ↓ Trả về {accessToken, refreshToken}                            │
├─────────────────────────────────────────────────────────────────────┤
│                      DATA LAYER (Storage)                           │
├─────────────────────────────────────────────────────────────────────┤
│ 10. AuthLocalDataSourceImpl                                         │
│     ↓ Lưu tokens vào FlutterSecureStorage                           │
└─────────────────────────────────────────────────────────────────────┘
          ↓ Trả về AuthTokens entity
          ↓ AuthNotifier cập nhật state
          ↓ UI hiển thị "Login thành công"
```

---

## 📝 CHI TIẾT TỪNG BƯỚC

### **BƯỚC 1: LoginScreen (Presentation Layer)**

📁 **File:** `lib/features/auth/presentation/pages/login_screen.dart`

```dart
// User nhấn nút Login
PrimaryButton(
  text: 'Login',
  isLoading: isLoading,
  onPressed: () async {
    final email = emailController.text.trim();
    final password = passwordController.text;

    // ✅ Validation ở UI level
    if (email.isEmpty || password.isEmpty) {
      Toasts.error(context, title: 'Lỗi', description: 'Vui lòng nhập đầy đủ');
      return;
    }

    // 👉 GỌI AuthNotifier
    final success = await ref
        .read(authNotifierProvider.notifier)
        .login(usernameOrEmail: email, password: password);

    if (success) {
      Toasts.success(context, title: 'Thành công', description: 'Đăng nhập thành công!');
      context.go('/'); // Redirect về home
    } else {
      final error = ref.read(authErrorProvider);
      Toasts.error(context, title: 'Lỗi', description: error ?? 'Có lỗi xảy ra');
    }
  },
)
```

**Trách nhiệm:**
- ✅ Nhận input từ user
- ✅ Validation cơ bản (empty check)
- ✅ Hiển thị loading state
- ✅ Hiển thị thông báo kết quả
- ❌ KHÔNG chứa business logic

---

### **BƯỚC 2: AuthNotifier (Presentation Layer - State Management)**

📁 **File:** `lib/features/auth/presentation/providers/auth_providers.dart`

```dart
class AuthNotifier extends Notifier<AuthState> {
  Future<bool> login({
    required String usernameOrEmail,
    required String password,
  }) async {
    // 1️⃣ Cập nhật state: isLoading = true, clear error
    state = state.copyWith(isLoading: true, clearError: true);

    // 2️⃣ 👉 GỌI LoginUseCase qua Provider
    final result = await ref.read(loginUseCaseProvider)(
      usernameOrEmail: usernameOrEmail,
      password: password,
    );

    // 3️⃣ Xử lý Either<Failure, AuthTokens>
    return result.fold(
      // ❌ Trường hợp THẤT BẠI
      (failure) {
        state = state.copyWith(
          isLoading: false,
          errorMessage: _getFailureMessage(failure), // Convert Failure → String
        );
        return false;
      },
      // ✅ Trường hợp THÀNH CÔNG
      (tokens) async {
        await loadCurrentUser(); // Load thông tin user sau khi login
        return true;
      },
    );
  }

  String _getFailureMessage(Failure failure) {
    return failure.when(
      server: (message, errorCode) => message,
      network: (message) => 'Không có kết nối mạng',
      validation: (message, errors) => message,
      unauthorized: (message, errorCode) => message,
      // ... các cases khác
    );
  }
}
```

**Trách nhiệm:**
- ✅ Quản lý state (loading, error, user)
- ✅ Gọi UseCases
- ✅ Convert `Failure` → User-friendly messages
- ✅ Trigger UI updates (via Riverpod)
- ❌ KHÔNG gọi API trực tiếp

---

### **BƯỚC 3: LoginUseCase (Domain Layer)**

📁 **File:** `lib/features/auth/domain/usecases/login_usecase.dart`

```dart
class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  // 👉 call() method - convention cho callable class
  Future<Either<Failure, AuthTokens>> call({
    required String usernameOrEmail,
    required String password,
  }) async {
    // 👉 ĐƠN GIẢN: Chỉ gọi repository
    return await repository.login(
      usernameOrEmail: usernameOrEmail,
      password: password,
    );
  }
}
```

**Tại sao cần UseCase?**
- ✅ **Single Responsibility:** Mỗi UseCase = 1 hành động nghiệp vụ
- ✅ **Reusability:** Có thể kết hợp nhiều Repository
- ✅ **Testability:** Dễ test riêng biệt
- ✅ **Business Logic:** Nơi đặt validation phức tạp, orchestration

**Ví dụ UseCase phức tạp hơn:**
```dart
// Nếu cần validate business rules trước khi gọi repository
Future<Either<Failure, AuthTokens>> call({...}) async {
  // Kiểm tra email format
  if (!_isValidEmail(usernameOrEmail)) {
    return Left(Failure.validation(message: 'Email không hợp lệ'));
  }
  
  // Kiểm tra password strength
  if (password.length < 8) {
    return Left(Failure.validation(message: 'Mật khẩu phải >= 8 ký tự'));
  }
  
  // Có thể kết hợp nhiều repository
  final connectionCheck = await networkRepository.checkConnection();
  if (!connectionCheck) {
    return Left(Failure.network(message: 'Không có mạng'));
  }
  
  return await repository.login(...);
}
```

---

### **BƯỚC 4: AuthRepository Interface (Domain Layer)**

📁 **File:** `lib/features/auth/domain/repositories/auth_repository.dart`

```dart
abstract class AuthRepository {
  // 👉 Contract định nghĩa login phải trả về gì
  Future<Either<Failure, AuthTokens>> login({
    required String usernameOrEmail,
    required String password,
  });

  // ... các methods khác
}
```

**Tại sao cần Interface?**
- ✅ **Dependency Inversion:** Domain không phụ thuộc vào Data
- ✅ **Testability:** Mock dễ dàng
- ✅ **Flexibility:** Swap implementation (API → Firebase → SQLite)

---

### **BƯỚC 5: AuthRepositoryImpl (Data Layer)**

📁 **File:** `lib/features/auth/data/repositories/auth_repository_impl.dart`

```dart
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;

  @override
  Future<Either<Failure, AuthTokens>> login({
    required String usernameOrEmail,
    required String password,
  }) async {
    try {
      // 1️⃣ 👉 GỌI Remote DataSource để lấy tokens từ API
      final tokensModel = await remoteDataSource.login(
        usernameOrEmail: usernameOrEmail,
        password: password,
      );

      // 2️⃣ 👉 LƯU tokens vào Local DataSource (Secure Storage)
      await localDataSource.saveTokens(
        accessToken: tokensModel.accessToken,
        refreshToken: tokensModel.refreshToken,
      );

      // 3️⃣ Convert Model → Entity và return success
      return Right(tokensModel.toEntity());
      
    } on ServerException catch (e) {
      // 4️⃣ Convert Exception → Failure
      return Left(_mapServerExceptionToFailure(e));
    } on NetworkException catch (e) {
      return Left(Failure.network(message: e.message));
    } catch (e) {
      return Left(Failure.unknown(message: e.toString()));
    }
  }

  // Convert HTTP status code → Failure type
  Failure _mapServerExceptionToFailure(ServerException exception) {
    switch (exception.statusCode) {
      case 400: return Failure.validation(message: exception.message);
      case 401: return Failure.unauthorized(message: exception.message);
      case 404: return Failure.notFound(message: exception.message);
      case 409: return Failure.conflict(message: exception.message);
      default: return Failure.server(message: exception.message);
    }
  }
}
```

**Trách nhiệm:**
- ✅ **Orchestration:** Điều phối Remote + Local DataSources
- ✅ **Error Handling:** Convert Exceptions → Failures
- ✅ **Data Transformation:** Model → Entity
- ✅ **Cache Logic:** Có thể check cache trước khi gọi API

**Pattern quan trọng:**
```
Exception (Data Layer) → Failure (Domain Layer)
Model (Data Layer) → Entity (Domain Layer)
```

---

### **BƯỚC 6 & 7: DataSource Interface & Implementation (Data Layer)**

#### **Interface:**
📁 **File:** `lib/features/auth/domain/datasources/auth_remote_datasource.dart`

```dart
abstract class AuthRemoteDataSource {
  /// 👉 Contract: Phải trả về AuthTokensModel hoặc throw Exception
  Future<AuthTokensModel> login({
    required String usernameOrEmail,
    required String password,
  });
}
```

#### **Implementation:**
📁 **File:** `lib/features/auth/data/datasources/auth_remote_datasource_impl.dart`

```dart
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final http.Client client; // Đây thực chất là AuthHttpClient

  @override
  Future<AuthTokensModel> login({
    required String usernameOrEmail,
    required String password,
  }) async {
    try {
      // 1️⃣ Chuẩn bị request
      final response = await client.post(
        Uri.parse('${ApiConstants.baseUrl}/${ApiConstants.login}'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'usernameOrEmail': usernameOrEmail,
          'password': password,
        }),
      );

      // 2️⃣ Parse & validate response
      final data = await _handleResponse(response);
      
      // 3️⃣ Convert JSON → Model
      return AuthTokensModel.fromJson(data);
      
    } catch (e) {
      throw _handleError(e);
    }
  }

  Future<dynamic> _handleResponse(http.Response response) async {
    final jsonResponse = jsonDecode(response.body);

    // ✅ Success: 2xx status codes
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return jsonResponse['data']; // API format: {data: {...}, message: "..."}
    } 
    
    // ❌ Error: Extract error info
    else {
      final message = jsonResponse['message'] ?? 'An error occurred';
      final errors = jsonResponse['errors'] as List?;
      final errorCode = errors?.isNotEmpty == true
          ? errors!.first['errorCode'] as String?
          : null;

      throw ServerException(
        message: message,
        errorCode: errorCode,
        statusCode: response.statusCode,
      );
    }
  }

  Exception _handleError(dynamic error) {
    if (error is ServerException) return error;
    if (error is http.ClientException) return NetworkException();
    return ServerException(message: error.toString());
  }
}
```

**Trách nhiệm:**
- ✅ **HTTP Calls:** Gọi API backend
- ✅ **Serialization:** JSON ↔ Model
- ✅ **Error Parsing:** Throw Exceptions khi có lỗi
- ❌ KHÔNG xử lý Failures (đó là việc của Repository)

---

### **BƯỚC 8: AuthHttpClient (Infrastructure)**

📁 **File:** `lib/core/network/auth_http_client.dart`

```dart
class AuthHttpClient extends http.BaseClient {
  final http.Client _inner;
  final FlutterSecureStorage _secureStorage;

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    // 1️⃣ TỰ ĐỘNG thêm access token vào header
    final accessToken = await _secureStorage.read(key: ApiConstants.accessTokenKey);
    if (accessToken != null && !request.headers.containsKey('Authorization')) {
      request.headers['Authorization'] = 'Bearer $accessToken';
    }

    // 2️⃣ Gửi request
    var response = await _inner.send(request);

    // 3️⃣ NẾU nhận 401 (Unauthorized) → TỰ ĐỘNG refresh token
    if (response.statusCode == 401) {
      final shouldRefresh = !request.url.toString().contains('/login') &&
                            !request.url.toString().contains('/register');

      if (shouldRefresh) {
        // 🔄 Gọi API refresh token
        final newAccessToken = await _refreshAccessToken();

        if (newAccessToken != null) {
          // Tạo request mới với token mới
          final newRequest = _copyRequest(request);
          newRequest.headers['Authorization'] = 'Bearer $newAccessToken';

          // ♻️ RETRY request
          response = await _inner.send(newRequest);
        }
      }
    }

    return response;
  }

  Future<String?> _refreshAccessToken() async {
    final refreshToken = await _secureStorage.read(key: ApiConstants.refreshTokenKey);
    if (refreshToken == null) return null;

    // Call refresh endpoint
    final response = await _inner.post(
      Uri.parse('${ApiConstants.baseUrl}/${ApiConstants.refresh}'),
      body: jsonEncode({'refreshToken': refreshToken}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)['data'];
      final newAccessToken = data['accessToken'];
      final newRefreshToken = data['refreshToken'];

      // ⭐ SLIDING SESSION: Backend trả về cả 2 tokens mới
      await _secureStorage.write(key: ApiConstants.accessTokenKey, value: newAccessToken);
      await _secureStorage.write(key: ApiConstants.refreshTokenKey, value: newRefreshToken);

      return newAccessToken;
    }

    return null;
  }
}
```

**Tính năng đặc biệt:**
- ✅ **Auto Token Injection:** Tự động thêm Bearer token
- ✅ **Auto Refresh:** Tự động refresh khi 401
- ✅ **Auto Retry:** Tự động retry request sau khi refresh
- ✅ **Sliding Session:** Tokens được gia hạn liên tục khi user active
- ✅ **Thread-Safe:** Sử dụng Completer để tránh race condition

---

### **BƯỚC 9: Backend API**

🌐 **Endpoint:** `POST /api/v1/auth/login`

**Request:**
```json
{
  "usernameOrEmail": "john_doe",
  "password": "securePassword123"
}
```

**Response (Success - 200):**
```json
{
  "data": {
    "accessToken": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
    "refreshToken": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..."
  },
  "message": "Login successful"
}
```

**Response (Error - 401):**
```json
{
  "message": "Invalid credentials",
  "errors": [
    {
      "field": "password",
      "message": "Invalid username or password",
      "errorCode": "INVALID_CREDENTIALS"
    }
  ]
}
```

---

### **BƯỚC 10: AuthLocalDataSource (Data Layer - Storage)**

📁 **File:** `lib/features/auth/data/datasources/auth_local_datasource_impl.dart`

```dart
class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final FlutterSecureStorage secureStorage;

  @override
  Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
  }) async {
    // 💾 LƯU VÀO ENCRYPTED STORAGE
    await secureStorage.write(
      key: ApiConstants.accessTokenKey,    // 'access_token'
      value: accessToken,
    );
    await secureStorage.write(
      key: ApiConstants.refreshTokenKey,   // 'refresh_token'
      value: refreshToken,
    );
  }

  @override
  Future<String?> getAccessToken() async {
    return await secureStorage.read(key: ApiConstants.accessTokenKey);
  }

  @override
  Future<String?> getRefreshToken() async {
    return await secureStorage.read(key: ApiConstants.refreshTokenKey);
  }

  @override
  Future<void> deleteTokens() async {
    await secureStorage.delete(key: ApiConstants.accessTokenKey);
    await secureStorage.delete(key: ApiConstants.refreshTokenKey);
  }
}
```

**Tại sao dùng FlutterSecureStorage?**
- ✅ **Encrypted:** Data được mã hóa trên device
- ✅ **Platform-specific:** 
  - iOS: Keychain
  - Android: EncryptedSharedPreferences
  - Web: Web Crypto API
- ✅ **Persistent:** Data tồn tại sau khi app restart

---

## 🔄 LUỒNG DỮ LIỆU NGƯỢC (Response Flow)

```
Backend API
   ↓ {accessToken, refreshToken}
AuthRemoteDataSourceImpl
   ↓ AuthTokensModel (Model)
AuthRepositoryImpl
   ├─→ AuthLocalDataSource.saveTokens() (Lưu storage)
   └─→ tokensModel.toEntity()
       ↓ AuthTokens (Entity)
       ↓ Right(AuthTokens)
LoginUseCase
   ↓ Either<Failure, AuthTokens>
AuthNotifier
   ↓ result.fold()
   ├─→ Left(failure) → Update state với error
   └─→ Right(tokens) → loadCurrentUser()
       ↓ state.user = currentUser
LoginScreen
   ↓ success == true
   ↓ Toasts.success() + context.go('/')
```

---

## 🎭 DEPENDENCY INJECTION (Riverpod Providers)

📁 **File:** `lib/features/auth/presentation/providers/auth_providers.dart`

```dart
// 1️⃣ Infrastructure providers
final httpClientProvider = Provider<http.Client>((ref) {
  return AuthHttpClient(
    client: http.Client(),
    secureStorage: ref.watch(secureStorageProvider),
  );
});

final secureStorageProvider = Provider<FlutterSecureStorage>((ref) {
  return const FlutterSecureStorage();
});

// 2️⃣ DataSource providers
final authRemoteDataSourceProvider = Provider<AuthRemoteDataSource>((ref) {
  return AuthRemoteDataSourceImpl(
    client: ref.watch(httpClientProvider),
  ) as AuthRemoteDataSource;
});

final authLocalDataSourceProvider = Provider<AuthLocalDataSource>((ref) {
  return AuthLocalDataSourceImpl(
    secureStorage: ref.watch(secureStorageProvider),
  ) as AuthLocalDataSource;
});

// 3️⃣ Repository provider
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepositoryImpl(
    remoteDataSource: ref.watch(authRemoteDataSourceProvider),
    localDataSource: ref.watch(authLocalDataSourceProvider),
  );
});

// 4️⃣ UseCase providers
final loginUseCaseProvider = Provider<LoginUseCase>((ref) {
  return LoginUseCase(ref.watch(authRepositoryProvider));
});

// 5️⃣ State provider
final authNotifierProvider = NotifierProvider<AuthNotifier, AuthState>(() {
  return AuthNotifier();
});
```

**Luồng dependency:**
```
AuthNotifier
  ↓ depends on
LoginUseCase
  ↓ depends on
AuthRepository (interface)
  ↓ implemented by
AuthRepositoryImpl
  ↓ depends on
AuthRemoteDataSource + AuthLocalDataSource (interfaces)
  ↓ implemented by
AuthRemoteDataSourceImpl + AuthLocalDataSourceImpl
  ↓ depends on
http.Client (AuthHttpClient) + FlutterSecureStorage
```

---

## ⚡ CÁC PATTERN ĐẶC BIỆT

### **1. Either Pattern (Functional Error Handling)**

```dart
// ❌ Traditional (throw exceptions)
Future<AuthTokens> login() async {
  if (error) throw Exception('Error');
  return tokens;
}

// ✅ Either Pattern
Future<Either<Failure, AuthTokens>> login() async {
  if (error) return Left(Failure.server(message: 'Error'));
  return Right(tokens);
}

// Sử dụng:
final result = await login();
result.fold(
  (failure) => print('Error: $failure'),
  (tokens) => print('Success: $tokens'),
);
```

**Lợi ích:**
- ✅ Bắt buộc xử lý error (compile-time safety)
- ✅ Không cần try-catch ở mọi nơi
- ✅ Type-safe error handling

---

### **2. Repository Pattern**

**Tại sao cần Repository?**

```dart
// ❌ Không có Repository - UI gọi API trực tiếp
class LoginScreen {
  void login() async {
    final response = await http.post(...); // Tight coupling
    final data = jsonDecode(response.body);
    await secureStorage.write(...);
  }
}

// ✅ Có Repository - Tách biệt
class LoginScreen {
  void login() async {
    final result = await repository.login(); // Abstraction
    // Repository tự xử lý API + Storage
  }
}
```

**Lợi ích:**
- ✅ **Single Source of Truth:** Tất cả data access qua Repository
- ✅ **Caching Strategy:** Repository quyết định cache/network
- ✅ **Testability:** Mock Repository dễ dàng

---

### **3. DataSource Pattern**

**Tại sao tách Remote và Local DataSource?**

```dart
// Repository orchestrates multiple data sources
class AuthRepositoryImpl {
  Future<Either<Failure, User>> getCurrentUser() async {
    // 1. Check cache first (Local DataSource)
    final cachedUser = await localDataSource.getCachedUser();
    if (cachedUser != null && !cachedUser.isExpired) {
      return Right(cachedUser);
    }

    // 2. Fetch from API (Remote DataSource)
    final user = await remoteDataSource.getCurrentUser();

    // 3. Update cache
    await localDataSource.cacheUser(user);

    return Right(user);
  }
}
```

**Lợi ích:**
- ✅ **Separation of Concerns:** Remote ≠ Local logic
- ✅ **Flexible:** Dễ thêm cache, offline mode
- ✅ **Testable:** Test riêng từng data source

---

## 🧪 TESTING STRATEGY

### **Unit Test UseCase:**
```dart
void main() {
  late LoginUseCase useCase;
  late MockAuthRepository mockRepository;

  setUp(() {
    mockRepository = MockAuthRepository();
    useCase = LoginUseCase(mockRepository);
  });

  test('should return AuthTokens when login successful', () async {
    // Arrange
    final tokens = AuthTokens(accessToken: 'xxx', refreshToken: 'yyy');
    when(mockRepository.login(any, any))
        .thenAnswer((_) async => Right(tokens));

    // Act
    final result = await useCase(usernameOrEmail: 'test', password: 'pass');

    // Assert
    expect(result, Right(tokens));
    verify(mockRepository.login('test', 'pass'));
  });
}
```

### **Mock DataSource để test Repository:**
```dart
class MockRemoteDataSource extends Mock implements AuthRemoteDataSource {}
class MockLocalDataSource extends Mock implements AuthLocalDataSource {}

void main() {
  test('should save tokens after successful login', () async {
    // Arrange
    final mockRemote = MockRemoteDataSource();
    final mockLocal = MockLocalDataSource();
    final repository = AuthRepositoryImpl(
      remoteDataSource: mockRemote,
      localDataSource: mockLocal,
    );

    // Act
    await repository.login(usernameOrEmail: 'test', password: 'pass');

    // Assert
    verify(mockLocal.saveTokens(any, any)).called(1);
  });
}
```

---

## 🎯 TÓM TẮT CÁC LAYER

| Layer | Trách nhiệm | Phụ thuộc vào | Ví dụ |
|-------|-------------|---------------|-------|
| **Presentation** | UI, State Management | Domain (UseCases) | LoginScreen, AuthNotifier |
| **Domain** | Business Logic, Contracts | KHÔNG phụ thuộc layer nào | LoginUseCase, AuthRepository interface |
| **Data** | Implementation, API, Storage | Domain (interfaces) | AuthRepositoryImpl, DataSources |
| **Infrastructure** | HTTP, Storage, 3rd party | - | AuthHttpClient, FlutterSecureStorage |

---

## 📊 SO SÁNH VỚI KIẾN TRÚC KHÁC

### **MVC (Traditional):**
```
View → Controller → Model → Database
      ↓ Tight coupling
```

### **Clean Architecture:**
```
UI → UseCase → Repository Interface ← Repository Impl → DataSource
     ↑                                                      ↓
     Domain (Pure Dart)                                 External
     Independent                                        (API, DB)
```

**Ưu điểm Clean Architecture:**
- ✅ Testable: Mỗi layer test riêng
- ✅ Maintainable: Thay đổi UI không ảnh hưởng Domain
- ✅ Scalable: Dễ thêm features mới
- ✅ Flexible: Swap implementation dễ dàng

---

## 🚀 KẾT LUẬN

Clean Architecture có vẻ phức tạp ban đầu, nhưng mang lại:

1. **Separation of Concerns:** Mỗi class chỉ làm 1 việc
2. **Dependency Rule:** Inner layers không biết outer layers
3. **Testability:** 100% code có thể test
4. **Maintainability:** Dễ hiểu, dễ sửa, dễ mở rộng
5. **Team Collaboration:** Nhiều người làm cùng lúc không conflict

**Golden Rule:** 
> "Dependencies point INWARD. Domain is the king!"

---

## 📚 TÀI LIỆU THAM KHẢO

- [Clean Architecture by Uncle Bob](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)
- [Flutter Clean Architecture](https://resocoder.com/flutter-clean-architecture-tdd/)
- [Riverpod Documentation](https://riverpod.dev/)

---

**Created:** October 15, 2025  
**Project:** Chattrix UI  
**Author:** Development Team

