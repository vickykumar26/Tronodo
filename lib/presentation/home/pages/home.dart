import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tronodo/common/helpers/is_dark.dart';
import 'package:tronodo/core/configs/assets/app_images.dart';
import 'package:tronodo/core/configs/assets/app_vectors.dart';
import 'package:tronodo/core/configs/theme/app_colors.dart';
import 'package:tronodo/presentation/home/widgets/news_songs.dart';
import 'package:tronodo/presentation/profile/pages/profile.dart';
import '../../../common/widgets/app_bar/app_bar.dart';
import '../widgets/play_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(
        hideBack: true,
        action: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (BuildContext context) => const ProfilePage()),
            );
          },
          icon: const Icon(Icons.person),
        ),
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 40,
              width: 40,
              child: Image.asset('assets/images/app_icon.png'),
            ),
            const SizedBox(width: 8), // Space between logo and text
            const Text(
              'Tronodo',
              style: TextStyle(
                fontSize: 30,
                fontFamily: 'Satoshi Bold',
                color: Colors.greenAccent,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          _homeTopCard(),
          SizedBox(height: 10,),
          //_tabs(),
          const Text('New Songs',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,),),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: SizedBox(
              height: 260,
              child: TabBarView(
                controller: _tabController,
                children: const [
                  NewsSongs(), 
                ],
              ),
            ),
          ),
          const Expanded(child: PlayList()),  // Ensure PlayList is a StatelessWidget or StatefulWidget
        ],
      ),
    );
  }

  Widget _homeTopCard() {
    return Center(
      child: SizedBox(
        height: 140,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: SvgPicture.asset(AppVectors.homeTopCard),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 60),
                child: Image.asset(AppImages.homeArtist),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget _tabs() {
  //   return TabBar(
  //     labelColor: context.isDarkMode ? Colors.white : Colors.black,
  //     padding: const EdgeInsets.symmetric(vertical: 30),
  //     indicatorColor: AppColors.primary,
  //     isScrollable: true,
  //     controller: _tabController,
  //     tabs: const [
  //       Text(
  //         'News',
  //         style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
  //       ),
  //       Text(
  //         'Videos',
  //         style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
  //       ),
  //       Text(
  //         'Artists',
  //         style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
  //       ),
  //       Text(
  //         'Podcasts',
  //         style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
  //       ),
  //     ],
  //   );
  // }
}

