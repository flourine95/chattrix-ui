---
inclusion: always
---
# ⚙️ Technology Stack and Development Standards

This document defines the mandatory frameworks, libraries, and architectural rules for the Chattrix UI project. Kiro MUST strictly adhere to these guidelines.

## 1. Architectural Mandates (Clean Architecture)

1.  **Layer Separation:** The project MUST follow the Clean Architecture principles (Presentation, Domain, Data). 

[Image of the Clean Architecture layers]

2.  **Domain Purity:** The **Domain Layer** is the core and MUST be kept **framework-agnostic**. It is FORBIDDEN to import Flutter, Dio, or any serialization libraries (`freezed_annotation`, `json_annotation`) into the `lib/domain/` directory.
3.  **Dependency Rule:** Dependencies MUST only flow inwards: **Presentation -> Domain -> Data**. Data Layer MUST only expose abstractions (interfaces) to the Domain Layer.
4.  **Error Handling:** All asynchronous operations returning data from the Domain/Data layers MUST use the **`Either<Failure, T>`** type from **`dartz`** for explicit error handling.

---

## 2. State Management and Logic (Riverpod v3)

**Goal:** Utilize Riverpod v3's Code Generation for safety, performance, and maintainability.

| Library | Rule | Best Practice |
| :--- | :--- | :--- |
| **Riverpod** | MUST use **`hooks_riverpod`** (`v3.x`) and **`flutter_hooks`**. | Use **`HookConsumerWidget`** for all screens and stateful components. |
| **Code Generation** | ALL providers MUST be declared using the **`@riverpod`** annotation and the appropriate Notifier class. Manual provider declaration is FORBIDDEN. | Run `dart run build_runner build --delete-conflicting-outputs` after changing any model or provider. |
| **Notifier Classes** | - **Synchronous/Simple State:** Use **`Notifier<T>`** or **`FamilyNotifier<T, Arg>`**. - **Asynchronous/Future State:** Use **`AsyncNotifier<T>`** or **`AsyncFamilyNotifier<T, Arg>`**. | The `build()` method of `AsyncNotifier` MUST return a `Future<T>`, which is automatically wrapped in `AsyncValue`. |
| **State Consumption** | When consuming an `AsyncValue` (e.g., via `ref.watch(provider)`), UI code MUST use the **`switch` expression** (Pattern Matching) to explicitly handle `loading`, `error`, and `data` states.  | Avoid the deprecated `.when()` extension where possible, preferring Dart's built-in `switch` syntax. |

---

## 3. Data Modeling and Persistence

**Goal:** Ensure data immutability and standardized serialization for API communication.

| Library | Rule | Usage |
| :--- | :--- | :--- |
| **Immutability** | ALL Entities (Domain) and Models (Data) MUST be defined using **`freezed`**. | Classes MUST be declared with the **`abstract class`** keyword to ensure proper code generation and prevent direct instantiation. |
| **Serialization** | MUST use **`json_serializable`** for all Data Transfer Objects (DTOs) in the Data Layer. | Serialization logic (`@JsonSerializable`) MUST NOT leak into the Domain Layer Entities. |
| **Error Handling** | The `analysis_options.yaml` file MUST include the rule to **ignore** the `invalid_annotation_target` warning to resolve conflicts between `freezed` and `json_serializable`. | `analyzer: errors: invalid_annotation_target: ignore` |
| **Storage** | **`flutter_secure_storage`** MUST be used for storing sensitive data (e.g., `accessToken`, `refreshToken`). | Avoid storing credentials in local preferences or unencrypted storage. |

---

## 4. Networking, Routing, and External Services

| Area | Library/Tool | Rule |
| :--- | :--- | :--- |
| **HTTP Client** | **`dio`** | MUST be used for all REST API communication. Headers and configuration MUST be managed via a dedicated `DioProvider` in the Data Layer. |
| **Real-time** | **`web_socket_channel`** | Use for WebSocket connections. The connection logic should reside in a Repository implementation. |
| **Routing** | **`go_router`** | ALL navigation MUST be managed through named routes or path definitions provided by `go_router`. Avoid using basic `Navigator.push/pop`. |
| **Media Handling** | **`image_picker`**, **`record`**, **`file_picker`** | Before initiating media capture or file access, the required permission MUST be checked using **`permission_handler`**. |
| **File Upload** | **`cloudinary_public`** | MUST be used as the service client for file uploads. Images MUST be optimized (compressed) using **`flutter_image_compress`** before upload. |
| **Configuration** | **`flutter_dotenv`** | ALL environment-specific variables and API endpoints MUST be loaded and accessed via `.env` files. Hardcoding credentials is FORBIDDEN. |

---

## 5. Utilities and Debugging

Area,Library/Tool,Rule
Debugging Print,debugPrint(),"When adding temporary logs, developers MUST use debugPrint() from flutter/foundation.dart. The use of print() and debug() is FORBIDDEN."
