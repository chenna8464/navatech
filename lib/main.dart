import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:test_test/albums/data/models/albums_model.dart';
import 'package:test_test/albums/data/models/photos_model.dart';
import 'package:test_test/albums/presentation/views/albums_page.dart';
import 'package:test_test/injection_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  injectionContainer();
  Hive.registerAdapter(AlbumAdapter());
  Hive.registerAdapter(PhotoAdapter());

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Navatech Assignment',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: AlbumListPage(),
    );
  }
}
