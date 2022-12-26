import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:movieapp/utils/text.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Favorite extends StatelessWidget {
  const Favorite({key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          title:const font_text(
            text: 'Favorite',
            color: Colors.white,
            size: 20,
          )),
    );
  }
}
