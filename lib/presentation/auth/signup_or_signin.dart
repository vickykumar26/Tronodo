import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tronodo/common/helpers/is_dark.dart';
import 'package:tronodo/common/widgets/app_bar/app_bar.dart';
import 'package:tronodo/common/widgets/button/basic_app_button.dart';
import 'package:tronodo/core/configs/assets/app_images.dart';
import 'package:tronodo/core/configs/assets/app_vectors.dart';
import 'package:tronodo/core/configs/theme/app_colors.dart';
import 'package:tronodo/presentation/auth/signin.dart';
import 'package:tronodo/presentation/auth/signup.dart';

class SignupOrSignin extends StatefulWidget {
  const SignupOrSignin({super.key});

  @override
  State<SignupOrSignin> createState() => _SignupOrSigninState();
}

class _SignupOrSigninState extends State<SignupOrSignin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const BasicAppBar(),
          Align(
            alignment: Alignment.topRight,
            child: SvgPicture.asset(AppVectors.topPattern),
          ),

          Align(
            alignment: Alignment.bottomRight,
            child: SvgPicture.asset(AppVectors.bottomPattern),
          ),

          Align(
            alignment: Alignment.bottomLeft,
            child: Image.asset(AppImages.authBG),
          ),

          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                          height: 60,
                          width: 60,
                          child: Image.asset('assets/images/app_icon.png')
                      ),
                      const Text('Tronodo',style: TextStyle(fontSize: 40, fontFamily: 'Satoshi Bold',color: Colors.greenAccent),)
                    ],
                  ),
                  const SizedBox(height: 55,),
                  const Text(
                    'Enjoy Listening To Music',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                  ),
                  const SizedBox(height: 21,),
                  const Text(
                    'Tronodo is a proprietary Swedish audio streaming and media services provider ',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 13,
                      color: AppColors.grey,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 30,),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                          child: BasicAppButton(
                            onPressed: (){
                              Navigator.push(context, MaterialPageRoute(builder: (_) => Signup()));
                            },
                            title: 'Register',
                          )
                      ),
                      const SizedBox(width: 20,),
                      Expanded(
                        flex: 1,
                        child: TextButton(
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (_) => const Signin()));
                        },
                            child: Text(
                              'Sign in',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: context.isDarkMode ?  Colors.white : Colors.black,
                              ),
                            ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

