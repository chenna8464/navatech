// import 'package:chitcircle/core/base/base_exception.dart';
// import 'package:chitcircle/core/models/failure_model.dart';
// import 'package:chitcircle/features/chit/data/data_source/chit_data_source.dart';
// import 'package:chitcircle/features/chit/data/models/chit_list_success_model.dart';
// import 'package:chitcircle/features/chit/data/models/chits_req_model.dart';
// import 'package:chitcircle/features/chit/domain/repository/chit_repository.dart';
// import 'package:dartz/dartz.dart';

import 'package:dartz/dartz.dart';
import 'package:test_test/albums/data/data_source/albums_data_source.dart';
import 'package:test_test/albums/data/models/albums_model.dart';
import 'package:test_test/albums/data/models/api_failure_model.dart';
import 'package:test_test/albums/data/models/photos_model.dart';
import 'package:test_test/albums/domain/repository/repository.dart';
import 'package:test_test/base_exception.dart';

class AlbumRepositoryImpl extends BaseException implements AlbumRepository {
  final AlbumsDataSource albumDataSource;
  AlbumRepositoryImpl({required this.albumDataSource});
  @override
  Future<Either<ApiFailureModel, List<Album>>> fetchAlbums() async {
    return baseApiMethodExceptions(() async {
      final resp = await albumDataSource.fetchAlbums();
      return Right(resp);
    });
  }

  @override
  Future<Either<ApiFailureModel, List<Photo>>> fetchPhots(int albumId) {
    return baseApiMethodExceptions(() async {
      final resp = await albumDataSource.fetchPhotos(albumId);
      return Right(resp);
    });
  }
}
