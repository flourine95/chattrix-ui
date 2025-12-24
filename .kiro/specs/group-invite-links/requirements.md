# Requirements Document - Group Invite Links

## Introduction

Tính năng Group Invite Links cho phép admin và thành viên tạo link mời để chia sẻ với người khác, giúp họ tham gia nhóm chat một cách dễ dàng. Tính năng này bao gồm quản lý link (tạo, xem, thu hồi), tạo QR code, và xem thông tin link công khai.

## Glossary

- **Invite_Link**: Link mời vào nhóm chat, có thể có thời gian hết hạn và giới hạn số lần sử dụng
- **Token**: Mã định danh duy nhất của invite link
- **Creator**: Người tạo invite link
- **Admin**: Quản trị viên nhóm, có quyền tạo và thu hồi bất kỳ link nào
- **Member**: Thành viên nhóm, có quyền tạo link nhưng chỉ thu hồi link do mình tạo
- **QR_Code**: Mã QR chứa thông tin invite link để quét và tham gia
- **Conversation**: Cuộc trò chuyện nhóm
- **System**: Ứng dụng Chattrix

## Requirements

### Requirement 1: Tạo Invite Link

**User Story:** Là admin hoặc member của nhóm, tôi muốn tạo link mời vào nhóm với các tùy chọn về thời gian hết hạn và số lần sử dụng, để có thể chia sẻ với người khác một cách linh hoạt.

#### Acceptance Criteria

1. WHEN một admin hoặc member tạo invite link THEN THE System SHALL gọi API `POST /v1/invite-links/conversations/{conversationId}` với thông tin thời gian hết hạn và số lần sử dụng tối đa
2. WHEN API trả về thành công THEN THE System SHALL hiển thị thông tin link mới tạo bao gồm token, thời gian hết hạn, và số lần sử dụng
3. WHEN người dùng không chọn thời gian hết hạn THEN THE System SHALL gửi `expiresIn: null` để tạo link không giới hạn thời gian
4. WHEN người dùng không chọn số lần sử dụng tối đa THEN THE System SHALL gửi `maxUses: null` để tạo link không giới hạn số lần
5. WHEN API trả về lỗi 403 THEN THE System SHALL hiển thị thông báo "Bạn không có quyền tạo link mời"
6. WHEN API trả về lỗi 404 THEN THE System SHALL hiển thị thông báo "Không tìm thấy nhóm chat"

### Requirement 2: Xem Danh Sách Invite Links

**User Story:** Là admin hoặc member của nhóm, tôi muốn xem tất cả các invite link đã tạo cho nhóm, để quản lý và theo dõi các link đang hoạt động.

#### Acceptance Criteria

1. WHEN người dùng mở danh sách invite links THEN THE System SHALL gọi API `GET /v1/invite-links/conversations/{conversationId}` với cursor-based pagination
2. WHEN API trả về thành công THEN THE System SHALL hiển thị danh sách các link với thông tin: token, người tạo, thời gian tạo, thời gian hết hạn, số lần đã sử dụng/tối đa, trạng thái
3. WHEN người dùng cuộn đến cuối danh sách và `hasNextPage` là true THEN THE System SHALL tự động load thêm dữ liệu với `nextCursor`
4. WHEN người dùng bật tùy chọn "Hiển thị link đã thu hồi" THEN THE System SHALL gọi API với `includeRevoked=true`
5. WHEN link đã hết hạn hoặc đạt giới hạn sử dụng THEN THE System SHALL hiển thị trạng thái "Không còn hiệu lực"
6. WHEN link đã bị thu hồi THEN THE System SHALL hiển thị trạng thái "Đã thu hồi" và thông tin người thu hồi

### Requirement 3: Thu Hồi Invite Link

**User Story:** Là admin hoặc creator của link, tôi muốn thu hồi invite link, để ngăn người khác sử dụng link đó tham gia nhóm.

#### Acceptance Criteria

1. WHEN admin hoặc creator chọn thu hồi link THEN THE System SHALL hiển thị dialog xác nhận "Bạn có chắc muốn thu hồi link này?"
2. WHEN người dùng xác nhận thu hồi THEN THE System SHALL gọi API `DELETE /v1/invite-links/conversations/{conversationId}/links/{linkId}`
3. WHEN API trả về thành công THEN THE System SHALL cập nhật trạng thái link thành "Đã thu hồi" và hiển thị thông báo "Thu hồi link thành công"
4. WHEN API trả về lỗi 403 THEN THE System SHALL hiển thị thông báo "Bạn không có quyền thu hồi link này"
5. WHEN API trả về lỗi 404 THEN THE System SHALL hiển thị thông báo "Không tìm thấy link"
6. WHEN link đã được thu hồi THEN THE System SHALL vô hiệu hóa nút "Thu hồi"

### Requirement 4: Tạo và Hiển Thị QR Code

**User Story:** Là người có invite link, tôi muốn tạo QR code cho link đó, để người khác có thể quét mã và tham gia nhóm dễ dàng.

#### Acceptance Criteria

1. WHEN người dùng chọn "Tạo QR Code" cho một link THEN THE System SHALL gọi API `GET /v1/invite-links/conversations/{conversationId}/links/{linkId}/qr`
2. WHEN API trả về ảnh PNG THEN THE System SHALL hiển thị QR code trong dialog hoặc bottom sheet
3. WHEN người dùng chọn kích thước QR code THEN THE System SHALL gọi API với query parameter `size` tương ứng
4. WHEN người dùng chọn "Lưu QR Code" THEN THE System SHALL lưu ảnh PNG vào thư viện ảnh của thiết bị
5. WHEN người dùng chọn "Chia sẻ QR Code" THEN THE System SHALL mở share sheet với ảnh QR code
6. WHEN API trả về lỗi THEN THE System SHALL hiển thị thông báo "Không thể tạo QR code"

### Requirement 5: Xem Thông Tin Link Mời (Public)

**User Story:** Là người nhận được invite link, tôi muốn xem thông tin về nhóm trước khi tham gia, để quyết định có muốn tham gia hay không.

#### Acceptance Criteria

1. WHEN người dùng mở link mời (deep link hoặc URL) THEN THE System SHALL gọi API `GET /v1/invite-links/{token}` không cần authentication
2. WHEN API trả về thành công THEN THE System SHALL hiển thị thông tin: tên nhóm, số thành viên, người tạo link, thời gian hết hạn
3. WHEN link còn hiệu lực THEN THE System SHALL hiển thị nút "Tham gia nhóm"
4. WHEN link đã hết hạn hoặc đạt giới hạn THEN THE System SHALL hiển thị thông báo "Link này đã hết hiệu lực"
5. WHEN API trả về lỗi 404 THEN THE System SHALL hiển thị thông báo "Link không tồn tại hoặc đã bị xóa"
6. WHEN người dùng chưa đăng nhập THEN THE System SHALL hiển thị nút "Đăng nhập để tham gia"

### Requirement 6: Tham Gia Nhóm Qua Link

**User Story:** Là người dùng đã đăng nhập, tôi muốn tham gia nhóm thông qua invite link, để trở thành thành viên của nhóm đó.

#### Acceptance Criteria

1. WHEN người dùng đã đăng nhập chọn "Tham gia nhóm" THEN THE System SHALL gọi API `POST /v1/invite-links/{token}` với authentication token
2. WHEN API trả về thành công THEN THE System SHALL hiển thị thông báo "Tham gia nhóm thành công" và chuyển đến màn hình chat của nhóm
3. WHEN người dùng đã là thành viên nhóm THEN THE System SHALL chuyển trực tiếp đến màn hình chat
4. WHEN API trả về lỗi 400 THEN THE System SHALL hiển thị thông báo "Link đã hết hạn hoặc đạt giới hạn sử dụng"
5. WHEN API trả về lỗi 404 THEN THE System SHALL hiển thị thông báo "Link không tồn tại"
6. WHEN API trả về lỗi 401 THEN THE System SHALL chuyển đến màn hình đăng nhập

### Requirement 7: Sao Chép và Chia Sẻ Link

**User Story:** Là người có invite link, tôi muốn sao chép hoặc chia sẻ link, để gửi cho người khác qua các kênh khác nhau.

#### Acceptance Criteria

1. WHEN người dùng chọn "Sao chép link" THEN THE System SHALL sao chép URL đầy đủ của invite link vào clipboard
2. WHEN sao chép thành công THEN THE System SHALL hiển thị thông báo "Đã sao chép link"
3. WHEN người dùng chọn "Chia sẻ link" THEN THE System SHALL mở share sheet với URL của invite link
4. THE System SHALL định dạng URL theo pattern: `https://chattrix.app/invite/{token}`
5. WHEN người dùng chọn "Chia sẻ QR Code" THEN THE System SHALL mở share sheet với ảnh QR code
6. WHEN clipboard không khả dụng THEN THE System SHALL hiển thị thông báo lỗi

### Requirement 8: Quản Lý Quyền Truy Cập

**User Story:** Là hệ thống, tôi cần kiểm soát quyền truy cập các chức năng invite link, để đảm bảo chỉ người có quyền mới thực hiện được các thao tác.

#### Acceptance Criteria

1. THE System SHALL cho phép cả admin và member tạo invite link
2. THE System SHALL chỉ cho phép admin thu hồi bất kỳ link nào
3. THE System SHALL cho phép creator thu hồi link do chính họ tạo
4. THE System SHALL cho phép tất cả thành viên xem danh sách invite links
5. THE System SHALL cho phép bất kỳ ai (kể cả chưa đăng nhập) xem thông tin link mời
6. THE System SHALL yêu cầu đăng nhập để tham gia nhóm qua link

### Requirement 9: Xử Lý Lỗi và Trạng Thái

**User Story:** Là người dùng, tôi muốn nhận được thông báo rõ ràng khi có lỗi xảy ra, để biết cách xử lý.

#### Acceptance Criteria

1. WHEN mất kết nối mạng THEN THE System SHALL hiển thị thông báo "Không có kết nối mạng"
2. WHEN API timeout THEN THE System SHALL hiển thị thông báo "Kết nối quá chậm, vui lòng thử lại"
3. WHEN server trả về lỗi 500 THEN THE System SHALL hiển thị thông báo "Lỗi server, vui lòng thử lại sau"
4. WHEN đang load dữ liệu THEN THE System SHALL hiển thị loading indicator
5. WHEN danh sách rỗng THEN THE System SHALL hiển thị "Chưa có link mời nào"
6. WHEN có lỗi không xác định THEN THE System SHALL hiển thị thông báo lỗi chung và log chi tiết

### Requirement 10: Deep Link và URL Handling

**User Story:** Là người dùng, tôi muốn có thể mở invite link từ bất kỳ đâu (SMS, email, browser), để tham gia nhóm một cách thuận tiện.

#### Acceptance Criteria

1. WHEN người dùng click vào URL invite link từ bên ngoài app THEN THE System SHALL mở app và hiển thị thông tin link
2. WHEN app chưa cài đặt THEN THE System SHALL mở web view hoặc chuyển đến app store
3. WHEN app đang mở THEN THE System SHALL navigate đến màn hình invite link info
4. THE System SHALL hỗ trợ deep link format: `chattrix://invite/{token}`
5. THE System SHALL hỗ trợ universal link format: `https://chattrix.app/invite/{token}`
6. WHEN token không hợp lệ THEN THE System SHALL hiển thị thông báo lỗi
