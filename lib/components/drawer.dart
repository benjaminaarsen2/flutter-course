import 'package:flutter/material.dart';
import 'package:flutter_application_1/global_context.dart';

class CustomDrawer extends Drawer {
  CustomDrawer({required Key key})
      : super(
          key: key,
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: <Color>[
                      Colors.deepPurpleAccent.shade400,
                      Colors.deepPurple,
                    ],
                  ),
                ),
                child: const Text(
                  'Menu',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
              ListTile(
                title: const Text('Auteurs'),
                onTap: () {
                  // Navigator.push
                  Navigator.pop(GlobalContext.navigatorKey.currentContext!);
                },
              ),
              ListTile(
                title: const Text('Genres'),
                onTap: () {
                  Navigator.pop(GlobalContext.navigatorKey.currentContext!);
                },
              ),
              ListTile(
                title: const Text('Boeken'),
                onTap: () {
                  Navigator.pop(GlobalContext.navigatorKey.currentContext!);
                },
              ),
              ListTile(
                title: const Text('Log uit'),
                onTap: () {
                  Navigator.pop(GlobalContext.navigatorKey.currentContext!);
                },
              ),
            ],
          ),
        );
}
