import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'dart:async';
import 'package:path/path.dart' as p;
import 'package:cinema_vendor_app/constant.dart';
import 'package:cinema_vendor_app/services/store.dart';
import 'package:cinema_vendor_app/models/movie.dart';
import 'package:cinema_vendor_app/screens/admin_home.dart';
import 'package:cinema_vendor_app/widgets/button.dart';

class AddMovie extends StatefulWidget {
  static String id = 'AddMovie';
  @override
  _AddMovieState createState() => _AddMovieState();
}

class _AddMovieState extends State<AddMovie> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String _title, _description, _time, _number_of_seats, _category;
  Movie movie;
  final _store = Store();

  File _file;
  void getImage({ImageSource source}) async {
    final _myfile = await ImagePicker().getImage(source: source);

    if (_myfile != null) {
      setState(() {
        _file = File(_myfile.path);
      });
    }
  }

  String _url;

  Future<String> _uploadImage({File image}) async {
    try {
      FirebaseStorage storage =
          FirebaseStorage(storageBucket: 'gs://cinemaapp-6accc.appspot.com');
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

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          'Movie',
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
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
                            backgroundImage: _file == null
                                ? AssetImage("assets/images/movie.jpg")
                                : FileImage(_file),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.05,
                      ),
                      TextFormField(
                        onSaved: (value) {
                          _title = value;
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Title Is Empty';
                          } else {
                            return null;
                          }
                        },
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
                            return 'Description Is Empty';
                          } else {
                            return null;
                          }
                        },
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
                            return 'Time Is Empty';
                          } else {
                            return null;
                          }
                        },
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
                            return 'Number of seats Is Empty';
                          } else {
                            return null;
                          }
                        },
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
                            return 'Category Is Empty';
                          } else {
                            return null;
                          }
                        },
                        decoration: kTextFieldDecoration.copyWith(
                          hintText: 'Category',
                          prefixIcon: Icon(
                            Icons.category,
                            color: kBackground,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.05,
                      ),
                      MyButton(
                        name: 'Add Movie',
                        onPressed: () async {
                          if (!_formKey.currentState.validate()) {
                            return;
                          } else if (_file == null) {
                            _scaffoldKey.currentState.showSnackBar(
                              SnackBar(
                                content: Text("Movie image is required"),
                              ),
                            );
                            return;
                          } else {
                            _formKey.currentState.save();
                            String imageUrl = await _uploadImage(image: _file);
                            _store
                                .addMovie(Movie(
                              pseats: List.generate(
                                  47,
                                  (index) => {
                                        "id": index + 1,
                                        "isReserved": 0,
                                        "userId": ""
                                      }),
                              pImage: imageUrl,
                              pTitle: _title,
                              pDescription: _description,
                              pMovieTime: _time,
                              pNumberSeats: _number_of_seats,
                              pCategory: _category,
                            ))
                                .then((value) {
                              _scaffoldKey.currentState.showSnackBar(
                                SnackBar(
                                  content: Text("Movie added successfully"),
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
