import 'dart:io';
import 'package:dengue_zero/domain/models/place_location.dart';

class Denounces {
  final String userId;
  final String id;
  final String title;
  final PlaceLocation location;
  final File image;

  Denounces({
    required this.userId,
    required this.id,
    required this.title,
    required this.location,
    required this.image,
  });
}
