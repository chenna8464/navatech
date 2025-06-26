import 'package:hive/hive.dart';

part 'photos_model.g.dart';

@HiveType(typeId: 1)
class Photo {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String url;
  @HiveField(2)
  final int albumId;

  Photo({required this.id, required this.url, required this.albumId});

  factory Photo.fromJson(Map<String, dynamic> json) =>
      Photo(id: json['id'], url: json['url'], albumId: json['albumId']);
}
