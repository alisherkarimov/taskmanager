import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskmanager/core/routes.dart';
import 'package:taskmanager/generate_route.dart';
import 'package:taskmanager/provider/create_provider.dart';
import 'package:taskmanager/provider/home_provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => HomeProvider()),
      ChangeNotifierProvider(create: (context) => CreateProvider())
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'task manager',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black26,
        ),
        primarySwatch: Colors.blue,
      ),
      initialRoute: routeHome,
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
