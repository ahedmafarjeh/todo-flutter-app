import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';

class TodoCard extends StatelessWidget {
  final String title;
  final bool status;
  final Function func;
  final int indx;
  final Function delete;
  TodoCard({
    required this.title,
    required this.status,
    required this.func,
    required this.indx,
    required this.delete,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        func(indx);
      },
      child: FractionallySizedBox(
        widthFactor: 0.9,
        child: Container(
          margin: EdgeInsets.fromLTRB(5, 20, 5, 0),
          padding: EdgeInsets.all(17),
          decoration: BoxDecoration(
            color: Color.fromRGBO(209, 224, 224, 0.2),
            borderRadius: BorderRadius.circular(11),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: status? Colors.black : Colors.white, 
                  fontSize: 25,
                  decoration: status? TextDecoration.lineThrough:TextDecoration.none,
                  ),
              ),
              Row(
                children: [
                  Icon(
                    status ? Icons.check : Icons.close,
                    color: status ? Colors.green : Colors.red,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  IconButton(
                      onPressed: () {
                        delete(indx);
                      },
                      icon: Icon(
                        Icons.delete,
                        size: 27,
                        color: const Color.fromARGB(255, 237, 156, 150),
                      )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
