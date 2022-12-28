import 'package:flutter/material.dart';
import 'package:movieapp/utils/text.dart';

import '../description.dart';

class FavouriteMovie extends StatelessWidget {
  final List movie_list;

  const FavouriteMovie({Key? key, required this.movie_list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // font_text(text: 'Popular Tv Shows', color: Colors.white, size: 30),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 270,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: movie_list.length,
                  itemBuilder: (context, index) {
                    //for description
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Description(
                                    id: movie_list[index]['id'],
                                    name: movie_list[index]['original_title'],
                                    description: movie_list[index]['overview'],
                                    bannerurl:
                                        'https://image.tmdb.org/t/p/w500' +
                                            movie_list[index]['backdrop_path'],
                                    posterurl:
                                        'https://image.tmdb.org/t/p/w500' +
                                            movie_list[index]['poster_path'],
                                    vote: movie_list[index]['vote_average']
                                        .toString(),
                                    launch_on: movie_list[index]['first_air_date']
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
                                              movie_list[index]['poster_path']))),
                            ),
                            Container(
                              child: font_text(
                                  // ignore: prefer_if_null_operators
                                  text: movie_list[index]['original_title'] != null
                                      ? movie_list[index]['original_title']
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
