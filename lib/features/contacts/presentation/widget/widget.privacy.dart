import 'package:flutter/material.dart';
import 'package:muonroi/shared/Settings/setting.fonts.dart';
import 'package:muonroi/shared/settings/enums/theme/enum.code.color.theme.dart';
import 'package:muonroi/shared/settings/setting.main.dart';

class PrivacyWidget extends StatefulWidget {
  final String title;
  const PrivacyWidget({super.key, required this.title});

  @override
  State<PrivacyWidget> createState() => _PrivacyWidgetState();
}

class _PrivacyWidgetState extends State<PrivacyWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
          color: themeMode(context, ColorCode.textColor.name),
        ),
        backgroundColor: themeMode(context, ColorCode.mainColor.name),
        elevation: 0,
        title: Text(
          widget.title,
          style: CustomFonts.h5(context),
        ),
      ),
      body: PrivacyPolicyWidget(
        title: widget.title,
      ),
    );
  }
}

class PrivacyPolicyWidget extends StatelessWidget {
  final String title;
  const PrivacyPolicyWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: themeMode(context, ColorCode.modeColor.name),
      margin: const EdgeInsets.all(16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10.0),
            const Text(
              '13 Tháng 11, 2023',
              style: TextStyle(
                fontStyle: FontStyle.italic,
              ),
            ),
            const SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '1. Không tiết lộ địa chỉ email, hay các thông tin cần bảo mật khác cho bên thứ 3, trừ khi bạn vi phạm nội quy.',
                style: CustomFonts.h6(context).copyWith(fontSize: 12),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('2. Không tiết lộ địa chỉ IP cho bên thứ 3.',
                  style: CustomFonts.h6(context).copyWith(fontSize: 12)),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '3. Không tiết lộ vị trí của bạn cho bên thứ 3. Đồng thời chỉ sử dụng thông tin này để cải thiện chức năng của website. Mọi việc đều hoàn toàn tự động.',
                style: CustomFonts.h6(context).copyWith(fontSize: 12),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                  '''4. Chúng tôi lưu trữ các hoạt động mang tính công khai khi bạn tham gia hoạt động gồm:
             Hoạt động tại truyện (nhật ký của truyện)
             Hoạt động chung của tài khoản (nhật ký tài khoản)''',
                  style: CustomFonts.h6(context).copyWith(fontSize: 12)),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                  '5. Các thông tin bạn nhập vào ứng dụng hầu hết đều là công khai, vì vậy chúng tôi không chịu trách nhiệm về việc giữ tính riêng tư các thông tin đó.',
                  style: CustomFonts.h6(context).copyWith(fontSize: 12)),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                  '''6. Chúng tôi có cơ chế để cho biết khi nào bạn online hay offline khỏi website. Một chấm xanh sẽ xuất hiện bên cạnh tên của bạn khi online và biến mất khi offline.
             ''',
                  style: CustomFonts.h6(context).copyWith(fontSize: 12)),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                  '''7. Để xóa hoàn toàn dữ liệu của bạn, vui lòng thực hiện các bước sau:
             Truy cập vào fanpage facebook chính thức của muonroi .
             Gửi tin nhắn trực tiếp, cung cấp thông tin tài khoản và yêu cầu xóa dữ liệu.
             Chúng tôi sẽ tiến hành xác thực thông tin, và gửi phản hồi trong vòng 03 ngày làm việc.''',
                  style: CustomFonts.h6(context).copyWith(fontSize: 12)),
            )
          ],
        ),
      ),
    );
  }
}
