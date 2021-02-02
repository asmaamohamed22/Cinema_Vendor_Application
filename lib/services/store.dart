import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:cinema_vendor_app/constant.dart';
import 'package:cinema_vendor_app/models/movie.dart';

class Store {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  addMovie(Movie movie) async {
    await _firestore.collection(kMoviesCollection).add({
      kMovieImage: movie.pImage,
      kMovieTitle: movie.pTitle,
      kMovieDescription: movie.pDescription,
      kMovieTime: movie.pMovieTime,
      kMovieNumberSeats: movie.pNumberSeats,
      kMovieCategory: movie.pCategory,
      kSeats: movie.pseats,
    });
  }

  Future<DocumentSnapshot> getSingleMovie({@required String movieId}) async {
    print("=-=movie id >>>> $movieId");
    DocumentSnapshot movieData =
        await _firestore.collection('Movies').doc(movieId).get();

    return movieData;
  }

  Stream<QuerySnapshot> loadMovie() {
    return _firestore.collection(kMoviesCollection).snapshots();
  }

  Stream<QuerySnapshot> loadAllNotifications() {
    return _firestore.collection('Notifications').snapshots();
  }

  deleteMovie(documentId) async {
    await _firestore.collection(kMoviesCollection).doc(documentId).delete();
  }

  editMovie(data, documentId) async {
    await _firestore.collection(kMoviesCollection).doc(documentId).update(data);
  }
}
