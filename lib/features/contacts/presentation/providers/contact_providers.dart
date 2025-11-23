import 'package:chattrix_ui/core/errors/failures.dart';
import 'package:chattrix_ui/features/auth/presentation/providers/auth_providers.dart';
import 'package:chattrix_ui/features/contacts/data/datasources/contact_remote_datasource_impl.dart';
import 'package:chattrix_ui/features/contacts/data/repositories/contact_repository_impl.dart';
import 'package:chattrix_ui/features/contacts/domain/datasources/contact_remote_datasource.dart';
import 'package:chattrix_ui/features/contacts/domain/entities/contact.dart';
import 'package:chattrix_ui/features/contacts/domain/entities/friend_request.dart';
import 'package:chattrix_ui/features/contacts/domain/repositories/contact_repository.dart';
import 'package:chattrix_ui/features/contacts/domain/usecases/accept_friend_request_usecase.dart';
import 'package:chattrix_ui/features/contacts/domain/usecases/cancel_friend_request_usecase.dart';
import 'package:chattrix_ui/features/contacts/domain/usecases/get_contacts_usecase.dart';
import 'package:chattrix_ui/features/contacts/domain/usecases/get_received_friend_requests_usecase.dart';
import 'package:chattrix_ui/features/contacts/domain/usecases/get_sent_friend_requests_usecase.dart';
import 'package:chattrix_ui/features/contacts/domain/usecases/reject_friend_request_usecase.dart';
import 'package:chattrix_ui/features/contacts/domain/usecases/send_friend_request_usecase.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Data source providers
final contactRemoteDataSourceProvider = Provider<ContactRemoteDataSource>((ref) {
  return ContactRemoteDataSourceImpl(dio: ref.watch(dioProvider));
});

// Repository provider
final contactRepositoryProvider = Provider<ContactRepository>((ref) {
  return ContactRepositoryImpl(remoteDataSource: ref.watch(contactRemoteDataSourceProvider));
});

// Use case providers
final getContactsUseCaseProvider = Provider<GetContactsUseCase>((ref) {
  return GetContactsUseCase(ref.watch(contactRepositoryProvider));
});

final sendFriendRequestUseCaseProvider = Provider<SendFriendRequestUseCase>((ref) {
  return SendFriendRequestUseCase(ref.watch(contactRepositoryProvider));
});

final getReceivedFriendRequestsUseCaseProvider = Provider<GetReceivedFriendRequestsUseCase>((ref) {
  return GetReceivedFriendRequestsUseCase(ref.watch(contactRepositoryProvider));
});

final getSentFriendRequestsUseCaseProvider = Provider<GetSentFriendRequestsUseCase>((ref) {
  return GetSentFriendRequestsUseCase(ref.watch(contactRepositoryProvider));
});

final acceptFriendRequestUseCaseProvider = Provider<AcceptFriendRequestUseCase>((ref) {
  return AcceptFriendRequestUseCase(ref.watch(contactRepositoryProvider));
});

final rejectFriendRequestUseCaseProvider = Provider<RejectFriendRequestUseCase>((ref) {
  return RejectFriendRequestUseCase(ref.watch(contactRepositoryProvider));
});

final cancelFriendRequestUseCaseProvider = Provider<CancelFriendRequestUseCase>((ref) {
  return CancelFriendRequestUseCase(ref.watch(contactRepositoryProvider));
});

// Contact state class
class ContactState {
  final List<Contact> contacts;
  final List<FriendRequest> receivedRequests;
  final List<FriendRequest> sentRequests;
  final bool isLoading;
  final String? errorMessage;

  ContactState({
    this.contacts = const [],
    this.receivedRequests = const [],
    this.sentRequests = const [],
    this.isLoading = false,
    this.errorMessage,
  });

  ContactState copyWith({
    List<Contact>? contacts,
    List<FriendRequest>? receivedRequests,
    List<FriendRequest>? sentRequests,
    bool? isLoading,
    String? errorMessage,
    bool clearError = false,
  }) {
    return ContactState(
      contacts: contacts ?? this.contacts,
      receivedRequests: receivedRequests ?? this.receivedRequests,
      sentRequests: sentRequests ?? this.sentRequests,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }
}

// Contact notifier
class ContactNotifier extends Notifier<ContactState> {
  @override
  ContactState build() {
    return ContactState();
  }

  String _getFailureMessage(Failure failure) {
    return failure.when(
      server: (message, errorCode) => message,
      network: (message) => 'Không có kết nối mạng. Vui lòng kiểm tra lại.',
      validation: (message, errors) {
        if (errors != null && errors.isNotEmpty) {
          return errors.map((e) => e.message).join(', ');
        }
        return message;
      },
      unauthorized: (message, errorCode) => message,
      badRequest: (message, errorCode) => message,
      forbidden: (message, errorCode) => message,
      notFound: (message, errorCode) => message,
      conflict: (message, errorCode) => message,
      rateLimitExceeded: (message) => 'Quá nhiều yêu cầu. Vui lòng thử lại sau.',
      unknown: (message) => message,
      permission: (message) => message,
      agoraEngine: (message, code) => message,
      tokenExpired: (message) => message,
      channelJoin: (message) => message,
      webSocketNotConnected: (message) => message,
      webSocketSendFailed: (message) => message,
      callNotFound: (message) => message,
      callAlreadyActive: (message) => message,
    );
  }

  Future<void> loadContacts() async {
    state = state.copyWith(isLoading: true, clearError: true);

    final result = await ref.read(getContactsUseCaseProvider)();

    result.fold(
      (failure) {
        state = state.copyWith(isLoading: false, errorMessage: _getFailureMessage(failure));
      },
      (contacts) {
        state = state.copyWith(isLoading: false, contacts: contacts);
      },
    );
  }

  Future<void> loadReceivedFriendRequests() async {
    final result = await ref.read(getReceivedFriendRequestsUseCaseProvider)();

    result.fold(
      (failure) {
        state = state.copyWith(errorMessage: _getFailureMessage(failure));
      },
      (requests) {
        state = state.copyWith(receivedRequests: requests);
      },
    );
  }

  Future<void> loadSentFriendRequests() async {
    final result = await ref.read(getSentFriendRequestsUseCaseProvider)();

    result.fold(
      (failure) {
        state = state.copyWith(errorMessage: _getFailureMessage(failure));
      },
      (requests) {
        state = state.copyWith(sentRequests: requests);
      },
    );
  }

  Future<bool> sendFriendRequest({required int receiverUserId, String? nickname}) async {
    state = state.copyWith(isLoading: true, clearError: true);

    final result = await ref.read(sendFriendRequestUseCaseProvider)(receiverUserId: receiverUserId, nickname: nickname);

    return result.fold(
      (failure) {
        state = state.copyWith(isLoading: false, errorMessage: _getFailureMessage(failure));
        return false;
      },
      (friendRequest) {
        state = state.copyWith(isLoading: false, sentRequests: [...state.sentRequests, friendRequest]);
        return true;
      },
    );
  }

  Future<bool> acceptFriendRequest(int requestId) async {
    state = state.copyWith(isLoading: true, clearError: true);

    final result = await ref.read(acceptFriendRequestUseCaseProvider)(friendRequestId: requestId);

    return result.fold(
      (failure) {
        state = state.copyWith(isLoading: false, errorMessage: _getFailureMessage(failure));
        return false;
      },
      (_) {
        // Remove from received requests and reload contacts
        state = state.copyWith(
          isLoading: false,
          receivedRequests: state.receivedRequests.where((request) => request.id != requestId).toList(),
        );
        loadContacts();
        return true;
      },
    );
  }

  Future<bool> rejectFriendRequest(int requestId) async {
    state = state.copyWith(isLoading: true, clearError: true);

    final result = await ref.read(rejectFriendRequestUseCaseProvider)(friendRequestId: requestId);

    return result.fold(
      (failure) {
        state = state.copyWith(isLoading: false, errorMessage: _getFailureMessage(failure));
        return false;
      },
      (_) {
        // Remove from received requests
        state = state.copyWith(
          isLoading: false,
          receivedRequests: state.receivedRequests.where((request) => request.id != requestId).toList(),
        );
        return true;
      },
    );
  }

  Future<bool> cancelFriendRequest(int requestId) async {
    state = state.copyWith(isLoading: true, clearError: true);

    final result = await ref.read(cancelFriendRequestUseCaseProvider)(friendRequestId: requestId);

    return result.fold(
      (failure) {
        state = state.copyWith(isLoading: false, errorMessage: _getFailureMessage(failure));
        return false;
      },
      (_) {
        // Remove from sent requests
        state = state.copyWith(
          isLoading: false,
          sentRequests: state.sentRequests.where((request) => request.id != requestId).toList(),
        );
        return true;
      },
    );
  }
}

// Contact provider
final contactProvider = NotifierProvider<ContactNotifier, ContactState>(() {
  return ContactNotifier();
});
