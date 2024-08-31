import 'package:flutter/material.dart';
import 'package:tronodo/common/widgets/app_bar/app_bar.dart';
import 'package:tronodo/common/widgets/button/basic_app_button.dart';
import 'package:tronodo/data/models/auth/signin_user_req.dart';
import 'package:tronodo/domain/usecases/auth/signin.dart';
import 'package:tronodo/presentation/auth/forgot_password.dart';
import 'package:tronodo/presentation/auth/signup.dart';
import '../../service_locator.dart';
import '../home/pages/home.dart';
import '../utils/utils.dart';

class Signin extends StatefulWidget {
  const Signin({super.key});

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  bool _isPasswordShown = true;
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: _signupText(context),
      appBar: BasicAppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
                height: 40,
                width: 40,
                child: Image.asset('assets/images/app_icon.png')),
            const Text(
              'Tronodo',
              style: TextStyle(
                  fontSize: 30,
                  fontFamily: 'Satoshi Bold',
                  color: Colors.greenAccent),
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: 30,
          vertical: 50,
        ),
        child: Column(
          children: [
            _signInText(),
            const SizedBox(
              height: 50,
            ),
            _emailField(context),
            const SizedBox(
              height: 20,
            ),
            _passwordField(context),
            const SizedBox(height: 10,),
            _forgotPassword(),
            const SizedBox(
              height: 20,
            ),
            BasicAppButton(
                onPressed: () async{
                  var result = await sl<SigninUseCase>().call(
                      params: SigninUserReq(
                          email: _email.text.toString(),
                          password: _password.text.toString()
                      )
                  );
                  result.fold(
                          (l){
                        var snackbar = SnackBar(content: Text(l));
                        ScaffoldMessenger.of(context).showSnackBar(snackbar);
                        },
                          (r){
                            Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (BuildContext context) => const HomePage()),
                                (route) => false,
                        );
                      }
                  );
            },
                title: 'Sign In')
          ],
        ),
      ),
    );
  }

  Widget _signInText() {
    return const Text(
      'Sign In',
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
      textAlign: TextAlign.center,
    );
  }

  Widget _emailField(BuildContext context) {
    return TextField(
      controller: _email,
      decoration: const InputDecoration(hintText: 'Enter Email')
          .applyDefaults(Theme.of(context).inputDecorationTheme),
    );
  }

  Widget _passwordField(BuildContext context) {
    return TextField(
      controller: _password,
      keyboardType: TextInputType.visiblePassword,
      obscureText: _isPasswordShown,
      decoration: InputDecoration(
        hintText: 'Password',
        suffixIcon: Padding(
          padding: const EdgeInsets.only(right: 10),
          child: IconButton(
            onPressed: () {
              setState(() {
                _isPasswordShown = !_isPasswordShown;
              });
            },
            icon: _isPasswordShown
                ? const Icon(Icons.visibility)
                : const Icon(Icons.visibility_off),
          ),
        ),
      ).applyDefaults(Theme.of(context).inputDecorationTheme),
    );
  }
  
  Widget _forgotPassword() {
    return Align(
      alignment: Alignment.bottomRight,
      child: TextButton(onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => const ForgotPassword()));
      }, child: const Text('Forgot Password?')
      )
    );
  }

  Widget _signupText(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Not A Member',
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
          ),
          TextButton(
            onPressed: () {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (_) => Signup()));
            },
            child: const Text('Register Now'),
          ),
        ],
      ),
    );
  }
}


