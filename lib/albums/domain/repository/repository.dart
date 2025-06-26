import 'package:dartz/dartz.dart';
import 'package:test_test/albums/data/models/albums_model.dart';
import 'package:test_test/albums/data/models/api_failure_model.dart';
import 'package:test_test/albums/data/models/photos_model.dart';

abstract class AlbumRepository {
  Future<Either<ApiFailureModel, List<Album>>> fetchAlbums();
  Future<Either<ApiFailureModel, List<Photo>>> fetchPhots(int albumId);
}
