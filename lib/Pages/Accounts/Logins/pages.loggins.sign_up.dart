import 'dart:async';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:muonroi/Models/Accounts/models.account.signup.dart';
import 'package:muonroi/Pages/Accounts/Logins/pages.logins.sign_in.dart';
import 'package:muonroi/Pages/Accounts/Logins/pages.logins.valid_otp.dart';
import '../../../Settings/settings.colors.dart';
import '../../../Settings/settings.fonts.dart';
import '../../../Widget/TextField/widget.textfield.password_input.dart';
import '../../../Widget/TextField/widget.textfield.text_input.dart';

enum Gender { male, female }

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  late SignUpDto _signUpDto;
  List<Widget> _pageViewsSignUp = [];
  late PageController _pageController;
  int _currentPage = 0;
  bool _isPageViewReady = false;
  @override
  void initState() {
    _pageController = PageController(initialPage: _currentPage);
    super.initState();
    _signUpDto = SignUpDto();
    _pageViewsSignUp = [
      InputBasicInfoSignUp(
        inputBasicInfo: _signUpDto,
      ),
      InputMoreInfoSignUp(genderDto: _signUpDto),
      //InputMoreInfoSignUp(inputMoreInfo: _signUpDto),
    ];
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _isPageViewReady = true;
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget floatingActionButton;
    if (_isPageViewReady &&
        _pageController.hasClients &&
        _currentPage == _pageViewsSignUp.length - 1) {
      floatingActionButton = FloatingActionButton(
          backgroundColor: ColorDefaults.buttonColor,
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const OTPScreen()));
          },
          child: const Icon(Icons.check));
    } else {
      floatingActionButton = FloatingActionButton(
          onPressed: () {
            _pageController.nextPage(
              duration: const Duration(milliseconds: 300),
              curve: Curves.ease,
            );
          },
          child: const Icon(Icons.arrow_forward));
    }
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: PageView.builder(
        controller: _pageController,
        onPageChanged: (value) {
          setState(() {
            _currentPage = value;
          });
        },
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(32.0),
            child: _pageViewsSignUp[index],
          );
        },
        itemCount: _pageViewsSignUp.length,
      ),
      floatingActionButton: floatingActionButton,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(vertical: 32.0),
        child: RichText(
          text: TextSpan(
              text: 'Already have an account?',
              style: FontsDefault.h5,
              children: [
                TextSpan(
                    text: ' Sign In',
                    style: FontsDefault.h5.copyWith(
                        fontWeight: FontWeight.w900,
                        color: ColorDefaults.buttonColor),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignInPage()));
                      })
              ]),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class InputMoreInfoSignUp extends StatefulWidget {
  final SignUpDto genderDto;
  const InputMoreInfoSignUp({Key? key, required this.genderDto})
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
                'Please choose your gender',
                style: FontsDefault.h3.copyWith(fontWeight: FontWeight.w300),
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
                      widget.genderDto.gender = true;
                    });
                  },
                  child: Container(
                    color: _character == Gender.male
                        ? ColorDefaults.buttonColor
                        : null,
                    child: const ListTile(
                      title: Text('Male'),
                      leading: Icon(Icons.male),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _character = Gender.female;
                      widget.genderDto.gender = false;
                    });
                  },
                  child: Container(
                    color: _character == Gender.female ? Colors.blue : null,
                    child: const ListTile(
                      title: Text('Female'),
                      leading: Icon(Icons.female),
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

class InputBasicInfoSignUp extends StatefulWidget {
  final SignUpDto inputBasicInfo;
  const InputBasicInfoSignUp({
    super.key,
    required this.inputBasicInfo,
  });

  @override
  State<InputBasicInfoSignUp> createState() => _InputBasicInfoSignUpState();
}

class _InputBasicInfoSignUpState extends State<InputBasicInfoSignUp> {
  TextEditingController dateController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        RoundedInputField(
          readonly: false,
          hintText: 'Your full name',
          icon: Icons.info,
          onChanged: (value) {
            setState(() {
              widget.inputBasicInfo.fullName = value;
            });
          },
        ),
        RoundedInputField(
          readonly: false,
          hintText: 'Your phone number',
          icon: Icons.phone,
          onChanged: (value) {
            setState(() {
              widget.inputBasicInfo.phoneNumber = value;
            });
          },
        ),
        RoundedInputField(
          readonly: false,
          hintText: 'Your email',
          icon: Icons.email,
          onChanged: (value) {
            setState(() {
              widget.inputBasicInfo.email = value;
            });
          },
        ),
        RoundedInputField(
            dateController: dateController,
            readonly: true,
            hintText: 'Your birthday',
            icon: Icons.calendar_today,
            onChanged: (value) {},
            ontap: () => pickdatetime(context)),
        RoundedInputField(
          readonly: false,
          hintText: 'Your username',
          icon: Icons.person,
          onChanged: (value) {},
        ),
        RoundedPasswordField(
          hintText: 'Your password',
          onChanged: (value) {},
        )
      ],
    );
  }

  Future<void> pickdatetime(BuildContext context) async {
    {
      DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(1960),
          lastDate: DateTime(2101));
      if (pickedDate != null) {
        String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
        setState(() {
          widget.inputBasicInfo.birthDate =
              DateUtils.dateOnly(DateTime.parse(formattedDate));
          DateTime? tempDate = widget.inputBasicInfo.birthDate;
          String monthFormat =
              tempDate!.month < 10 ? "0${tempDate.month}" : "${tempDate.month}";
          String dayFormat =
              tempDate.day < 10 ? "0${tempDate.day}" : "${tempDate.day}";
          dateController.text = "$dayFormat - $monthFormat - ${tempDate.year}";
        });
      }
    }
  }
}
