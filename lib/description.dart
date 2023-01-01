import 'package:flutter/material.dart';
import 'package:movieapp/favorite.dart';
import 'package:movieapp/utils/text.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class Description extends StatefulWidget {
  final String name, description, bannerurl, posterurl, vote, launch_on;
  final int id;
  final Map<String, dynamic>? trailer, teaser;

  const Description({
    Key? key,
    required this.id,
    required this.name,
    required this.description,
    required this.bannerurl,
    required this.posterurl,
    required this.vote,
    required this.launch_on,
    this.trailer,
    this.teaser,
  }) : super(key: key);

  @override
  State<Description> createState() => _DescriptionState();
}

class _DescriptionState extends State<Description> {
  bool isFavourite = false;

  @override
  void initState() {
    super.initState();
    set_fav_status();
  }

  void set_fav_status() async {
    final prefs = await SharedPreferences.getInstance();
    var list = prefs.getStringList('fav_movies');
    // print(list);
    if (list != null) {
      if (list.contains(widget.id.toString())) {
        setState(() {
          isFavourite = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // YoutubePlayerController _teaser_controller = YoutubePlayerController(
    //   initialVideoId: widget.teaser != null ? widget.teaser!['key'] : '',
    //   flags: YoutubePlayerFlags(
    //     autoPlay: false,
    //     mute: false,
    //   ),
    // );
    YoutubePlayerController _trailer_controller = YoutubePlayerController(
      initialVideoId: widget.trailer != null ? widget.trailer!['key'] : '',
      flags: YoutubePlayerFlags(
        autoPlay: false,
        // mute: true,
      ),
    );
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.black,
      body: Container(
        child: ListView(
          children: [
            widget.trailer != null
                ? Container(
                    height: MediaQuery.of(context).size.height / 2.75,
                    child: Stack(
                      children: [
                        YoutubePlayerBuilder(
                          builder: (context, player) {
                            return Column(
                              children: [player],
                            );
                          },
                          player: YoutubePlayer(
                            controller: _trailer_controller,
                          ),
                        ),

                        // Positioned(
                        //     child: Container(
                        //   height: 250,
                        //   width: MediaQuery.of(context).size.width,
                        //   child: Image.network(
                        //     bannerurl,
                        //     fit: BoxFit.cover,
                        //   ),
                        // )),
                        //for rating
                      ],
                    ),
                  )
                : Container(),
            const SizedBox(
              height: 15,
            ),
            Container(
                padding: const EdgeInsets.all(10),
                child: font_text(
                    text: 'Average Rating-' + widget.vote,
                    color: Colors.white,
                    size: 18)),
            Container(
              padding: const EdgeInsets.all(10),
              child: font_text(
                  text: widget.name != null ? widget.name : 'Cant Load',
                  color: Colors.white,
                  size: 24),
            ),
            Container(
              padding: EdgeInsets.only(left: 10),
              child: font_text(
                  text: 'Released on-' + widget.launch_on,
                  color: Colors.white,
                  size: 18),
            ),
            Row(
              children: [
                Container(
                  margin: EdgeInsets.all(5),
                  height: 200,
                  width: 100,
                  child: Image.network(widget.posterurl),
                ),
                Flexible(
                  child: Container(
                    padding: EdgeInsets.only(top: 10),
                    child: font_text(
                        text: 'Description\n' + widget.description,
                        color: Colors.white,
                        size: 18),
                  ),
                ),
              ],
            ),
            // teaser != null
            //     ? Container(
            //         child: YoutubePlayer(
            //           controller: _teaser_controller,
            //         ),
            //       )
            //     : Container(),
            // trailer != null
            //     ? Container(
            //         child: YoutubePlayer(
            //           controller: _trailer_controller,
            //         ),
            //       )
            //     : Container()
          ],
        ),
      ),
      //for fav floating button to navigate
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        child: this.isFavourite
            ? Icon(
                Icons.favorite,
                color: Colors.blue,
              )
            : Icon(Icons.favorite_outline),
        onPressed: () async {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => const Favorite()),
          // );

          final prefs = await SharedPreferences.getInstance();
          var list = prefs.getStringList('fav_movies');
          // print(list);
          if (list != null) {
            if (list.contains(widget.id.toString())) {
              list.remove(widget.id.toString());
              prefs.setStringList('fav_movies', list);
              setState(() {
                this.isFavourite = false;
              });
            } else {
              list.add(widget.id.toString());
              prefs.setStringList('fav_movies', list);
              setState(() {
                this.isFavourite = true;
              });
            }
          }
          print(list);
        },
      ),
    );
  }
}
