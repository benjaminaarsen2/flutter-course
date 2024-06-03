import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/auteurs.dart';
import 'package:flutter_application_1/pages/boeken.dart';
import 'package:flutter_application_1/pages/create_update.dart';
import 'package:flutter_application_1/pages/genres.dart';
import 'package:flutter_application_1/pages/login.dart';
import 'package:flutter_application_1/providers/login_manager.dart';
import 'package:provider/provider.dart';
import 'components/app_bar.dart';
import 'components/drawer.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (context) => LoginManager(), child: MyApp()));
}

class MyApp extends StatelessWidget {
  final GlobalKey<NavigatorState> appNavigatorKey = GlobalKey<NavigatorState>();

  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Inter'),
      navigatorKey: appNavigatorKey,
      title: 'Flutter Demo',
      home: const MainPage(),
    );
  }
}

final GlobalKey<NavigatorState> mainPageNavigatorKey =
    GlobalKey<NavigatorState>();

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      drawer: CustomDrawer(key: const Key('drawer')),
      appBar: CustomAppBar(
        key: const Key('app_bar'),
        title: const Text('Het bewuste boeken buro',
            style: TextStyle(fontSize: 20, color: Colors.white)),
      ),
      body: Navigator(
        key: mainPageNavigatorKey,
        initialRoute: '/',
        onGenerateRoute: (RouteSettings settings) {
          WidgetBuilder builder;
          switch (settings.name) {
            case '/':
              builder = (BuildContext _) => Consumer<LoginManager>(
                    builder: (context, loginProvider, child) {
                      if (loginProvider.isLoggedIn) {
                        return const Boeken(
                            key: Key(
                                'boeken')); // Show Dashboard if user is logged in
                      } else {
                        return const Login(
                            key: Key(
                                'login')); // Show Login page if user is not logged in
                      }
                    },
                  );
              break;
            case '/boeken':
              builder = (BuildContext _) => const Boeken();
              break;
            case '/auteurs':
              builder = (BuildContext _) => const Auteurs();
              break;
            case '/genres':
              builder = (BuildContext _) => const Genres();
              break;
            case '/create_update_boek':
              final args = settings.arguments as CreateUpdateBoekArguments;
              builder = (BuildContext _) => CreateUpdateBoek(boek: args.boek);
              break;
            case '/create_update':
              final args = settings.arguments as CreateUpdatePageArguments;
              builder = (BuildContext _) => CreateUpdatePage(arguments: args);
              break;
            default:
              throw Exception('Invalid route: ${settings.name}');
          }
          return MaterialPageRoute(builder: builder, settings: settings);
        },
      ),
    );
  }
}
