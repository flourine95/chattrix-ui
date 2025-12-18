import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

void main() {
  runApp(const AvatarStoryPreviewApp());
}

class AvatarStoryPreviewApp extends StatelessWidget {
  const AvatarStoryPreviewApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Messenger Note Style',
      themeMode: ThemeMode.light,
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: Colors.white,
        colorScheme: const ColorScheme.light(primary: Color(0xFF0084FF)),
      ),
      home: const ExampleWidget(),
    );
  }
}


class ExampleWidget extends HookWidget {
  const ExampleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. useState: Dùng để hiển thị số đếm lên màn hình (cần rebuild)
    final count = useState(0);

    // 2. useRef: Dùng để đếm số lần hàm build() đã chạy (không cần rebuild lại lần nữa)
    final renderCount = useRef(0);

    // Logic: Mỗi lần build chạy, tăng biến ref lên
    renderCount.value++;
    print("Đã render lần thứ: ${renderCount.value}");

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Hiển thị state
            Text("Số hiển thị: ${count.value}", style: TextStyle(fontSize: 24)),

            SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                // Thay đổi state -> Gây ra rebuild -> renderCount sẽ tăng
                count.value++;
              },
              child: Text("Tăng số (Rebuild)"),
            ),

            ElevatedButton(
              onPressed: () {
                // Thay đổi ref -> KHÔNG Rebuild -> Số hiển thị không đổi, console không log thêm
                renderCount.value = 0;
                print("Đã reset biến ngầm về 0");
              },
              child: Text("Reset Ref (Không Rebuild)"),
            ),
          ],
        ),
      ),
    );
  }
}