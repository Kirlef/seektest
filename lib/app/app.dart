import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seektest/presentation/pages/add_task/add_task.dart';
import '../config/bloc/task_bloc.dart';
import '../config/routes/app_routes.dart';
import '../presentation/pages/list_task/list_task.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TaskBloc(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: (routeSetting) {
          switch (routeSetting.name) {
            case (AppRoutes.home):
              return MaterialPageRoute(
                  builder: (BuildContext context) {
                    return const HomeScreen();
                  });
            case (AppRoutes.add):
              return MaterialPageRoute(
                  builder: (BuildContext context) {
                    return const AddTaskScreen();
                  });

            default:
              return MaterialPageRoute(builder: ((context) => const HomeScreen()));
          }
        },
      )
    );
  }
}