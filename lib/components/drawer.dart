import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/providers/login_manager.dart';
import 'package:provider/provider.dart';

class CustomDrawer extends Drawer {
  CustomDrawer({required Key key})
      : super(
          key: key,
          child: Builder(builder: (context) {
            return ListView(
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
                    Navigator.pop(context);
                    mainPageNavigatorKey.currentState!
                        .pushReplacementNamed('/auteurs');
                  },
                ),
                ListTile(
                  title: const Text('Genres'),
                  onTap: () {
                    Navigator.pop(context);
                    mainPageNavigatorKey.currentState!
                        .pushReplacementNamed('/genres');
                  },
                ),
                ListTile(
                  title: const Text('Boeken'),
                  onTap: () {
                    Navigator.pop(context);
                    mainPageNavigatorKey.currentState!
                        .pushReplacementNamed('/boeken');
                  },
                ),
                Consumer<LoginManager>(
                  builder: (context, loginProvider, child) {
                    if (loginProvider.isLoggedIn) {
                      return ListTile(
                        title: const Text('Log uit'),
                        onTap: () {
                          loginProvider.logout();
                          Navigator.pop(context);
                          mainPageNavigatorKey.currentState!
                              .pushReplacementNamed('/');
                        },
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
              ],
            );
          }),
        );
}
