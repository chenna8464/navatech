import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_test/albums/presentation/bloc/album_bloc.dart';
import 'package:test_test/albums/presentation/bloc/album_event.dart'
    hide AlbumState;
import 'package:test_test/albums/presentation/views/albums_widget.dart';

class AlbumsScreen extends StatefulWidget {
  const AlbumsScreen({super.key});

  @override
  State<AlbumsScreen> createState() => _AlbumsScreenState();
}

class _AlbumsScreenState extends State<AlbumsScreen> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<AlbumBloc>(context).add(LoadAlbums());
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 300) {
      context.read<AlbumBloc>().add(AppendAlbums());
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AlbumBloc, AlbumState>(
      builder: (context, state) {
        if (state is AlbumLoading) {
          return Center(child: CircularProgressIndicator());
        }

        if (state is AlbumLoaded) {
          final albums = state.albums;
          if (albums.isEmpty) {
            return Center(child: Text('No albums found'));
          }

          return ListView.builder(
            controller: _scrollController,
            itemCount: albums.length,
            itemBuilder: (context, index) {
              final album = albums[index];
              final photos = state.photos[album.id] ?? [];
              return AlbumWidget(album: album, photos: photos);
            },
          );
        }
        if (state is AlbumError) return Center(child: Text(state.message));
        return SizedBox();
      },
    );
  }
}
