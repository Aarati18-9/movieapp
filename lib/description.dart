import 'package:flutter/material.dart';
import 'package:movieapp/favorite.dart';
import 'package:movieapp/utils/text.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Description extends StatelessWidget {
  final String name, description, bannerurl, posterurl, vote, launch_on;

  const Description({Key? key,
      required this.name,
      required this.description,
      required this.bannerurl,
      required this.posterurl,
      required this.vote,
      required this.launch_on})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        child: ListView(
          children: [
            Container(
              height: 250,
              child: Stack(
                children: [
                  Positioned(
                      child: Container(
                    height: 250,
                    width: MediaQuery.of(context).size.width,
                    child: Image.network(
                      bannerurl,
                      fit: BoxFit.cover,
                    ),
                  )),
                  //for rating
                  Positioned(
                      bottom: 10,
                      child: font_text(
                          text: 'Average Rating-' + vote,
                          color: Colors.white,
                          size: 18))
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: font_text(
                  text: name != null ? name : 'Cant Load',
                  color: Colors.white,
                  size: 24),
            ),
            Container(
              padding: EdgeInsets.only(left: 10),
              child: font_text(
                  text: 'Released on-' + launch_on,
                  color: Colors.white,
                  size: 18),
            ),
            Row(
              children: [
                Container(
                  margin: EdgeInsets.all(5),
                  height: 200,
                  width: 100,
                  child: Image.network(posterurl),
                ),
                Flexible(
                  child: Container(
                    padding: EdgeInsets.only(top: 10),
                    child: font_text(
                        text: 'Description\n' + description,
                        color: Colors.white,
                        size: 18),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      //for fav floating button to navigate
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        child: Icon(Icons.favorite),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Favorite()),
          );
        },
      ),
    );
  }
}
