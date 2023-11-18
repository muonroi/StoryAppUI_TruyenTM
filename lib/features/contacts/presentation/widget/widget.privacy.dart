import 'package:flutter/material.dart';
import 'package:muonroi/core/localization/settings.language.code.dart';
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
              'November 13th, 2023',
              style: TextStyle(
                fontStyle: FontStyle.italic,
              ),
            ),
            const SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                L(context, LanguageCodes.privacyOneTextInfo.toString()),
                style: CustomFonts.h6(context).copyWith(fontSize: 12),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                  L(context, LanguageCodes.privacyTwoTextInfo.toString()),
                  style: CustomFonts.h6(context).copyWith(fontSize: 12)),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                L(context, LanguageCodes.privacyThirdTextInfo.toString()),
                style: CustomFonts.h6(context).copyWith(fontSize: 12),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                  L(context, LanguageCodes.privacyFourTextInfo.toString()),
                  style: CustomFonts.h6(context).copyWith(fontSize: 12)),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                  L(context, LanguageCodes.privacyFiveTextInfo.toString()),
                  style: CustomFonts.h6(context).copyWith(fontSize: 12)),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                  L(context, LanguageCodes.privacySixTextInfo.toString()),
                  style: CustomFonts.h6(context).copyWith(fontSize: 12)),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                  L(context, LanguageCodes.privacySevenTextInfo.toString()),
                  style: CustomFonts.h6(context).copyWith(fontSize: 12)),
            )
          ],
        ),
      ),
    );
  }
}
