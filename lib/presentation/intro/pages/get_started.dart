import 'package:flutter/material.dart';
import 'package:tronodo/common/widgets/button/basic_app_button.dart';
import 'package:tronodo/core/configs/assets/app_images.dart';
import 'package:tronodo/core/configs/theme/app_colors.dart';
import 'package:tronodo/presentation/choose_mode/pages/choose_mode.dart';

class GetStarted extends StatefulWidget {
  const GetStarted({super.key});

  @override
  State<GetStarted> createState() => _GetStartedState();
}

class _GetStartedState extends State<GetStarted> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 40,
              horizontal: 40,
            ),
            decoration: const BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage(
                      AppImages.introBG,
                    ))),
          ),
          Container(
            color: Colors.black.withOpacity(0.15),
          ),
          Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 50,
                horizontal: 40,
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                          height: 50,
                          width: 50,
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
                  const Spacer(),
                  const Text(
                    'Enjoy Listening To Music',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 18),
                  ),
                  const SizedBox(
                    height: 21,
                  ),
                  const Text(
                    'Discover Your Perfect Soundtrack with Tronodo! Explore new hits, curate playlists, and enjoy endless music tailored just for you.',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: AppColors.grey,
                        fontSize: 13),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  BasicAppButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const ChooseMode()));
                      },
                      title: 'Get Started')
                ],
              ),
            ),
        ],
      ),
    );
  }
}



