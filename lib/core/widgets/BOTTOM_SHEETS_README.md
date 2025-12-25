# Reusable Bottom Sheets

Thư viện các bottom sheet components có thể tái sử dụng với thiết kế đẹp và consistent.

## 📦 Import

```dart
import 'package:chattrix_ui/core/widgets/bottom_sheets.dart';
```

## 🎨 Available Bottom Sheets

### 1. Confirmation Bottom Sheet (Yes/No)

Bottom sheet xác nhận với 2 nút Yes/No, có icon và màu sắc tùy chỉnh.

```dart
final result = await showConfirmationBottomSheet(
  context: context,
  title: 'Leave Group?',
  message: 'Are you sure you want to leave this group?',
  confirmText: 'Leave',
  cancelText: 'Cancel',
  icon: Icons.exit_to_app,
  isDangerous: true, // Red color for dangerous actions
);

if (result == true) {
  // User confirmed
}
```

**Parameters:**
- `title` (required): Tiêu đề
- `message` (required): Nội dung thông báo
- `confirmText`: Text nút xác nhận (default: 'Confirm')
- `cancelText`: Text nút hủy (default: 'Cancel')
- `icon`: Icon hiển thị
- `iconColor`: Màu icon
- `confirmColor`: Màu nút confirm
- `isDangerous`: `true` để hiển thị màu đỏ (cho hành động nguy hiểm)

**Returns:** `bool?` - `true` nếu confirm, `false` nếu cancel, `null` nếu dismiss

---

### 2. Input Bottom Sheet

Bottom sheet với text field để nhập liệu, có validation.

```dart
final result = await showInputBottomSheet(
  context: context,
  title: 'Rename Group',
  subtitle: 'Enter a new name for this group',
  initialValue: 'My Group',
  labelText: 'Group Name',
  hintText: 'Enter group name',
  maxLength: 50,
  prefixIcon: Icons.group,
  validator: (value) {
    if (value == null || value.isEmpty) {
      return 'Group name cannot be empty';
    }
    return null;
  },
);

if (result != null) {
  // User entered: result
}
```

**Parameters:**
- `title` (required): Tiêu đề
- `subtitle`: Phụ đề
- `initialValue`: Giá trị ban đầu
- `hintText`: Placeholder text
- `labelText`: Label của text field
- `confirmText`: Text nút xác nhận (default: 'Save')
- `cancelText`: Text nút hủy (default: 'Cancel')
- `maxLines`: Số dòng tối đa
- `maxLength`: Độ dài tối đa
- `keyboardType`: Loại bàn phím
- `validator`: Function validation `String? Function(String?)`
- `prefixIcon`: Icon prefix

**Returns:** `String?` - Text đã nhập nếu confirm, `null` nếu cancel

---

### 3. Time Picker Bottom Sheet (iOS Style)

Bottom sheet chọn thời gian kiểu iOS với quick select options.

```dart
final result = await showTimePickerBottomSheet(
  context: context,
  title: 'Schedule Message',
  initialTime: DateTime.now().add(Duration(hours: 1)),
  quickOptions: [
    QuickTimeOption(label: '5 min', minutes: 5),
    QuickTimeOption(label: '15 min', minutes: 15),
    QuickTimeOption(label: '30 min', minutes: 30),
    QuickTimeOption(label: '1 hour', minutes: 60),
    QuickTimeOption(label: '2 hours', minutes: 120),
    QuickTimeOption(label: '1 day', minutes: 1440),
  ],
);

if (result != null) {
  // User selected: result (DateTime)
}
```

**Parameters:**
- `initialTime`: Thời gian ban đầu
- `title`: Tiêu đề (default: 'Select Time')
- `confirmText`: Text nút xác nhận (default: 'Done')
- `cancelText`: Text nút hủy (default: 'Cancel')
- `quickOptions`: List các option nhanh `List<QuickTimeOption>`

**Returns:** `DateTime?` - Thời gian đã chọn nếu confirm, `null` nếu cancel

---

### 4. Date Picker Bottom Sheet (iOS Style)

Bottom sheet chọn ngày kiểu iOS.

```dart
final result = await showDatePickerBottomSheet(
  context: context,
  title: 'Select Birthday',
  initialDate: DateTime.now(),
  minimumDate: DateTime(1900),
  maximumDate: DateTime.now(),
  mode: CupertinoDatePickerMode.date, // date, dateAndTime, time
);

if (result != null) {
  // User selected: result (DateTime)
}
```

**Parameters:**
- `initialDate`: Ngày ban đầu
- `minimumDate`: Ngày tối thiểu
- `maximumDate`: Ngày tối đa
- `title`: Tiêu đề (default: 'Select Date')
- `confirmText`: Text nút xác nhận (default: 'Done')
- `cancelText`: Text nút hủy (default: 'Cancel')
- `mode`: Chế độ picker (date, dateAndTime, time)

**Returns:** `DateTime?` - Ngày đã chọn nếu confirm, `null` nếu cancel

---

### 5. Options Bottom Sheet

Bottom sheet với danh sách các options để chọn.

```dart
final result = await showOptionsBottomSheet<String>(
  context: context,
  title: 'Member Options',
  subtitle: 'Choose an action for this member',
  options: [
    BottomSheetOption(
      label: 'View Profile',
      icon: Icons.person,
      value: 'profile',
    ),
    BottomSheetOption(
      label: 'Make Admin',
      icon: Icons.admin_panel_settings,
      value: 'admin',
    ),
    BottomSheetOption(
      label: 'Remove from Group',
      icon: Icons.person_remove,
      iconColor: Colors.red,
      value: 'remove',
      isDangerous: true,
    ),
  ],
);

if (result != null) {
  // User selected: result (value của option)
}
```

**Parameters:**
- `title` (required): Tiêu đề
- `subtitle`: Phụ đề
- `options` (required): List các option `List<BottomSheetOption<T>>`

**BottomSheetOption:**
- `label` (required): Text hiển thị
- `icon`: Icon
- `iconColor`: Màu icon
- `value` (required): Giá trị trả về khi chọn
- `isDangerous`: `true` để hiển thị màu đỏ

**Returns:** `T?` - Value của option đã chọn, `null` nếu cancel

---

## 🎯 Use Cases

### Replace existing bottom sheets

**Before:**
```dart
showModalBottomSheet(
  context: context,
  builder: (context) => Container(
    padding: EdgeInsets.all(24),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('Are you sure?'),
        Row(
          children: [
            TextButton(onPressed: () => Navigator.pop(context, false), child: Text('Cancel')),
            ElevatedButton(onPressed: () => Navigator.pop(context, true), child: Text('Confirm')),
          ],
        ),
      ],
    ),
  ),
);
```

**After:**
```dart
final result = await showConfirmationBottomSheet(
  context: context,
  title: 'Confirm Action',
  message: 'Are you sure you want to proceed?',
  icon: Icons.warning,
);
```

### Common patterns

**1. Kick member:**
```dart
final confirmed = await showConfirmationBottomSheet(
  context: context,
  title: 'Remove Member',
  message: 'Are you sure you want to remove $userName from this group?',
  confirmText: 'Remove',
  icon: Icons.person_remove_outlined,
  isDangerous: true,
);

if (confirmed == true) {
  // Proceed with removal
}
```

**2. Rename group:**
```dart
final newName = await showInputBottomSheet(
  context: context,
  title: 'Rename Group',
  initialValue: currentName,
  labelText: 'Group Name',
  validator: (value) => value?.isEmpty == true ? 'Name required' : null,
);

if (newName != null) {
  // Update group name
}
```

**3. Schedule message:**
```dart
final scheduledTime = await showTimePickerBottomSheet(
  context: context,
  title: 'Schedule Message',
  quickOptions: [
    QuickTimeOption(label: '5 min', minutes: 5),
    QuickTimeOption(label: '1 hour', minutes: 60),
    QuickTimeOption(label: '1 day', minutes: 1440),
  ],
);

if (scheduledTime != null) {
  // Schedule message for scheduledTime
}
```

**4. Member actions:**
```dart
final action = await showOptionsBottomSheet<String>(
  context: context,
  title: 'Member Options',
  options: [
    BottomSheetOption(label: 'View Profile', icon: Icons.person, value: 'profile'),
    BottomSheetOption(label: 'Make Admin', icon: Icons.admin_panel_settings, value: 'admin'),
    BottomSheetOption(label: 'Remove', icon: Icons.person_remove, value: 'remove', isDangerous: true),
  ],
);

switch (action) {
  case 'profile': // View profile
  case 'admin': // Make admin
  case 'remove': // Remove member
}
```

---

## 🎨 Design Features

- ✅ Consistent design across all bottom sheets
- ✅ Dark theme support
- ✅ Handle bar for swipe to dismiss
- ✅ Keyboard-aware (input bottom sheet)
- ✅ iOS-style pickers (time & date)
- ✅ Quick select options (time picker)
- ✅ Validation support (input)
- ✅ Dangerous action styling (red color)
- ✅ Icon support with custom colors
- ✅ Responsive padding
- ✅ Safe area support

---

## 📝 Example Page

Xem file `bottom_sheets_example.dart` để xem demo đầy đủ các bottom sheets.

```dart
import 'package:chattrix_ui/core/widgets/bottom_sheets_example.dart';

// Navigate to example page
Navigator.push(
  context,
  MaterialPageRoute(builder: (_) => BottomSheetsExamplePage()),
);
```

---

## 🔧 Customization

Tất cả bottom sheets đều sử dụng theme colors từ `Theme.of(context)`, nên sẽ tự động adapt với dark/light theme.

Nếu cần customize thêm, có thể:
1. Fork file `bottom_sheets.dart`
2. Tạo custom bottom sheet riêng
3. Hoặc wrap trong custom widget

---

## ✅ Benefits

1. **Consistent UX**: Tất cả bottom sheets có design giống nhau
2. **Less Code**: Giảm code lặp lại, dễ maintain
3. **Type Safe**: Generic support cho options bottom sheet
4. **Validation**: Built-in validation cho input
5. **iOS Style**: Native iOS pickers cho time/date
6. **Quick Actions**: Quick select options cho time picker
7. **Accessibility**: Proper labels và semantics
8. **Responsive**: Keyboard-aware và safe area support
