import 'package:flutter/material.dart';
import 'package:flutter_application_1/global_context.dart';
import 'package:flutter_application_1/pages/login.dart';
import 'components/app_bar.dart';
import 'components/drawer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: GlobalContext.navigatorKey,
      title: 'Flutter Demo',
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(key: const Key('drawer')),
      appBar: CustomAppBar(
        key: const Key('app_bar'),
        title: const Text('Het bewuste boeken buro',
            style: TextStyle(fontSize: 20, color: Colors.white)),
      ),
      body: const Login(key: Key('login')),
    );
  }
}
