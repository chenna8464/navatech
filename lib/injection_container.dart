import 'package:get_it/get_it.dart';
import 'package:test_test/albums/data/data_source/albums_data_source.dart';
import 'package:test_test/albums/data/data_source/albums_data_source_impl.dart';
import 'package:test_test/albums/data/repository_impl/albums_repository_impl/albums_repository_impl.dart';
import 'package:test_test/albums/domain/repository/repository.dart';

final sl = GetIt.instance;

injectionContainer() {
  sl.registerLazySingleton<AlbumsDataSource>(() => AlbumsDataSourceImpl());

  sl.registerLazySingleton<AlbumRepository>(
    () => AlbumRepositoryImpl(albumDataSource: sl()),
  );
}
