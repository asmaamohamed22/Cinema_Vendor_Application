import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:cinema_vendor_app/services/store.dart';
import 'package:cinema_vendor_app/models/movie.dart';
import 'package:cinema_vendor_app/constant.dart';
import 'package:cinema_vendor_app/screens/editmovie.dart';
import 'package:cinema_vendor_app/screens/admin_home.dart';

class GetMovie extends StatefulWidget {
  static String id = 'GetMovie';
  @override
  _GetMovieState createState() => _GetMovieState();
}

class _GetMovieState extends State<GetMovie> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _store = Store();
  Movie movie;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          '🍿 Movies',
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
      body: StreamBuilder<QuerySnapshot>(
          stream: _store.loadMovie(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Movie> movies = [];
              for (var doc in snapshot.data.docs) {
                var data = doc.data();
                movies.add(Movie(
                  pId: doc.id,
                  pImage: data[kMovieImage],
                  pTitle: data[kMovieTitle],
                  pDescription: data[kMovieDescription],
                  pMovieTime: data[kMovieTime],
                  pNumberSeats: data[kMovieNumberSeats],
                  pCategory: data[kMovieCategory],
                ));
              }
              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, childAspectRatio: 0.7),
                itemBuilder: (context, index) => Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  child: GestureDetector(
                    onTapUp: (details) {
                      double dx = details.globalPosition.dx;
                      double dy = details.globalPosition.dy;
                      double dx2 = MediaQuery.of(context).size.width - dx;
                      double dy2 = MediaQuery.of(context).size.width - dy;
                      showMenu(
                          context: context,
                          position: RelativeRect.fromLTRB(dx, dy, dx2, dy2),
                          items: [
                            MyPopupMenuItem(
                              onClick: () {
                                _store
                                    .deleteMovie(movies[index].pId)
                                    .then((value) {
                                  _scaffoldKey.currentState.showSnackBar(
                                    SnackBar(
                                      content:
                                          Text("Movie deleted successfully"),
                                    ),
                                  );
                                });
                                Navigator.pop(context);
                              },
                              child: Text('Delete'),
                            ),
                            MyPopupMenuItem(
                              onClick: () {
                                Navigator.pushNamed(context, EditMovie.id,
                                    arguments: movies[index]);
                              },
                              child: Text('Edit'),
                            ),
                          ]);
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      child: Stack(
                        children: [
                          Positioned.fill(
                            child: movies[index].pImage == null
                                ? Container()
                                : Image(
                                    fit: BoxFit.fill,
                                    image: NetworkImage(movies[index].pImage),
                                  ),
                          ),
                          Positioned(
                            bottom: 0,
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: 60,
                              color: Colors.black87,
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 4),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      movies[index].pTitle,
                                      style: TextStyle(
                                        color: kBackground,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      ),
                                    ),
                                    SizedBox(width: 6),
                                    Row(
                                      children: [
                                        Text(
                                          movies[index].pMovieTime,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                itemCount: movies.length,
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}

class MyPopupMenuItem<T> extends PopupMenuItem<T> {
  final Widget child;
  final Function onClick;
  MyPopupMenuItem({@required this.onClick, @required this.child})
      : super(child: child);

  @override
  PopupMenuItemState<T, PopupMenuItem<T>> createState() {
    return MyPopupMenuItemState();
  }
}

class MyPopupMenuItemState<T, PopupMenuItem>
    extends PopupMenuItemState<T, MyPopupMenuItem<T>> {
  @override
  void handleTap() {
    widget.onClick();
  }
}
