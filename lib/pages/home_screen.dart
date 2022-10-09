import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskmanager/core/routes.dart';
import 'package:taskmanager/provider/home_provider.dart';

import '../models/task_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<HomeProvider>(context);
    provider.getTasks();
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 120,
              width: double.infinity,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Text(
                      'He Alisher',
                      style: TextStyle(
                        color: Colors.black38,
                        fontWeight: FontWeight.bold,
                        fontSize: 28,
                      ),
                    ),
                    Container(
                      height: 30,
                      width: 110,
                      decoration: const BoxDecoration(
                        color: Colors.black38,
                        borderRadius: BorderRadius.all(
                          Radius.circular(16),
                        ),
                      ),
                      child: Center(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, routeCreate);
                          },
                          child: const Text('+add task',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              )),
                        ),
                      ),
                    ),
                  ]),
            ),
            const Divider(color: Colors.black45, height: 3),
            Expanded(
                child: SizedBox(
              width: double.infinity,
              child: Consumer<HomeProvider>(
                builder: (context, data, child) {
                  if (data.taskList.isEmpty) {
                    return const Center(
                      child: Text("There is no task"),
                    );
                  } else {
                    return ListView.builder(
                      itemCount: data.taskList.length,
                      itemBuilder: (context, index) {
                        return tasks(data.taskList[index], context, provider);
                      },
                    );
                  }
                },
              ),
            )),
          ],
        ),
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   currentIndex: 0,
      //   items: const [
      //     BottomNavigationBarItem(
      //       backgroundColor: Colors.green,
      //       icon: Icon(Icons.home, size: 32),
      //       label: 'home',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.menu, size: 32),
      //       label: 'list',
      //     ),
      //   ],
      //   // elevation: 0.3,
      //   onTap: (value) => index = value,
      // ),
    );
  }

  InkWell tasks(Task task, context, HomeProvider provider) {
    int n = 0;
    return InkWell(
      onTap: () {},
      child: Container(
        height: 52,
        margin: const EdgeInsets.all(8).copyWith(bottom: 0),
        color: Colors.black12,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(width: 12),
            Center(
              child: Text(
                '${task.name}',
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                  fontSize: 24,
                ),
              ),
            ),
            PopupMenuButton<Menu>(

              onSelected: (Menu value) {
                switch (value) {
                  case Menu.itemOne:
                    Navigator.pushNamed(context, routeCreate, arguments: task);
                    break;
                  case Menu.itemTwo:
                    provider.deleteTask(task);
                    break;
                }
              },
              itemBuilder: (context) {
                return [
                  const PopupMenuItem(
                    value: Menu.itemOne,
                    child: Text("edit"),
                  ),
                  const PopupMenuItem(
                    value: Menu.itemTwo,
                    child: Text("delete"),
                  ),
                ];
              },
            )
          ],
        ),
      ),
    );
  }
}

enum Menu { itemOne, itemTwo }
