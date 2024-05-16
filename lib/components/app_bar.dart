import 'package:flutter/material.dart';

class CustomAppBar extends AppBar {
  CustomAppBar({required Key key, required Widget title})
      : super(
            iconTheme: const IconThemeData(color: Colors.white),
            key: key,
            title: title,
            flexibleSpace: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.deepPurpleAccent.shade400, Colors.deepPurple],
                ),
              ),
            ));
}
