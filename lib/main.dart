import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movieapp/constants.dart';
import 'package:movieapp/favorite.dart';
import 'package:movieapp/splashscreen.dart';
import 'package:movieapp/utils/text.dart';
import 'package:movieapp/widget/toprated.dart';
import 'package:movieapp/widget/trending.dart';
import 'package:movieapp/widget/tv.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: import_of_legacy_library_into_null_safe
import 'package:tmdb_api/tmdb_api.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
      theme: ThemeData(brightness: Brightness.dark, primaryColor: Colors.black),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List trendingMovie = [];
  List topRated = [];
  List tv = [];

  //to run loadMovie calling intistate
  @override
  void initState() {
    _loadMovie();
    configureSharedPreferences();
    super.initState();
  }

  void configureSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();

    if (prefs.getStringList('fav_movies') == null) {
      prefs.setStringList('fav_movies', []);
    };
  }

  //fetching data from api
  _loadMovie() async {
    TMDB tmdbcustom = TMDB(ApiKeys(kApikey, kReadAccessToken),
        logConfig: ConfigLogger(showLogs: true, showErrorLogs: true));
    Map trendingListResult = await tmdbcustom.v3.trending.getTrending();
    Map topListResult = await tmdbcustom.v3.movies.getTopRated();
    Map tvListResult = await tmdbcustom.v3.tv.getPopular();
    //for changing the state
    setState(() {
      trendingMovie = trendingListResult['results'];
      topRated = topListResult['results'];
      tv = tvListResult['results'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const font_text(
          text: 'Movie App',
          color: Colors.white,
          size: 20,
        ),
        actions: <Widget>[
          Row(
            children: [
              const font_text(text: 'Favorite', color: Colors.white, size: 18),
              IconButton(
                icon: const Icon(
                  Icons.favorite,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Favorite()),
                  );
                },
              ),
            ],
          )
        ],
      ),
      body: ListView(
        children: [
          CarouselSlider(
            items: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                margin: EdgeInsets.all(6.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  image: DecorationImage(
                    image: NetworkImage(
                        "https://thathashtagshow.com/wp-content/uploads/2022/09/Violent-Night-Cover-1200x640.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              //2nd Image of Slider
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                margin: EdgeInsets.all(6.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  image: DecorationImage(
                    image: NetworkImage(
                        "https://www.cnet.com/a/img/resize/bc48bbd2f4dbb7f5799eb4bc28bdcf6f19f6f408/hub/2022/05/10/708507de-bb07-4c16-9a94-bbf206a59fd5/avatar.jpg?auto=webp&fit=crop&height=675&width=1200"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              //3rd Image of Slider
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                margin: EdgeInsets.all(6.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  image: DecorationImage(
                    image: NetworkImage(
                        "https://static.wikia.nocookie.net/bossbaby/images/b/bf/The_Boss_Baby.jpg/revision/latest?cb=20180407164527"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              //4th Image of Slider
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                margin: EdgeInsets.all(6.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  image: DecorationImage(
                    image: NetworkImage(
                        "https://mir-s3-cdn-cf.behance.net/projects/404/88afbd157455381.Y3JvcCw0MjA0LDMyODksNDQ3LDA.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
            options: CarouselOptions(
              height: 180.0,
              enlargeCenterPage: true,
              autoPlay: true,
              aspectRatio: 16 / 9,
              autoPlayCurve: Curves.fastOutSlowIn,
              enableInfiniteScroll: true,
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              viewportFraction: 0.8,
            ),
          ),
          TrendingMovie(trending: trendingMovie),
          TvMovie(tvrated: tv),
          TopRatedMovie(toprated: topRated)
        ],
      ),
    );
  }
}
