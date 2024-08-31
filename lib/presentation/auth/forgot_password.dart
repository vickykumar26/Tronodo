import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tronodo/presentation/utils/utils.dart';
import '../../common/widgets/app_bar/app_bar.dart';
import '../../common/widgets/button/basic_app_button.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final TextEditingController _email = TextEditingController();
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const BasicAppBar(
        title: Text('Forgot Password')
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: 30,
          vertical: 50,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 50,
            ),
            _emailField(context),
            const SizedBox(
              height: 20,
            ),
            BasicAppButton(
                onPressed: () {
                  auth.sendPasswordResetEmail(email: _email.text.toString()).then((value){
                    Utils().toastMessage('We have sent you email to recover password, Please check email or spam folder');
                  }).onError((error, stackTrace){
                    Utils().toastMessage(error.toString());
                  });
                },
                title: 'Forgot Password')
          ],
        ),
      ),
    );
  }

  Widget _emailField(BuildContext context) {
    return TextField(
      controller: _email,
      decoration: const InputDecoration(hintText: 'Enter Email')
          .applyDefaults(Theme.of(context).inputDecorationTheme),
    );
  }
}
