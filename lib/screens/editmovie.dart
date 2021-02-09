import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:async';
import 'package:path/path.dart' as p;
import 'package:cinema_vendor_app/models/movie.dart';
import 'package:cinema_vendor_app/services/store.dart';
import 'package:cinema_vendor_app/constant.dart';
import 'package:cinema_vendor_app/screens/admin_home.dart';
import 'package:cinema_vendor_app/widgets/button.dart';

class EditMovie extends StatefulWidget {
  static String id = 'EditMovie';

  @override
  _EditMovieState createState() => _EditMovieState();
}

class _EditMovieState extends State<EditMovie> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String _title, _description, _time, _number_of_seats, _category;
  Movie movie;
  final _store = Store();

  File _file;
  void getImage({ImageSource source}) async {
    final myfile = await ImagePicker().getImage(source: source);
    if (myfile != null) {
      setState(() {
        _file = File(myfile.path);
      });
    }
  }

  Future<void> myDialogBox(context) {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  ListTile(
                    leading: Icon(Icons.camera_alt),
                    title: Text("Pick Form Camera"),
                    onTap: () {
                      getImage(source: ImageSource.camera);
                      Navigator.of(context).pop();
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.photo_library),
                    title: Text("Pick Form Gallery"),
                    onTap: () {
                      getImage(source: ImageSource.gallery);
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  String _url;

  Future<String> _uploadImage({File image}) async {
    try {
      FirebaseStorage storage =
          FirebaseStorage(storageBucket: 'gs://cinema-3f183.appspot.com');
      StorageReference ref = storage.ref().child(p.basename(image.path));
      StorageUploadTask storageUploadTask = ref.putFile(image);
      StorageTaskSnapshot snapshot = await storageUploadTask.onComplete;
      String imageUrl = await snapshot.ref.getDownloadURL();
      print('imageUrl $imageUrl');
      setState(() {
        _url = imageUrl;
      });

      return imageUrl;
    } catch (ex) {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text(ex.message),
        ),
      );
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Movie movie = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          'Update Movie',
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
            size: 30,
          ),
          onPressed: () {
            Navigator.pushNamed(context, AdminHome.id);
          },
        ),
      ),
      body: Form(
        key: _formKey,
        child: Container(
          width: double.infinity,
          child: SingleChildScrollView(
            child: Stack(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        child: CircleAvatar(
                          maxRadius: 70,
                          backgroundColor: kBackground,
                          child: CircleAvatar(
                            maxRadius: 65,
                            backgroundImage: () {
                              if (_file != null) {
                                return FileImage(_file);
                              } else if (movie.pImage != null) {
                                return NetworkImage(movie.pImage);
                              } else {
                                return AssetImage("assets/images/movie.jpg");
                              }
                            }(),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.04,
                      ),
                      TextFormField(
                        onSaved: (value) {
                          _title = value;
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Title Is required';
                          } else {
                            return null;
                          }
                        },
                        initialValue: movie.pTitle ?? "",
                        decoration: kTextFieldDecoration.copyWith(
                          hintText: 'Title',
                          prefixIcon: Icon(
                            Icons.title,
                            color: kBackground,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      TextFormField(
                        onSaved: (value) {
                          _description = value;
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Description Is required';
                          } else {
                            return null;
                          }
                        },
                        initialValue: movie.pDescription ?? "",
                        decoration: kTextFieldDecoration.copyWith(
                          hintText: 'Description',
                          prefixIcon: Icon(
                            Icons.description,
                            color: kBackground,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      TextFormField(
                        onSaved: (value) {
                          _time = value;
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Time Is required';
                          } else {
                            return null;
                          }
                        },
                        initialValue: movie.pMovieTime ?? "",
                        decoration: kTextFieldDecoration.copyWith(
                          hintText: 'Movie time',
                          prefixIcon: Icon(
                            Icons.timer,
                            color: kBackground,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      TextFormField(
                        onSaved: (value) {
                          _number_of_seats = value;
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Number of seats Is required';
                          } else {
                            return null;
                          }
                        },
                        initialValue: movie.pNumberSeats ?? "",
                        decoration: kTextFieldDecoration.copyWith(
                          hintText: 'Number of seat',
                          prefixIcon: Icon(
                            Icons.confirmation_number,
                            color: kBackground,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      TextFormField(
                        onSaved: (value) {
                          _category = value;
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Category is required';
                          } else {
                            return null;
                          }
                        },
                        initialValue: movie.pCategory ?? "",
                        decoration: kTextFieldDecoration.copyWith(
                          hintText: 'Category',
                          prefixIcon: Icon(
                            Icons.category,
                            color: kBackground,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.04,
                      ),
                      MyButton(
                        name: 'Edit Movie',
                        onPressed: () async {
                          if (!_formKey.currentState.validate()) {
                            return;
                          } else if (_file == null) {
                            _scaffoldKey.currentState.showSnackBar(
                              SnackBar(
                                content: Text("Image Is required"),
                              ),
                            );
                            return;
                          } else {
                            _formKey.currentState.save();
                            String imageUrl = await _uploadImage(image: _file);

                            _store
                                .editMovie(
                                    ({
                                      kMovieImage: imageUrl,
                                      kMovieTitle: _title,
                                      kMovieDescription: _description,
                                      kMovieTime: _time,
                                      kMovieNumberSeats: _number_of_seats,
                                      kMovieCategory: _category,
                                    }),
                                    movie.pId)
                                .then((value) {
                              _scaffoldKey.currentState.showSnackBar(
                                SnackBar(
                                  content: Text("Movie edited successfully"),
                                ),
                              );
                            });
                          }
                        },
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 110,
                  left: 240,
                  child: CircleAvatar(
                    maxRadius: 20,
                    backgroundColor: kBackground,
                    child: IconButton(
                      onPressed: () {
                        myDialogBox(context);
                      },
                      icon: Icon(
                        Icons.camera_alt_outlined,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
