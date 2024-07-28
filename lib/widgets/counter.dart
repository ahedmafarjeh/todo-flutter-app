// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class Counter extends StatelessWidget {
  List tasks = [];
  Counter({required this.tasks});

  int countCompleatedTask() {
    int compleatedTask = 0;
    tasks.forEach((item) {
      if (item.status) {
        compleatedTask++;
      }
    });
    return compleatedTask;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Text(
        "${countCompleatedTask()}/${tasks.length}",
        style: TextStyle(
            color: countCompleatedTask()==tasks.length? Colors.green:Colors.white, 
            fontSize: 44, 
            fontWeight: FontWeight.bold,
            ),
      ),
    );
  }
}
