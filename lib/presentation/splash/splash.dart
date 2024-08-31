import 'package:flutter/material.dart';
import 'package:tronodo/presentation/splash/splash_services.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  SplashServices splashPage = SplashServices();

  @override
  void initState(){
    super.initState();
    splashPage.isLogin(context);
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                  height: 60,
                  width: 60,
                  child: Image.asset('assets/images/app_icon.png')
              ),
              const Text('Tronodo',style: TextStyle(fontSize: 40, fontFamily: 'Satoshi Bold',color: Colors.greenAccent),)
            ],
          )
      ),
    );
  }
}





