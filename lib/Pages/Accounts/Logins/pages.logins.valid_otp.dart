import 'package:flutter/material.dart';
import 'package:taxi/Pages/MainPages/main_pages.home.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen({super.key});

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  List<TextEditingController> otpControllers =
      List.generate(4, (index) => TextEditingController());

  @override
  void dispose() {
    // Clean up the controllers when the widget is disposed
    for (var controller in otpControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(4, (index) {
                  return SizedBox(
                    width: 60.0,
                    child: TextFormField(
                      controller: otpControllers[index],
                      keyboardType: TextInputType.number,
                      maxLength: 1,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 20.0),
                      decoration: const InputDecoration(
                        counterText: '',
                      ),
                      onChanged: (value) {
                        if (value.isNotEmpty && index < 3) {
                          FocusScope.of(context).nextFocus();
                        }
                      },
                    ),
                  );
                }),
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  String enteredOTP = otpControllers
                      .map((controller) => controller.text)
                      .join();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HomePage()));
                },
                child: const Text('Verify'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
