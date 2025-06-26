import 'package:test_test/albums/data/models/albums_model.dart';
import 'package:test_test/albums/data/models/photos_model.dart';

abstract class AlbumsDataSource {
  Future<List<Album>> fetchAlbums();
  Future<List<Photo>> fetchPhotos(int albumId);
}
