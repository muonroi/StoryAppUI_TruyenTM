import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:muonroi/core/localization/settings.language.code.dart';
import 'package:muonroi/features/accounts/data/models/models.account.signin.dart';
import 'package:muonroi/features/user/bloc/user_info_bloc.dart';
import 'package:muonroi/features/user/data/models/user.single.detail.model.dart';
import 'package:muonroi/features/user/data/repository/user.repository.dart';
import 'package:muonroi/features/user/presentation/widgets/user.info.header.dart';
import 'package:muonroi/features/user/settings/settings.dart';
import 'package:muonroi/shared/settings/enums/theme/enum.code.color.theme.dart';
import 'package:muonroi/shared/settings/settings.fonts.dart';
import 'package:muonroi/shared/settings/settings.main.dart';
import 'package:muonroi/shared/static/buttons/widget.static.circle.button.icon.dart';
import 'package:muonroi/shared/static/items/widget.divider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class UserInfoPage extends StatefulWidget {
  final String username;
  final String avatar;
  final String userGuid;
  final Function(String) renewAvatar;
  const UserInfoPage(
      {super.key,
      required this.username,
      required this.avatar,
      required this.userGuid,
      required this.renewAvatar});

  @override
  State<UserInfoPage> createState() => _UserInfoPageState();
}

class _UserInfoPageState extends State<UserInfoPage> {
  @override
  void initState() {
    _avatar = widget.avatar;
    _userInfoBloc = UserInfoBloc(widget.username);
    _userInfoBloc.add(GetUserInfo());
    _nameController = TextEditingController();
    _gmailController = TextEditingController();
    _phoneController = TextEditingController();
    _birthdayController = TextEditingController();
    _addressController = TextEditingController();
    _image = File(widget.avatar);
    _tempTextChange = null;
    _userRepository = UserRepository();
    _textWidth = 0.0;
    super.initState();
    _initSharedPreferences();
  }

  @override
  void dispose() {
    _userInfoBloc.close();
    _nameController.dispose();
    _gmailController.dispose();
    _phoneController.dispose();
    _birthdayController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      _image = File(image.path);
      await _userRepository.uploadAvatarUser(_image, widget.userGuid);
    }
    setState(() {
      var userInfo = accountSignInFromJson(
          _sharedPreferences.getString('userLogin') ?? '');
      _avatar = userInfo.result!.avatar;
      widget.renewAvatar(_avatar);
    });
  }

  void _calculateTextWidth() {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: _nameController.text,
        style: CustomFonts.h5(context),
      ),
      textDirection: ui.TextDirection.ltr,
    )..layout();
    _textWidth = textPainter.width;
  }

  Future<void> _initSharedPreferences() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  late SharedPreferences _sharedPreferences;
  late File _image;
  late String? _tempTextChange;
  late double _textWidth;
  late UserInfoBloc _userInfoBloc;
  late TextEditingController _nameController;
  late TextEditingController _gmailController;
  late TextEditingController _phoneController;
  late TextEditingController _birthdayController;
  late TextEditingController _addressController;
  late UserRepository _userRepository;
  late String _avatar;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: themeMode(context, ColorCode.modeColor.name),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
          color: themeMode(context, ColorCode.textColor.name),
        ),
        backgroundColor: themeMode(context, ColorCode.mainColor.name),
        elevation: 0,
        title: Text(
          L(context, LanguageCodes.userInfoTextInfo.toString()),
          style: CustomFonts.h4(context),
        ),
      ),
      body: BlocProvider(
        create: (context) => _userInfoBloc,
        child: BlocListener<UserInfoBloc, UserInfoState>(
          listener: (context, state) {
            const Center(
              child: CircularProgressIndicator(),
            );
          },
          child: BlocBuilder<UserInfoBloc, UserInfoState>(
            builder: (context, state) {
              if (state is UserInfoLoadingState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is UserInfoLoadedState) {
                var userInfo = state.user.result;
                if (_tempTextChange == null) {
                  _nameController.text = '${userInfo.name} ${userInfo.surname}';
                } else {
                  _nameController.text = _tempTextChange!;
                }
                _gmailController.text = userInfo.email;
                _phoneController.text = userInfo.phoneNumber;
                _addressController.text = userInfo.address;
                _birthdayController.text =
                    DateFormat("dd/MM/yyyy").format(userInfo.birthDate);
                _calculateTextWidth();
                return Column(
                  children: [
                    HeaderInfo(
                      pickImage: _pickImage,
                      url: _avatar,
                      textController: _nameController,
                      textWidth: _textWidth,
                      groupName: userInfo.groupName ?? 'anonymous',
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CircleButtonIcon(
                          icon: Icon(
                            Icons.notification_add_outlined,
                            color: themeMode(context, ColorCode.textColor.name),
                          ),
                          borderSize: 16.0,
                          action: () {},
                          tooltip: L(context,
                              LanguageCodes.followUserTextInfo.toString()),
                        ),
                        CircleButtonIcon(
                          icon: Icon(
                            Icons.person_add_alt_1_outlined,
                            color: themeMode(context, ColorCode.textColor.name),
                          ),
                          borderSize: 16.0,
                          action: () {},
                          tooltip: L(context,
                              LanguageCodes.followUserTextInfo.toString()),
                        ),
                        CircleButtonIcon(
                          icon: Icon(
                            Icons.chat_bubble_outline_rounded,
                            color: themeMode(context, ColorCode.textColor.name),
                          ),
                          borderSize: 16.0,
                          action: () {},
                          tooltip: L(
                              context, LanguageCodes.inboxTextInfo.toString()),
                        )
                      ],
                    ),
                    const CustomDivider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: Container(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 12.0),
                            decoration: BoxDecoration(
                              border: Border(
                                right: BorderSide(
                                    color: themeMode(
                                        context, ColorCode.textColor.name),
                                    width: 0.1),
                                bottom: BorderSide(
                                    color: themeMode(
                                        context, ColorCode.textColor.name),
                                    width: 0.1),
                                top: BorderSide(
                                    color: themeMode(
                                        context, ColorCode.textColor.name),
                                    width: 0.1),
                              ),
                            ),
                            child: TextFormField(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (value) => value == null ||
                                      value.isEmpty ||
                                      !isEmailValid(value)
                                  ? L(
                                      context,
                                      LanguageCodes.invalidEmailTextInfo
                                          .toString())
                                  : null,
                              keyboardType: TextInputType.emailAddress,
                              controller: _gmailController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                icon: Icon(
                                  Icons.email_outlined,
                                  color: themeMode(
                                      context, ColorCode.textColor.name),
                                ),
                                labelText: L(context,
                                    LanguageCodes.gmailUserTextInfo.toString()),
                                labelStyle: CustomFonts.h5(context),
                              ),
                              style: CustomFonts.h5(context),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 12.0),
                            decoration: BoxDecoration(
                              border: Border(
                                right: BorderSide(
                                    color: themeMode(
                                        context, ColorCode.textColor.name),
                                    width: 0.1),
                                bottom: BorderSide(
                                    color: themeMode(
                                        context, ColorCode.textColor.name),
                                    width: 0.1),
                                top: BorderSide(
                                    color: themeMode(
                                        context, ColorCode.textColor.name),
                                    width: 0.1),
                              ),
                            ),
                            child: TextFormField(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (value) => value == null ||
                                      value.isEmpty ||
                                      !isPhoneNumberValid(value)
                                  ? L(
                                      context,
                                      LanguageCodes.invalidPhoneNumberTextInfo
                                          .toString())
                                  : null,
                              keyboardType: TextInputType.phone,
                              controller: _phoneController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                icon: Icon(
                                  Icons.phone_outlined,
                                  color: themeMode(
                                      context, ColorCode.textColor.name),
                                ),
                                labelText: L(
                                    context,
                                    LanguageCodes.phoneNumberTextInfo
                                        .toString()),
                                labelStyle: CustomFonts.h5(context),
                              ),
                              style: CustomFonts.h5(context),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: Container(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 12.0),
                            decoration: BoxDecoration(
                              border: Border(
                                right: BorderSide(
                                    color: themeMode(
                                        context, ColorCode.textColor.name),
                                    width: 0.1),
                                bottom: BorderSide(
                                    color: themeMode(
                                        context, ColorCode.textColor.name),
                                    width: 0.1),
                                top: BorderSide(
                                    color: themeMode(
                                        context, ColorCode.textColor.name),
                                    width: 0.1),
                              ),
                            ),
                            child: TextFormField(
                              keyboardType: TextInputType.datetime,
                              controller: _birthdayController,
                              onTap: () async {
                                DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: userInfo.birthDate,
                                  firstDate: DateTime(1900),
                                  lastDate: DateTime.now(),
                                );

                                if (pickedDate != null &&
                                    pickedDate != userInfo.birthDate) {
                                  _birthdayController.text =
                                      DateFormat("dd/MM/yyyy")
                                          .format(pickedDate);
                                }
                              },
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                icon: Icon(
                                  Icons.calendar_month,
                                  color: themeMode(
                                      context, ColorCode.textColor.name),
                                ),
                                labelText: L(
                                  context,
                                  LanguageCodes.birthdayUserTextInfo.toString(),
                                ),
                                labelStyle: CustomFonts.h5(context),
                              ),
                              style: CustomFonts.h5(context),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 12.0),
                            decoration: BoxDecoration(
                              border: Border(
                                right: BorderSide(
                                    color: themeMode(
                                        context, ColorCode.textColor.name),
                                    width: 0.1),
                                bottom: BorderSide(
                                    color: themeMode(
                                        context, ColorCode.textColor.name),
                                    width: 0.1),
                                top: BorderSide(
                                    color: themeMode(
                                        context, ColorCode.textColor.name),
                                    width: 0.1),
                              ),
                            ),
                            child: TextFormField(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (value) => value == null ||
                                      value.isEmpty
                                  ? L(
                                      context,
                                      LanguageCodes.invalidPhoneNumberTextInfo
                                          .toString())
                                  : null,
                              keyboardType: TextInputType.streetAddress,
                              controller: _addressController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                icon: Icon(
                                  Icons.info_outline,
                                  color: themeMode(
                                      context, ColorCode.textColor.name),
                                ),
                                labelText: L(
                                    context,
                                    LanguageCodes.addressUserTextInfo
                                        .toString()),
                                labelStyle: CustomFonts.h5(context),
                              ),
                              style: CustomFonts.h5(context),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                );
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ),
      ),
      floatingActionButton: Container(
        margin: const EdgeInsets.only(top: 280.0),
        child: Align(
          alignment: Alignment.centerRight,
          child: FloatingActionButton(
            backgroundColor: themeMode(context, ColorCode.mainColor.name),
            onPressed: () async {
              showTopSnackBar(
                Overlay.of(context),
                CustomSnackBar.success(
                  message: L(
                      context, LanguageCodes.changeUserInfoTextInfo.toString()),
                ),
              );
              var formatNameResult = formatNameUser(_nameController.text);
              if (formatNameResult.isNotEmpty) {
                var userInfo = SingleUserDetail(
                    name: formatNameResult.last,
                    surname: formatNameResult.first,
                    userName: widget.username,
                    phoneNumber: _phoneController.text,
                    email: _gmailController.text,
                    address: _addressController.text,
                    birthDate: DateFormat("dd/MM/yyyy")
                        .parse(_birthdayController.text)
                        .toUtc(),
                    gender: 0,
                    newSalf: null,
                    newPassword: null,
                    accountStatus: 6,
                    reason: 'Update info user');
                var result = await _userRepository.uploadInfoUser(userInfo);
                var oldInfo = accountSignInFromJson('userLogin');
                oldInfo.result!.name = result.result.name;
                oldInfo.result!.surname = result.result.surname;
                oldInfo.result!.phoneNumber = result.result.phoneNumber;
                oldInfo.result!.email = result.result.email;
                oldInfo.result!.address = result.result.address;
                oldInfo.result!.birthDate = result.result.birthDate;
                oldInfo.result!.accountStatus = result.result.accountStatus;
                _sharedPreferences.setString(
                    'userLogin', accountSignInToJson(oldInfo));
              }
            },
            child: Icon(
              Icons.save_as_outlined,
              color: themeMode(context, ColorCode.textColor.name),
            ),
          ),
        ),
      ),
    );
  }
}
