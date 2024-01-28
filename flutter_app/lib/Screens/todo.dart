import 'package:flutter/material.dart';
import 'package:flutter_app/Screens/addtodo.dart';
import 'package:flutter_app/components/todo_tile.dart';
import 'package:flutter_app/data/database.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ToDoScreen extends StatefulWidget {
  const ToDoScreen({super.key});

  @override
  State<ToDoScreen> createState() => _ToDoScreenState();
}

class _ToDoScreenState extends State<ToDoScreen> {
  // reference the hive box
  final _myBox = Hive.box('mybox');
  ToDoDataBase db = ToDoDataBase();

  @override
  void initState() {
    // if this is the 1st time ever openin the app, then create default data
    if (_myBox.get("TODOLIST") == null) {
      db.createInitialData();
    } else {
      // there already exists data
      db.loadData();
    }

    super.initState();
  }

  // text controller
  final _controller = TextEditingController();

  // checkbox tapped
  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });
    db.updateDataBase();
  }

  // save new task
  void saveNewTask() {
    setState(() {
      db.toDoList.add([_controller.text, false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
    db.updateDataBase();
  }

  // delete task
  void deletTask(int index) {
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateDataBase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54,
      appBar: AppBar(
        backgroundColor: Colors.grey[700],
        title: Text(
          "To Do List",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.grey[300],
          ),
        ),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        elevation: 20,
        backgroundColor: Color(0xFFEE4135),
        onPressed: () {
          // move to add todo screen
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => AddTodo(
                controller: _controller,
                onSave: saveNewTask,
              ),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: db.toDoList.length,
        itemBuilder: (context, index) {
          return ToDoTile(
            taskName: db.toDoList[index][0],
            taskCompleted: db.toDoList[index][1],
            onChanged: (value) => checkBoxChanged(value, index),
            deleteFunction: (context) => deletTask(index),
          );
        },
      ),
    );
  }
}
