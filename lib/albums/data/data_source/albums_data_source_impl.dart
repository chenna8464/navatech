import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:test_test/albums/data/data_source/albums_data_source.dart';
import 'package:test_test/albums/data/models/albums_model.dart';
import 'package:test_test/albums/data/models/photos_model.dart';

class AlbumsDataSourceImpl implements AlbumsDataSource {
  final Dio _dio = Dio(
    BaseOptions(baseUrl: 'http://jsonplaceholder.typicode.com'),
  );

  @override
  Future<List<Album>> fetchAlbums() async {
    final box = await Hive.openBox<Album>('albums');
    if (box.isNotEmpty) return box.values.toList();

    final response = await _dio.get('/albums');
    final albums = (response.data as List)
        .map((e) => Album.fromJson(e))
        .toList()
        .take(10)
        .toList(); // Limit to 100 albums
    await box.addAll(albums);
    return albums;
  }

  @override
  Future<List<Photo>> fetchPhotos(int albumId) async {
    final box = await Hive.openBox<Photo>('photos');
    final existing = box.values.where((p) => p.albumId == albumId).toList();
    if (existing.isNotEmpty) return existing;

    final response = await _dio.get(
      '/photos',
      queryParameters: {'albumId': albumId},
    );
    final photos = (response.data as List)
        .map((e) => Photo.fromJson(e))
        .toList()
        .take(10)
        .toList(); // Limit to 100 photos
    await box.addAll(photos);
    return photos;
  }
}
