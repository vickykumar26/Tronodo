import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:tronodo/domain/entities/song/song.dart';

@immutable
abstract class SongPlayerState extends Equatable {
  const SongPlayerState();

  @override
  List<Object?> get props => [];
}

class SongPlayerInitial extends SongPlayerState {}

class SongPlayerLoading extends SongPlayerState {
  final SongEntity currentSong;

  const SongPlayerLoading({required this.currentSong});

  @override
  List<Object?> get props => [currentSong];
}

class SongPlayerLoaded extends SongPlayerState {
  final SongEntity currentSong;
  final Duration songPosition;
  final Duration songDuration;
  final bool isPlaying;

  const SongPlayerLoaded({
    required this.currentSong,
    required this.songPosition,
    required this.songDuration,
    required this.isPlaying,
  });

  @override
  List<Object?> get props => [currentSong, songPosition, songDuration, isPlaying];
}

class SongPlayerError extends SongPlayerState {
  final String message;

  const SongPlayerError(this.message);

  @override
  List<Object?> get props => [message];
}


