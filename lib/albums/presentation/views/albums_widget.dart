import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:test_test/albums/data/models/albums_model.dart';
import 'package:test_test/albums/data/models/photos_model.dart';

class AlbumWidget extends StatefulWidget {
  final Album album;
  final List<Photo> photos;
  const AlbumWidget({super.key, required this.album, required this.photos});

  @override
  State<AlbumWidget> createState() => _AlbumWidgetState();
}

class _AlbumWidgetState extends State<AlbumWidget> {
  late ScrollController _scrollController;
  late List<Photo> _extendedPhotos;
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
    _extendedPhotos = [...widget.photos];
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      setState(() {
        _extendedPhotos.addAll(widget.photos);
      });
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            widget.album.title,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        Visibility(
          visible: _extendedPhotos.isNotEmpty,
          child: SizedBox(
            height: 150,
            child: ListView.builder(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              itemCount: _extendedPhotos.length,
              itemBuilder: (context, index) {
                final photo = _extendedPhotos[index];
                return Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: CachedNetworkImage(
                    imageUrl: photo.url,
                    width: 120,
                    height: 120,
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) => ColoredBox(
                          color: Colors.grey[200]!,
                          child: SizedBox(height: 120, width: 120),
                        ),

                    errorWidget: (context, url, error) => Image.network(
                      'https://dummyimage.com/120x120/cccccc/ffffff&text=$index',
                      width: 120,
                      height: 120,
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
