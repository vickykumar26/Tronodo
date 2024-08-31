import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tronodo/domain/entities/song/song.dart';
import 'package:tronodo/presentation/song_player/bloc/song_player_cubit.dart';
import 'package:tronodo/presentation/song_player/bloc/song_player_state.dart';
import '../../../common/widgets/favorite_button/favorite_button.dart';
import '../../../core/configs/constants/app_urls.dart';
import '../../../core/configs/theme/app_colors.dart';

class SongPlayer extends StatefulWidget {
  final List<SongEntity> playlist;
  final int startIndex;

  const SongPlayer({
    required this.playlist,
    required this.startIndex,
    super.key,
  });

  @override
  State<SongPlayer> createState() => _SongPlayerState();
}

class _SongPlayerState extends State<SongPlayer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Now playing', style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),
      ),
      body: BlocProvider(
        create: (_) => SongPlayerCubit()..loadPlaylist(widget.playlist, widget.startIndex),
        child: BlocBuilder<SongPlayerCubit, SongPlayerState>(
          builder: (context, state) {
            if (state is SongPlayerLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is SongPlayerLoaded) {
              final song = state.currentSong;
              return SingleChildScrollView(
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                child: Column(
                  children: [
                    _songCover(context, song),
                    const SizedBox(height: 20),
                    _songDetail(context, song),
                    const SizedBox(height: 30),
                    _songPlayer(context, state),
                  ],
                ),
              );
            }
            return Center(child: Text('Error loading song'));
          },
        ),
      ),
    );
  }

  Widget _songCover(BuildContext context, SongEntity song) {
    return Container(
      height: MediaQuery.of(context).size.height / 2,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(
              '${AppURLs.coverFirestorage}${song.artist} - ${song.title}.jpg?${AppURLs.mediaAlt}'),
        ),
      ),
    );
  }

  Widget _songDetail(BuildContext context, SongEntity song) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              song.title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            ),
            const SizedBox(height: 5),
            Text(
              song.artist,
              style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
            ),
          ],
        ),
        FavoriteButton(songEntity: song),
      ],
    );
  }

  Widget _songPlayer(BuildContext context, SongPlayerLoaded state) {
    return Column(
      children: [
        SliderTheme(
          data: SliderThemeData(
            activeTrackColor: AppColors.primary,
            inactiveTrackColor: AppColors.primary.withOpacity(0.3),
            thumbColor: AppColors.primary,
            overlayColor: AppColors.primary.withOpacity(0.2),
            trackHeight: 4.0,
            thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8.0),
            overlayShape: const RoundSliderOverlayShape(overlayRadius: 16.0),
          ),
          child: Slider(
            value: state.songPosition.inSeconds.toDouble(),
            min: 0.0,
            max: state.songDuration.inSeconds.toDouble(),
            onChanged: (value) {
              context.read<SongPlayerCubit>().seekTo(Duration(seconds: value.toInt()));
            },
          ),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(formatDuration(state.songPosition)),
            Text(formatDuration(state.songDuration)),
          ],
        ),
        const SizedBox(height: 20),
        GestureDetector(
          onTap: () {
            context.read<SongPlayerCubit>().playOrPauseSong();
          },
          child: Container(
            height: 60,
            width: 60,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.primary,
            ),
            child: Center(
              child: Icon(
                state.isPlaying ? Icons.pause : Icons.play_arrow,
                color: Colors.white,
                size: 30,
              ),
            ),
          ),
        ),
      ],
    );
  }

  String formatDuration(Duration duration) {
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }
}
