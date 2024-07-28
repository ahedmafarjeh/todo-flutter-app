// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/widgets/Todo_card.dart';
import 'package:flutter_application_1/widgets/counter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(useMaterial3: true),
      home: TodoApp(),
    );
  }
}

class TodoApp extends StatefulWidget {
  const TodoApp({super.key});

  @override
  State<TodoApp> createState() => _TodoAppState();
}

class Task {
  String title;
  bool status;
  Task({required this.title, required this.status});
}

class _TodoAppState extends State<TodoApp> {
  List allTasks = [
    Task(title: "task 1", status: true),
    Task(title: "task 2", status: false),
    Task(title: "task 3", status: true),
    Task(title: "task 4", status: false),
  ];
  // cotroller: to get text from textfield
  final myController = TextEditingController();
  addTask() {
    setState(() {
      allTasks.add(Task(title: myController.text, status: false));
    });
  }

  changeStatus(int pressedItemIndex) {
    setState(() {
      allTasks[pressedItemIndex].status = !allTasks[pressedItemIndex].status;
    });
  }

  deleteTask(int pressedItemIndex) {
    setState(() {
    
        allTasks.remove(allTasks[pressedItemIndex]);
      
    });
  }

  deleteAllTasks() {
    setState(() {
      allTasks.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // you can use showModalBottomSheet or showDialog
          // but with showDialog you must use Dialog widget
          showDialog(
            //isScrollControlled: true, // to show it on all screen, it is not exist in showDialog
            context: context,
            builder: (BuildContext context) {
              return Dialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: Container(
                  padding: EdgeInsets.all(22),
                  height: 200,
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextField(
                        maxLength: 20,
                        controller: myController,
                        decoration: InputDecoration(
                          hintText: "Todo Title",
                        ),
                      ),
                      TextButton(
                          onPressed: () {
                            addTask();
                            Navigator.pop(context);
                          },
                          child: Text(
                            "ADD",
                            style: TextStyle(fontSize: 22),
                          ))
                    ],
                  ),
                ),
              );
            },
          );
        },
        shape: CircleBorder(),
        backgroundColor: Colors.redAccent,
        child: Icon(Icons.add),
      ),
      backgroundColor: Color.fromRGBO(58, 66, 86, 0.7),
      appBar: AppBar(
        elevation: 0,
        title: Text("TO DO APP",
            style: TextStyle(fontSize: 33, color: Colors.white)),
        backgroundColor: Color.fromRGBO(58, 66, 86, 1),
        actions: [
          IconButton(
            onPressed: () {
              deleteAllTasks();
            },
            icon: Icon(
              Icons.delete_forever,
              size: 40,
              color: const Color.fromARGB(255, 236, 145, 139),
            ),
          ),
        ],
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Counter(tasks: allTasks),
            SizedBox(
              height: 500,
              // to do scrollable list use listview.builder
              child: ListView.builder(
                itemCount: allTasks.length,
                itemBuilder: (context, index) {
                  return TodoCard(
                    title: allTasks[index].title,
                    status: allTasks[index].status,
                    func: changeStatus,
                    indx: index,
                    delete: deleteTask,
                  );

                  // allTasks.map((item) => item.title).tolist --> this return List:[TodoCard,TodoCard,TodoCard]
                  // or allTasks.map((item) => item.title)--> this return iterable:(TodoCard,TodoCard,TodoCard)
                  // so it becomes as this children [ [TodoCard,TodoCard,TodoCard] ]
                  // or [ (TodoCard,TodoCard,TodoCard) ]
                  // ما بزبط يكون لست بداخل ليست او مكرر (اتيربل) داخل ليست
                  // and this cause error, so we must destroy [] or () using 3 dots ...
                  // ...allTasks.map((item) => TodoCard(
                  //   title: item.title,
                  //   status: item.status,
                  // )),
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
