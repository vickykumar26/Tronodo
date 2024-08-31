import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tronodo/presentation/home/pages/home.dart';

import '../intro/pages/get_started.dart';

class SplashServices {
  void isLogin(BuildContext context){
    final auth = FirebaseAuth.instance;

    final user = auth.currentUser;

    if(user != null){
      Future.delayed(const Duration(seconds: 2),(){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomePage()));
      });
    }else {
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => const GetStarted()));
      });
    }
  }
}