import 'package:flutter/material.dart';

class Movie {
  String pId;
  String pTitle;
  String pDescription;
  String pMovieTime;
  String pNumberSeats;
  String pCategory;
  String pImage;

  List<Map<String, dynamic>> pseats;

  Movie({
    this.pId,
    @required this.pImage,
    @required this.pTitle,
    @required this.pDescription,
    @required this.pMovieTime,
    @required this.pNumberSeats,
    @required this.pCategory,
    this.pseats,
  });
}
