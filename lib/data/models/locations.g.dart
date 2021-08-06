// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'locations.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Locations _$LocationFromJson(Map<String, dynamic> json) {
  return Locations(
    id: json['id'] as int?,
    name: json['name'] as String?,
    type: json['type'] as String?,
    dimension: json['dimension'] as String?,
    residents:
        (json['residents'] as List<dynamic>?)?.map((e) => e as String).toList(),
    url: json['url'] as String?,
    created: json['created'] as String?,
  );
}

Map<String, dynamic> _$LocationToJson(Locations instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'type': instance.type,
      'dimension': instance.dimension,
      'residents': instance.residents,
      'url': instance.url,
      'created': instance.created,
    };
