import 'package:flutter/material.dart';
import 'package:movieapp/utils/text.dart';
import 'package:tmdb_api/tmdb_api.dart';

import '../constants.dart';
import '../description.dart';

class TvMovie extends StatelessWidget {
  final List tvrated;

  const TvMovie({Key? key, required this.tvrated}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            font_text(text: 'Popular Tv Shows', color: Colors.white, size: 30),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 270,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: tvrated.length,
                  itemBuilder: (context, index) {
                    //for description
                    return InkWell(
                      onTap: () async {
                        TMDB tmdb = TMDB(ApiKeys(kApikey, kReadAccessToken),
                            logConfig: ConfigLogger(
                                showLogs: true, showErrorLogs: true));
                        // print(tvrated[index]);
                        // Map result = await tmdb.v3.tv.getVideos(tvrated[index]['id'].toString());
                        // var teaser, trailer;
                        // print('--------');
                        // print(result);
                        // for (result in result['results']) {
                        //   if (teaser == null || trailer == null) {
                        //     switch (result['type'].toString().toLowerCase()) {
                        //       case 'teaser':
                        //         teaser = result;
                        //         break;
                        //       case 'trailer':
                        //         trailer = result;
                        //         break;
                        //       default:
                        //         break;
                        //     }
                        //   }
                        // }
                        //
                        // print(teaser.runtimeType);
                        // print("\n");
                        // print(trailer);
                        // print(result['results'][2]);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Description(
                                    id: tvrated[index]['id'],
                                    name: tvrated[index]['original_name'],
                                    description: tvrated[index]['overview'],
                                    bannerurl:
                                        'https://image.tmdb.org/t/p/w500' +
                                            tvrated[index]['backdrop_path'],
                                    posterurl:
                                        'https://image.tmdb.org/t/p/w500' +
                                            tvrated[index]['poster_path'],
                                    vote: tvrated[index]['vote_average']
                                        .toString(),
                                    // trailer: trailer,
                                    // teaser: teaser,
                                    launch_on: tvrated[index]['first_air_date']
                                        .toString())));
                      },
                      child: Container(
                        width: 140,
                        child: Column(
                          children: [
                            Container(
                              height: 200,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          'https://image.tmdb.org/t/p/w500' +
                                              tvrated[index]['poster_path']))),
                            ),
                            Container(
                              child: font_text(
                                  // ignore: prefer_if_null_operators
                                  text: tvrated[index]['original_name'] != null
                                      ? tvrated[index]['original_name']
                                      : 'Loading',
                                  color: Colors.white,
                                  size: 15),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ));
  }
}
