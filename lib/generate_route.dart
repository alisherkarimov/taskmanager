import 'package:flutter/material.dart';
import 'package:taskmanager/pages/create_task_screen.dart';
import 'package:taskmanager/pages/home_screen.dart';

import 'core/routes.dart';
import 'models/task_model.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case routeHome:
        return materialPageRoute(const HomePage());
      case routeCreate:
        final args = routeSettings.arguments;

        return args != null
            ? materialPageRoute(CreateScreen(task: args as Task))
            : materialPageRoute(CreateScreen());
      default:
        return _errorRoute();
    }
  }

  static materialPageRoute(Widget page) {
    return MaterialPageRoute(builder: (_) => page);
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
          appBar: AppBar(title: const Text("Error")),
          body: const Center(
            child: Text("PAge not found!"),
          ));
    });
  }
}
