import 'package:json_annotation/json_annotation.dart';
part 'trip.g.dart';

@JsonSerializable()
class Trip{
  final int id;
  final String title;
  final String destination;
  final int numberOfDays;
  final int numberOfPeople;
  final String imageUrl;
  final String description;
  final String creator;

  Trip({
  required this.id,
  required this.title, 
  required this.destination, 
  required this.numberOfDays, 
  required this.numberOfPeople, 
  required this.imageUrl,
  required this.description,
  required this.creator,
  });

  factory Trip.fromJson(Map<String, dynamic> json) => _$TripFromJson(json); 
  Map<String, dynamic> toJson() => _$TripToJson(this); 
}