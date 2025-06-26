import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_test/albums/data/models/albums_model.dart';
import 'package:test_test/albums/data/models/photos_model.dart';
import 'package:test_test/albums/domain/repository/repository.dart';
import 'package:test_test/albums/presentation/bloc/album_event.dart';

part 'album_state.dart';

class AlbumBloc extends Bloc<AlbumEvent, AlbumState> {
  final AlbumRepository repository;
  AlbumBloc(this.repository) : super(AlbumInitial()) {
    List<Album> albums = [];
    Map<int, List<Photo>> photos = {};

    on<LoadAlbums>((event, emit) async {
      emit(AlbumLoading());
      try {
        final albums = await repository.fetchAlbums();
        albums.fold(
          (e) {
            emit(AlbumError(e.message));
          },
          (success) async {
            await fetchPhotos(success);
          },
        );
      } catch (e) {
        emit(AlbumError(e.toString()));
      }
    });

    on<AppendAlbums>((event, emit) {
      final appendedAlbums = List.of(albums)..addAll(albums);
      albums = appendedAlbums;
      emit(AlbumLoaded(albums, photos));
    });

    on<AppendPhotos>((event, emit) {
      final albumId = event.albumId;
      final currentPhotos = photos[albumId] ?? [];
      final newPhotos = List.of(currentPhotos)..addAll(currentPhotos);
      photos[albumId] = newPhotos;
      emit(AlbumLoaded(albums, photos));
    });
  }

  Future<void> fetchPhotos(List<Album> albums) async {
    final photosMap = <int, List<Photo>>{};
    for (Album album in albums) {
      final photos = await repository.fetchPhots(album.id);
      photos.fold(
        (e) {
          emit(AlbumError(e.message));
        },
        (success) async {
          photosMap[album.id] = success;
        },
      );
    }
    emit(AlbumLoaded(albums, photosMap));
  }
}
