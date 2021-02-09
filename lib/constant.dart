import 'package:flutter/material.dart';

Color kBackgroundColor = Color(0xFFF5D5B0);
Color kBackground = Color(0xFFF9A826);

const kTextFieldDecoration = InputDecoration(
  hintText: 'Enter a value',
  contentPadding: EdgeInsets.symmetric(vertical: 18.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(30.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xFFF5D5B0), width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(30.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xFFF5D5B0), width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(30.0)),
  ),
);

const kMovieImage = 'movieImage';
const kMovieTitle = 'movieTitle';
const kMovieDescription = 'movieDescription';
const kMovieTime = 'movieTime';
const kMovieNumberSeats = 'movieNumberSeats';
const kMovieCategory = 'movieCategory';
const kSeats = 'seats';
const kMoviesCollection = 'Movies';
