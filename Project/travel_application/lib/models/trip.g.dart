// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trip.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Trip _$TripFromJson(Map<String, dynamic> json) => Trip(
      id: json['id'] as int,
      title: json['title'] as String? ?? "Заголовок не задан" ,
      destination: json['destination'] as String? ?? "Заголовок не задан",
      numberOfDays: json['numberOfDays'] as int,
      numberOfPeople: json['numberOfPeople'] as int,
      imageUrl: json['imageUrl'] as String? ?? "Заголовок не задан",
      description: json['description'] as String? ?? "Заголовок не задан",
      creator: json['creator'] as String? ?? "Заголовок не задан",
    );

Map<String, dynamic> _$TripToJson(Trip instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'destination': instance.destination,
      'number_of_days': instance.numberOfDays,
      'number_of_people': instance.numberOfPeople,
      'image_url': instance.imageUrl,
      'description': instance.description,
      'creator': instance.creator,
    };
