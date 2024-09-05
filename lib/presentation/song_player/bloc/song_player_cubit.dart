import 'package:bloc/bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:tronodo/domain/entities/song/song.dart';
import 'package:tronodo/presentation/song_player/bloc/song_player_state.dart';

import '../../../core/configs/constants/app_urls.dart';

class SongPlayerCubit extends Cubit<SongPlayerState> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  final List<SongEntity> _playlist = [];
  int _currentIndex = 0;
  Duration songPosition = Duration.zero;
  Duration songDuration = Duration.zero;
  bool _isPlaying = false;

  SongPlayerCubit() : super(SongPlayerInitial()) {
    _audioPlayer.positionStream.listen((position) {
      songPosition = position;
      emit(SongPlayerLoaded(
        currentSong: _playlist[_currentIndex],
        songPosition: songPosition,
        songDuration: songDuration,
        isPlaying: _isPlaying,
      ));
    });

    _audioPlayer.playerStateStream.listen((state) {
      if (state.playing && state.processingState == ProcessingState.completed) {
        _playNextSong();
      }
      _isPlaying = state.playing;
      emit(SongPlayerLoaded(
        currentSong: _playlist[_currentIndex],
        songPosition: songPosition,
        songDuration: songDuration,
        isPlaying: _isPlaying,
      ));
    });
  }

  Future<void> loadPlaylist(List<SongEntity> playlist, int startIndex) async {
    _playlist.clear();
    _playlist.addAll(playlist);
    _currentIndex = startIndex;
    await _playCurrentSong();
  }

  Future<void> _playCurrentSong() async {
    if (_playlist.isEmpty) return;

    final song = _playlist[_currentIndex];
    try {
      emit(SongPlayerLoading(
        currentSong: song,
      ));
      await _audioPlayer.setUrl('${AppURLs.songFirestorage}${song.artist} - ${song.title}.mp3?${AppURLs.mediaAlt}');
      songDuration = _audioPlayer.duration ?? Duration.zero;
      _audioPlayer.play();
      _isPlaying = true;
      emit(SongPlayerLoaded(
        currentSong: song,
        songPosition: songPosition,
        songDuration: songDuration,
        isPlaying: _isPlaying,
      ));
    } catch (e) {
      emit(SongPlayerError(e.toString()));
    }
  }

  void _playNextSong() {
    if (_playlist.isEmpty) return;

    _currentIndex = (_currentIndex + 1) % _playlist.length; // Loop back to the start if at the end
    _playCurrentSong();
  }

  void playOrPauseSong() {
    if (_isPlaying) {
      _audioPlayer.pause();
      _isPlaying = false;
    } else {
      _audioPlayer.play();
      _isPlaying = true;
    }
    emit(SongPlayerLoaded(
      currentSong: _playlist[_currentIndex],
      songPosition: songPosition,
      songDuration: songDuration,
      isPlaying: _isPlaying,
    ));
  }

  void seekTo(Duration position) {
    _audioPlayer.seek(position);
  }

  @override
  Future<void> close() {
    _audioPlayer.dispose();
    return super.close();
  }
}







