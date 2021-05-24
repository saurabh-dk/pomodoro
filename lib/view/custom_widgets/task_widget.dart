import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pomodoro/model/Task.dart';

Widget taskWidget(
    {Task task,
    VoidCallback onClick,
    bool showDelete = true,
    VoidCallback onDeleteClick}) {
  return Column(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
    GestureDetector(
      onTap: () {
        onClick();
      },
      child: Container(
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(),
        ]),
        margin: EdgeInsets.all(5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              task.name,
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
            Text(
              task.workDuration.toString(),
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
            Text(
              task.breakDuration.toString(),
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
            showDelete
                ? IconButton(
                    icon: const Icon(Icons.delete),
                    color: Colors.grey,
                    onPressed: () {
                      onDeleteClick();
                    },
                  )
                : Container(
                    margin: EdgeInsets.all(24),
                  ),
          ],
        ),
      ),
    )
  ]);
}
