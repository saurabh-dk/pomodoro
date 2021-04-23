import 'package:flutter/material.dart';
import 'package:pomodoro/model/Storage.dart';
import 'package:pomodoro/model/Task.dart';

class HomeScreen extends StatefulWidget {
  @override
  // HomeScreen is a stateful widget, that is, it holds values
  // obtained dynamically.
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Task> taskList;

  // initState is called exactly once during lifecycle of the
  // page.
  @override
  void initState() {
    getData();
  }

  // Gets the data from shared_preferences and sets it to
  // the state object.
  getData() {
    setState(() {
      taskList = Storage().getTasks();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pomodoro'),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: ListView(
          children: _cards(),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Navigator pushes based on the string we have given
          // in the routes object. The then function is called when
          // AddTask page is popped off the navigator. This triggers
          // the function given as an argument.
          Navigator.pushNamed(context, "/addTask").then((value) {
            setState(() {
              getData();
            });
          });
        },
        label: Text('Add Task'),
        tooltip: 'Increment',
        icon: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  List<Widget> _cards() {
    return taskList
        .map((task) => Container(
              width: 100,
              height: 60,
              decoration: BoxDecoration(color: Colors.white,
                  // borderRadius: BorderRadius.circular(40),
                  boxShadow: [
                    BoxShadow(),
                    //   BoxShadow(offset: Offset(20, 20), color: Colors.yellow),
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
                  Icon(
                    Icons.delete,
                    color: Colors.grey,
                    size: 24.0,
                  ),
                ],
              ),
            ))
        .toList();
  }
}
