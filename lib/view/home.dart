import 'package:flutter/material.dart';
import 'package:pomodoro/controller/Storage.dart';
import 'package:pomodoro/model/Task.dart';
import 'package:pomodoro/view/custom_widgets/task_widget.dart';
import 'package:pomodoro/view/sprint.dart';

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
    super.initState();
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
        child: (taskList != null && taskList.isNotEmpty)
            ? ListView.builder(
                padding: EdgeInsets.all(10),
                itemCount: taskList.length,
                itemBuilder: (BuildContext context, int index) {
                  return taskWidget(
                      task: taskList.elementAt(index),
                      onClick: () => {_gotoTask(taskList.elementAt(index))},
                      onDeleteClick: () =>
                          {_gotoDeleteTask(taskList.elementAt(index))});
                },
              )
            : _noTasks(),
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
        tooltip: 'Add Task',
        icon: Icon(Icons.add),
      ),
    );
  }

  Widget _noTasks() {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          'No tasks to complete.',
          style: Theme.of(context).textTheme.bodyText2,
        ),
        Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 6)),
        Text(
          'Press Add Task to add a new one!',
          style: Theme.of(context).textTheme.bodyText2,
        ),
      ],
    ));
  }

  _gotoTask(Task task) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SprintScreen(task: task),
        )).then((value) {
      setState(() {
        getData();
      });
    });
  }

  _gotoDeleteTask(Task task) {
    showAlertDialog(context, task);
  }

  // Method to build and show alert box.
  showAlertDialog(BuildContext context, Task task) async {
    // Create OK button
    Widget yesButton = TextButton(
      child: Text("Yes"),
      onPressed: () async {
        bool res = await Storage().deleteTask(task);
        if (res) {
          Navigator.of(context).pop();
          setState(() {
            getData();
          });
        }
      },
    );

    Widget noButton = TextButton(
      child: Text("No"),
      onPressed: () async {
        Navigator.of(context).pop();
      },
    );

    final String content = "Are you sure you want to delete " + task.name + "?";

    // Create AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Delete Task"),
      content: Text(content),
      actions: [noButton, yesButton],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
