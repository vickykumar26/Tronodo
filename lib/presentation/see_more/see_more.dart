import 'package:flutter/material.dart';
import 'package:tronodo/presentation/see_more/all_play_list.dart';
import '../../common/widgets/app_bar/app_bar.dart';

class SeeMorePage extends StatelessWidget {
  const SeeMorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: BasicAppBar(
        backgroundColor: Color(0xff2C2B2B),
        title: Text(
            'Playlist'
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child:AllPlayList(),)

        ],
      ),
    );
  }
}
