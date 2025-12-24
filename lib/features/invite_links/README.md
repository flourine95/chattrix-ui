# Group Invite Links Feature

Complete implementation of group invite links functionality for Chattrix UI.

## 📁 Structure

```
lib/features/invite_links/
├── data/
│   ├── datasources/
│   │   └── remote/
│   │       └── invite_links_api_service.dart      # API service with 6 endpoints
│   ├── mappers/
│   │   └── invite_link_mapper.dart                # DTO ↔ Entity mappers
│   ├── models/
│   │   └── invite_link_dto.dart                   # Data Transfer Objects
│   └── repositories/
│       └── invite_links_repository_impl.dart      # Repository implementation
├── domain/
│   ├── entities/
│   │   └── invite_link_entity.dart                # Domain entities (3 types)
│   ├── repositories/
│   │   └── invite_links_repository.dart           # Repository interface
│   └── usecases/
│       ├── create_invite_link_usecase.dart        # Create link
│       ├── get_invite_links_usecase.dart          # List links (pagination)
│       ├── revoke_invite_link_usecase.dart        # Revoke link
│       ├── get_qr_code_usecase.dart               # Get QR code
│       ├── get_invite_link_info_usecase.dart      # Get public info
│       └── join_group_via_link_usecase.dart       # Join group
├── presentation/
│   ├── pages/
│   │   ├── invite_links_page.dart                 # Management page
│   │   └── invite_link_info_page.dart             # Public info page
│   ├── providers/
│   │   ├── invite_links_providers.dart            # Dependency injection
│   │   ├── invite_links_list_provider.dart        # List state
│   │   ├── create_invite_link_provider.dart       # Create state
│   │   ├── revoke_invite_link_provider.dart       # Revoke state
│   │   ├── invite_link_info_provider.dart         # Public info state
│   │   ├── join_group_provider.dart               # Join group state
│   │   └── invite_links_websocket_provider.dart   # Real-time updates
│   └── widgets/
│       ├── invite_link_card.dart                  # Link card widget
│       ├── create_invite_link_bottom_sheet.dart   # Create dialog
│       └── qr_code_dialog.dart                    # QR code display
├── DEEP_LINK_INTEGRATION.md                       # Deep link setup guide
└── README.md                                       # This file
```

## 🎯 Features

### For Group Admins
- ✅ Create invite links with optional expiry and max uses
- ✅ View all invite links for a group
- ✅ Revoke invite links
- ✅ Generate and share QR codes
- ✅ Copy link to clipboard
- ✅ Share link via system share sheet
- ✅ Real-time updates when links are created/revoked/used
- ✅ Cursor-based pagination for large lists
- ✅ Toggle show/hide revoked links

### For Users
- ✅ View public invite link info (group name, member count, creator)
- ✅ Join group via invite link
- ✅ See link status (active, expired, revoked, max uses reached)
- ✅ Deep link support (open links from anywhere)

## 🔌 API Endpoints

All endpoints are implemented in `InviteLinksApiService`:

1. **POST** `/v1/conversations/{conversationId}/invite-links` - Create invite link
2. **GET** `/v1/conversations/{conversationId}/invite-links` - List invite links (cursor pagination)
3. **DELETE** `/v1/invite-links/{linkId}` - Revoke invite link
4. **GET** `/v1/invite-links/{linkId}/qr-code` - Get QR code image
5. **GET** `/v1/invite-links/{token}` - Get invite link info (public, no auth)
6. **POST** `/v1/invite-links/{token}` - Join group via invite link

## 🏗️ Architecture

### Clean Architecture Layers

**Data Layer:**
- DTOs for API communication
- Mappers for DTO ↔ Entity conversion
- API service for HTTP requests
- Repository implementation with error handling

**Domain Layer:**
- Pure entities (framework-agnostic)
- Repository interface
- Use cases with business logic validation

**Presentation Layer:**
- Riverpod 3 providers with code generation
- UI pages and widgets
- WebSocket real-time updates

### Error Handling

Uses `Either<Failure, T>` from `fpdart` for explicit error handling:

```dart
final result = await useCase(params);
result.fold(
  (failure) => // Handle error
  (data) => // Handle success
);
```

### State Management

Riverpod 3 with code generation:

```dart
@riverpod
class InviteLinksList extends _$InviteLinksList {
  // Cursor-based pagination
  // Real-time updates via WebSocket
}
```

## 🚀 Usage

### Navigate to Invite Links Page

From Chat Info page:

```dart
context.push(
  RoutePaths.inviteLinks,
  extra: {
    'conversationId': conversationId,
    'conversationName': conversationName,
  },
);
```

### Open Public Invite Link

```dart
context.go('/invite/$token');
```

### Handle Deep Links

```dart
// Custom scheme: chattrix://invite/{token}
// Universal link: https://chattrix.app/invite/{token}

final route = DeepLinkService.handleDeepLink(uri);
if (route != null) {
  router.go(route);
}
```

## 🔄 Real-Time Updates

WebSocket events are automatically handled:

- `invite_link.created` - New link created
- `invite_link.revoked` - Link revoked
- `invite_link.used` - Link used to join group

The list automatically refreshes when events are received.

## 🎨 UI Components

### InviteLinksPage
Main management page with:
- List of invite links
- Pull to refresh
- Pagination
- Toggle revoked links
- FAB to create new link

### InviteLinkCard
Card displaying:
- Link token
- Creator info
- Created date
- Expiry date
- Max uses / current uses
- Status chip
- Action buttons (copy, share, QR, revoke)

### CreateInviteLinkBottomSheet
Bottom sheet with:
- Expiry time picker (quick options + custom)
- Max uses input
- Create button

### QRCodeDialog
Dialog displaying:
- QR code image
- Save to gallery button
- Share button
- Loading/error states

### InviteLinkInfoPage
Public page showing:
- Group avatar
- Group name
- Member count
- Invite info (creator, dates, limits)
- Join button
- Invalid link warnings

## 📱 Deep Links

See `DEEP_LINK_INTEGRATION.md` for complete setup guide.

**Supported formats:**
- `chattrix://invite/{token}` - Custom scheme
- `https://chattrix.app/invite/{token}` - Universal link

**Platform configuration required:**
- Android: Intent filters in AndroidManifest.xml
- iOS: URL schemes in Info.plist
- Web: Host verification files

## 🧪 Testing

### Manual Testing

1. **Create Link:**
   - Open group chat → Info → Invite Links
   - Tap FAB → Set expiry/max uses → Create
   - Verify link appears in list

2. **Share Link:**
   - Tap link card → Copy/Share
   - Verify link is copied/shared

3. **QR Code:**
   - Tap QR icon → View QR code
   - Save to gallery → Verify saved
   - Share → Verify shared

4. **Revoke Link:**
   - Tap revoke → Confirm
   - Verify link status changes

5. **Join via Link:**
   - Open link in browser/another device
   - Verify group info displayed
   - Tap join → Verify joined group

6. **Real-Time Updates:**
   - Open invite links page on two devices
   - Create/revoke link on one device
   - Verify other device updates automatically

### Unit Testing

```dart
// Test repository
test('should return entity when API call succeeds', () async {
  when(mockApiService.createInviteLink(...))
      .thenAnswer((_) async => mockResponse);
  
  final result = await repository.createInviteLink(...);
  
  expect(result.isRight(), true);
});

// Test use case
test('should return ValidationFailure for invalid input', () async {
  final result = await useCase(conversationId: -1);
  
  expect(result.isLeft(), true);
  result.fold(
    (failure) => expect(failure, isA<ValidationFailure>()),
    (_) => fail('Should not succeed'),
  );
});
```

## 📚 Dependencies

```yaml
dependencies:
  # State Management
  hooks_riverpod: ^3.0.3
  riverpod_annotation: ^3.0.3
  flutter_hooks: ^0.21.3
  
  # Functional Programming
  fpdart: ^1.2.0
  
  # Data Serialization
  freezed_annotation: ^3.0.0
  json_annotation: ^4.9.0
  
  # Networking
  dio: ^5.9.0
  
  # Sharing
  share_plus: ^7.2.1
  image_gallery_saver: ^2.0.3
  
  # Routing
  go_router: ^13.0.0

dev_dependencies:
  # Code Generation
  build_runner: ^2.7.1
  freezed: ^3.2.3
  json_serializable: ^6.7.1
  riverpod_generator: ^3.0.3
  riverpod_lint: ^3.0.3
```

## 🔧 Development

### Generate Code

After modifying entities, DTOs, or providers:

```bash
dart run build_runner build --delete-conflicting-outputs
```

### Add New Endpoint

1. Add DTO in `data/models/`
2. Add mapper in `data/mappers/`
3. Add method in `InviteLinksApiService`
4. Add method in repository interface and implementation
5. Create use case in `domain/usecases/`
6. Create provider in `presentation/providers/`
7. Use in UI

## 🐛 Troubleshooting

### Build errors after changes
```bash
flutter clean
flutter pub get
dart run build_runner build --delete-conflicting-outputs
```

### WebSocket not updating
- Check WebSocket connection is active
- Verify event types match backend
- Check provider is watched in UI

### Deep links not working
- See `DEEP_LINK_INTEGRATION.md`
- Verify platform configuration
- Test with adb/xcrun commands

## 📖 References

- [API Integration Guide](../../API-INTEGRATION-GUIDE.md)
- [Deep Link Integration](./DEEP_LINK_INTEGRATION.md)
- [Implementation Status](../../.kiro/specs/group-invite-links/IMPLEMENTATION_STATUS.md)
- [Riverpod 3 Standards](../../.kiro/steering/riverpod_3_prompt.md)
- [Tech Stack](../../.kiro/steering/tech.md)

## 👥 Contributing

When adding features:
1. Follow Clean Architecture principles
2. Use Riverpod 3 with code generation
3. Implement proper error handling with Either
4. Add Vietnamese UI text
5. Support dark mode
6. Write tests
7. Update documentation

## 📄 License

Part of Chattrix UI project.
