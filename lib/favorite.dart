import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:movieapp/utils/text.dart';
import 'package:movieapp/widget/favourites.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tmdb_api/tmdb_api.dart';

import 'constants.dart';

class Favorite extends StatefulWidget {
  const Favorite({key});

  @override
  State<Favorite> createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  var movieList = [];

  @override
  void initState() {
    super.initState();
    _loadMovie();
  }

  _loadMovie() async {
    TMDB tmdbcustom = TMDB(ApiKeys(kApikey, kReadAccessToken),
        logConfig: ConfigLogger(showLogs: true, showErrorLogs: true));

    final prefs = await SharedPreferences.getInstance();
    final fav_movies_id = prefs.getStringList('fav_movies');
    if (fav_movies_id == null) {
      return;
    }

    fav_movies_id.forEach((element) async {
      Map movie = await tmdbcustom.v3.movies.getDetails(int.parse(element));
      print(movie);
      setState(() {
        movieList.add(movie);
      });
    });

    //for changing the state

    // print(movieList);
    // print(tv);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
            backgroundColor: Colors.transparent,
            title: const font_text(
              text: 'Favorite',
              color: Colors.white,
              size: 20,
            )),
        body: movieList.length > 0
            ? RefreshIndicator(
                onRefresh: () async {
                  _loadMovie();
                },
                child: Container(
                    child: FavouriteMovie(
                  movie_list: movieList,
                )),
              )
            : Center(
                child: Text('No Favourites'),
              ));
  }
}
