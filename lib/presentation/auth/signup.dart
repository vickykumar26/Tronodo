import 'package:flutter/material.dart';
import 'package:tronodo/common/widgets/app_bar/app_bar.dart';
import 'package:tronodo/common/widgets/button/basic_app_button.dart';
import 'package:tronodo/data/models/auth/create_user_req.dart';
import 'package:tronodo/domain/usecases/auth/signup.dart';
import 'package:tronodo/presentation/auth/signin.dart';
import 'package:tronodo/presentation/home/pages/home.dart';
import 'package:tronodo/service_locator.dart';

class Signup extends StatefulWidget {
  Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  bool _isPasswordShown = true;
  final TextEditingController _fullName = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final _FormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _FormKey,
      child: Scaffold(
        bottomNavigationBar: _signinText(context),
        appBar: BasicAppBar(
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                  height: 40,
                  width: 40,
                  child: Image.asset('assets/images/app_icon.png')
              ),
              const Text('Tronodo', style: TextStyle(fontSize: 30,
                  fontFamily: 'Satoshi Bold',
                  color: Colors.greenAccent),)
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
              _registerText(),
              const SizedBox(height: 50,),
              _fullNameField(context),
              const SizedBox(height: 20,),
              _emailField(context),
              const SizedBox(height: 20,),
              _passwordField(context),
              const SizedBox(height: 20,),
              BasicAppButton(
                  onPressed: () async {
                    if(_FormKey.currentState?.validate() == true){

                    }
                    var result = await sl<SignupUseCase>().call(
                      params: CreateUserReq(
                          fullName: _fullName.text.toString(),
                          email: _email.text.toString(),
                          password: _password.text.toString(),
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
                              (route) => false
                          );
                        }
                    );
                  },
                  title: 'Create Account'
              )
      
            ],
          ),
        ),
      ),
    );
  }

  Widget _registerText() {
    return const Text(
      'Register',
      style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 25
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _fullNameField(BuildContext context) {
    return TextFormField(
      controller: _fullName,
      keyboardType: TextInputType.name,
      validator: (value){
        if(value?.isEmpty == true){
          return "Please enter your name";
        }
        return null;
      },
      decoration: const InputDecoration(
          hintText: 'Full Name'
      ).applyDefaults(
          Theme.of(context).inputDecorationTheme
      ),
    );
  }
  Widget _emailField(BuildContext context) {
    return TextFormField(
      controller: _email,
      keyboardType: TextInputType.emailAddress,
      validator: (value){
        if(value?.isEmpty == true){
          return "Please enter your email";
        }
        return null;
      },
      decoration: const InputDecoration(
          hintText: 'Enter Email'
      ).applyDefaults(
          Theme.of(context).inputDecorationTheme
      ),
    );
  }
  Widget _passwordField(BuildContext context) {
    return TextFormField(
      controller: _password,
      keyboardType: TextInputType.visiblePassword,
      obscureText: _isPasswordShown,
        validator: (value){
          if(value?.isEmpty == true){
            return "Please enter password";
          }
          return null;
      },
      decoration:  InputDecoration(
          hintText: 'Password',
        suffixIcon: Padding(
          padding: const EdgeInsets.only(right: 10),
          child: IconButton(
            onPressed: (){
              setState(() {
                _isPasswordShown = !_isPasswordShown;
              });
            },
            icon: _isPasswordShown ? const Icon(Icons.visibility) : const Icon(Icons.visibility_off),
          ),
        ),

      ).applyDefaults(
          Theme.of(context).inputDecorationTheme
      ),
    );
  }
  Widget _signinText(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          vertical: 30
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Do you have an account?',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 14),),
          TextButton(
            onPressed: (){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const Signin()));
            },
            child: const Text(
                'Sign In'
            ),
          ),
        ],
      ),
    );
  }
}


