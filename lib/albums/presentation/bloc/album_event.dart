abstract class AlbumEvent {}

class LoadAlbums extends AlbumEvent {}

abstract class AlbumState {}

class AlbumInitial extends AlbumState {}

class AppendAlbums extends AlbumEvent {} // 🔥 new event

class AppendPhotos extends AlbumEvent {
  final int albumId;

  AppendPhotos(this.albumId);
}
