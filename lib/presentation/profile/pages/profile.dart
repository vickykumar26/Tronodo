import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tronodo/common/helpers/is_dark.dart';
import 'package:tronodo/presentation/utils/utils.dart';
import '../../../common/widgets/favorite_button/favorite_button.dart';
import '../../../core/configs/assets/app_vectors.dart';
import '../../../core/configs/constants/app_urls.dart';
import '../../auth/signup_or_signin.dart';
import '../../song_player/pages/song_player.dart';
import '../bloc/favorite_songs_cubit.dart';
import '../bloc/favorite_songs_state.dart';
import '../bloc/profile_info_cubit.dart';
import '../bloc/profile_info_state.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff2C2B2B),
        title:  Center(child: Text('Profile')),
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert_rounded),
            itemBuilder: (BuildContext context) => [
              const PopupMenuItem<String>(
                value: 'logout',
                child: Text(
                  'Log Out',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.red,
                  ),
                ),
              ),
            ],
              onSelected: (String value) {
                auth.signOut().then((_) {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => SignupOrSignin()),
                        (route) => false,
                  );
                }).onError((error, stackTrace) {
                  Utils().toastMessage(error.toString());
                });
              }

          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _profileInfo(context),
          const SizedBox(height: 30),
          Expanded(child: _favoriteSongs()),
        ],
      ),
    );
  }

  // Widget _profileInfo(BuildContext context) {
  //   return BlocProvider(
  //     create: (context) => ProfileInfoCubit()..getUser(),
  //     child: Container(
  //       height: MediaQuery.of(context).size.height / 3.5,
  //       width: double.infinity,
  //       decoration: BoxDecoration(
  //         color: context.isDarkMode ? const Color(0xff2C2B2B) : Colors.white,
  //         borderRadius: const BorderRadius.only(
  //           bottomRight: Radius.circular(50),
  //           bottomLeft: Radius.circular(50),
  //         ),
  //       ),
  //       child: BlocBuilder<ProfileInfoCubit, ProfileInfoState>(
  //         builder: (context, state) {
  //           if (state is ProfileInfoLoading) {
  //             return Center(child: const CircularProgressIndicator());
  //           }
  //           if (state is ProfileInfoLoaded) {
  //             return Column(
  //               mainAxisAlignment: MainAxisAlignment.center,
  //               children: [
  //                 Container(
  //                   height: 90,
  //                   width: 90,
  //                   decoration: BoxDecoration(
  //                     shape: BoxShape.circle,
  //                     image: DecorationImage(
  //                       image: NetworkImage(state.userEntity.imageURL!),
  //                     ),
  //                   ),
  //                 ),
  //                 const SizedBox(height: 15),
  //                 Text(
  //                   state.userEntity.fullName!,
  //                   style: const TextStyle(
  //                     fontSize: 22,
  //                     fontWeight: FontWeight.bold,
  //                   ),
  //                 ),
  //                 const SizedBox(height: 10),
  //                 Text(state.userEntity.email!),
  //               ],
  //             );
  //           }
  //           if (state is ProfileInfoFailure) {
  //             return const Center(child: Text('Please try again'));
  //           }
  //           return Container();
  //         },
  //       ),
  //     ),
  //   );
  // }
  Widget _profileInfo(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileInfoCubit()..getUser(),
      child: Container(
        height: MediaQuery.of(context).size.height / 3.5,
        width: double.infinity,
        decoration: BoxDecoration(
          color: context.isDarkMode ? const Color(0xff2C2B2B) : Colors.white,
          borderRadius: const BorderRadius.only(
            bottomRight: Radius.circular(50),
            bottomLeft: Radius.circular(50),
          ),
        ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomRight,
              child: SvgPicture.asset(AppVectors.bottomPattern),
            ),
            BlocBuilder<ProfileInfoCubit, ProfileInfoState>(
              builder: (context, state) {
                if (state is ProfileInfoLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is ProfileInfoLoaded) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Container(
                          height: 90,
                          width: 90,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: NetworkImage(state.userEntity.imageURL ?? ''),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      Text(
                        state.userEntity.fullName ?? 'No Name',
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(state.userEntity.email ?? 'No Email'),
                    ],
                  );
                } else if (state is ProfileInfoFailure) {
                  return const Center(child: Text('Please try again'));
                } else {
                  return Container(); // This is the default case
                }
              },
            ),
          ],
        ),
      ),
    );
  }


  Widget _favoriteSongs() {
    return BlocProvider(
      create: (context) => FavoriteSongsCubit()..getFavoriteSongs(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('FAVORITE SONGS'),
            const SizedBox(height: 20),
            BlocBuilder<FavoriteSongsCubit, FavoriteSongsState>(
              builder: (context, state) {
                if (state is FavoriteSongsLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state is FavoriteSongsLoaded) {
                  return Expanded(
                    child: ListView.separated(
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final song = state.favoriteSongs[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) => SongPlayer(
                                  playlist: state.favoriteSongs,
                                  startIndex: index,
                                ),
                              ),
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    height: 70,
                                    width: 70,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      image: DecorationImage(
                                        image: NetworkImage(
                                          '${AppURLs.coverFirestorage}${song.artist} - ${song.title}.jpg?${AppURLs.mediaAlt}',
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width*0.4,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          song.title,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        Text(
                                          song.artist,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 11,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    song.duration.toString().replaceAll('.', ':'),
                                  ),
                                  const SizedBox(width: 20),
                                  FavoriteButton(
                                    songEntity: song,
                                    key: UniqueKey(),
                                    function: () {
                                      context.read<FavoriteSongsCubit>().removeSong(index);
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => const SizedBox(height: 10),
                      itemCount: state.favoriteSongs.length,
                    ),
                  );
                }
                if (state is FavoriteSongsFailure) {
                  return const Center(child: Text('Please try again.'));
                }
                return Container();
              },
            ),
          ],
        ),
      ),
    );
  }
}
