import 'package:flutter/material.dart';
import 'package:movieapp/utils/text.dart';

import '../description.dart';

class TopRatedMovie extends StatelessWidget {
  final List toprated;

  const TopRatedMovie({Key? key, required this.toprated}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            font_text(text: 'Top Rated', color: Colors.white, size: 30),
            SizedBox(height: 10,),
            Container(

              height: 270,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: toprated.length,
                  itemBuilder: (context, index) {
                    //for description
                    return InkWell(
                      onTap: () {
                         Navigator.push(context,MaterialPageRoute(builder: (context)=>Description(name: toprated[index]['original_title'], description: toprated[index]['overview'], bannerurl:'https://image.tmdb.org/t/p/w500' +
                                              toprated[index]['backdrop_path'] , posterurl: 'https://image.tmdb.org/t/p/w500' +
                                              toprated[index]['poster_path'], vote: toprated[index]['vote_average'].toString(), launch_on: toprated[index]['release_date'].toString())));
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
                                              toprated[index]['poster_path']))),
                            ),
                            Container(
                              child: font_text(
                                  // ignore: prefer_if_null_operators
                                  text: toprated[index]['original_title']!=null
                                      ? toprated[index]['original_title']
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
