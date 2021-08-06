import 'package:json_annotation/json_annotation.dart';

part 'episode.g.dart';

@JsonSerializable()
class Episode {
  final int? id;
  final String? name;
  final String? air_date;
  final String? episode;
  final List<String>? characters;
  final String? url;
  final String? created;

  Episode({this.id, this.name, this.air_date, this.episode, this.characters, this.url, this.created});

  factory Episode.fromJson(Map<String, dynamic> json) =>
      _$EpisodeFromJson(json);

  Map<String, dynamic> toJson() => _$EpisodeToJson(this);
}
