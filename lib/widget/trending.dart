import 'package:flutter/material.dart';
import 'package:movieapp/description.dart';
import 'package:movieapp/utils/text.dart';
import 'package:tmdb_api/tmdb_api.dart';
import 'package:logger/logger.dart' as PrintLog;
import '../constants.dart';

class TrendingMovie extends StatelessWidget {
  final List trending;

  const TrendingMovie({Key? key, required this.trending}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            font_text(text: 'Trending Movie', color: Colors.white, size: 30),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 270,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: trending.length,
                  itemBuilder: (context, index) {
                    //for description
                    return InkWell(
                        onTap: () async {
                          TMDB tmdb = TMDB(ApiKeys(kApikey, kReadAccessToken),
                              logConfig: ConfigLogger(
                                  showLogs: true, showErrorLogs: true));
                          Map result = await tmdb.v3.movies
                              .getVideos(trending[index]['id']);
                          var teaser, trailer;
                          for (result in result['results']) {
                            if (teaser == null || trailer == null) {
                              switch (result['type'].toString().toLowerCase()) {
                                case 'teaser':
                                  teaser = result;
                                  break;
                                case 'trailer':
                                  trailer = result;
                                  break;
                                default:
                                  break;
                              }
                            }
                          }

                          print(teaser.runtimeType);
                          print("\n");
                          print(trailer);
                          // print(result['results'][2]);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Description(

                                  id: trending[index]['id'],
                                  name: trending[index]['original_title'],
                                  description: trending[index]['overview'],
                                  bannerurl: 'https://image.tmdb.org/t/p/w500' +
                                      trending[index]['backdrop_path'],
                                  posterurl: 'https://image.tmdb.org/t/p/w500' +
                                      trending[index]['poster_path'],
                                  vote: trending[index]['vote_average']
                                      .toString(),
                                  trailer: trailer,
                                  teaser: teaser,
                                  launch_on: trending[index]['release_date']),
                            ),
                          );
                        },
                        child: trending[index]['original_title'] != null
                            ? Container(
                                width: 140,
                                child: Column(
                                  children: [
                                    Container(
                                      height: 200,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                  'https://image.tmdb.org/t/p/w500' +
                                                      trending[index]
                                                          ['poster_path']))),
                                    ),
                                    Container(
                                      child: font_text(
                                          // ignore: prefer_if_null_operators
                                          text: trending[index]
                                                      ['original_title'] !=
                                                  null
                                              ? trending[index]
                                                  ['original_title']
                                              : 'Loading',
                                          color: Colors.white,
                                          size: 15),
                                    ),
                                  ],
                                ),
                              )
                            : Container());
                  }),
            ),
          ],
        ));
  }
}
