import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_test/albums/presentation/bloc/album_bloc.dart';
import 'package:test_test/albums/presentation/views/albums_screen.dart';
import 'package:test_test/injection_container.dart';

class AlbumListPage extends StatelessWidget {
  const AlbumListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AlbumBloc(sl()),
      child: Scaffold(
        appBar: AppBar(title: Text("Infinite Albums")),
        body: AlbumsScreen(),
      ),
    );
  }
}
