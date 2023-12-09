import 'package:flutter/material.dart';
import 'package:muonroi/core/localization/settings.language.code.dart';
import 'package:muonroi/features/accounts/settings/enum/enum.gender.dart';
import 'package:muonroi/shared/settings/enums/theme/enum.code.color.theme.dart';
import 'package:muonroi/shared/settings/setting.fonts.dart';
import 'package:muonroi/shared/settings/setting.main.dart';

class InputMoreInfoSignUp extends StatefulWidget {
  final Function(Gender value) callback;
  const InputMoreInfoSignUp({Key? key, required this.callback})
      : super(key: key);
  @override
  State<InputMoreInfoSignUp> createState() => _InputMoreInfoSignUpState();
}

class _InputMoreInfoSignUpState extends State<InputMoreInfoSignUp> {
  Gender? _character = Gender.male;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Center(
            child: SizedBox(
              child: Text(
                L(context, LanguageCodes.chosseGenderTextInfo.toString()),
                style: CustomFonts.h3(context)
                    .copyWith(fontWeight: FontWeight.w300),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _character = Gender.male;
                      widget.callback(_character!);
                    });
                  },
                  child: Container(
                    color: _character == Gender.male
                        ? themeMode(context, ColorCode.mainColor.name)
                        : null,
                    child: ListTile(
                      title: Text(
                          L(context, LanguageCodes.maleTextInfo.toString())),
                      leading: const Icon(Icons.male),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _character = Gender.female;
                      widget.callback(_character!);
                    });
                  },
                  child: Container(
                    color: _character == Gender.female ? Colors.blue : null,
                    child: ListTile(
                      title: Text(
                          L(context, LanguageCodes.femaleTextInfo.toString())),
                      leading: const Icon(Icons.female),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
