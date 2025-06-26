part of 'album_bloc.dart';

abstract class AlbumState extends Equatable {
  const AlbumState();

  @override
  List<Object> get props => [];
}

class AlbumInitial extends AlbumState {}

class AlbumLoading extends AlbumState {}

class AlbumLoaded extends AlbumState {
  final List<Album> albums;
  final Map<int, List<Photo>> photos;
  const AlbumLoaded(this.albums, this.photos);
}

class AlbumError extends AlbumState {
  final String message;
  const AlbumError(this.message);
}
