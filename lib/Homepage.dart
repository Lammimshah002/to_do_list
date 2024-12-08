import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'To_do_tile.dart';
import 'tododatabase.dart';
import 'Dilogbox.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _State();
}

class _State extends State<Homepage> {
  List toDoList = [
    ["Make tutorial", "Record and upload a tutorial video", false,"26-11-2000","12:00"],
    ["First task done", "Complete the first task of the day", false,"25-11-2000","9:00"],
  ];
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _todoDateController = TextEditingController();
  final TextEditingController _todoTimeController = TextEditingController();
  @override
  void initState() {
    super.initState();
    read1(); // Load tasks from the database
  }

  // Fetch tasks from the database
  Future<void> read1() async {
    final get = await lammim_note.read();
    setState(() {
      toDoList = get
          .map((task) => [task.task, task.task1, task.taskComplted,task.date,task.time,task.id])
          .toList();
    });
  }
  void delete(int index) async {
    final taskId = toDoList[index][5];

    print("object: fail -->$taskId");// Task ID from the list
    await lammim_note.delete(taskId); // Delete from DB
    int x= int.parse(taskId);
    read1(); // Reload tasks from the database
    print("object: fail -->$x");
  }
  void chackBox(bool ? value,int index) async {
    final taskId = toDoList[index][5];
    final y= toDoList[index][2];
    print("object: fail -->$taskId");// Task ID from the list
    await lammim_note.updateTaskStatus(y,taskId); // Delete from DB
    int x= int.parse(taskId);
    read1(); // Reload tasks from the database
    print("object: fail -->$x");
  }
  Future<void>_add(String title, String description, String date,String time) async{
    await lammim_note.addItem(title,description,date,time);
    print('add item');
  }
  void checkboxChanged(bool? value, int index) {
    setState(() {
      toDoList[index][2] = !toDoList[index][2]; // Update completion status
      chackBox(value, index);
    });
  }

  void createNewtask(BuildContext context){
    showDialog(context: context,
        builder: (context) {
          return  Dialogbox(
            titleController: _titleController,
            descriptionController: _descriptionController,
            todoDateController: _todoDateController,
            todotimeController: _todoTimeController,
            onDateSelect: (context) => _selectedTodoDate(context),
            onTimeSelect:(context) =>_selectedTodoTime(context),
            onSave: () {
              {
                setState(() {
                  toDoList.add([_titleController.text, _descriptionController.text, false,_todoDateController.text,_todoTimeController.text]);
                  _add(_titleController.text, _descriptionController.text,_todoDateController.text,_todoTimeController.text);
                  print("savetask");

                });
                _titleController.clear();
                _descriptionController.clear();
                _todoTimeController.clear();
                _todoDateController.clear();
                Navigator.of(context).pop();
              }
            },
            oncencel: () => Navigator.of(context).pop(),
          );
        }
    );
  }
  void deletetask(int index){
    setState(() {
      delete(index);
      toDoList.removeAt(index);
    });
  }
  //date start
  DateTime _dateTime =DateTime.now();
  _selectedTodoDate(BuildContext context) async{
    var pickedDate =await showDatePicker(context: context,
        initialDate: _dateTime,
        firstDate: DateTime(2000),
        lastDate: DateTime(2100));
    if(pickedDate !=null)
    {
      setState(() {
        _dateTime =pickedDate;
        _todoDateController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
        print('Date: $_todoDateController');
      });
    }
  }
  //date end
  //time start
  TimeOfDay _timeOfDay = TimeOfDay.now();
  _selectedTodoTime(BuildContext context) async{
    var pickedTime = await showTimePicker(context: context, 
        initialTime: _timeOfDay,
    );
    if(pickedTime !=null)
      {
        setState(() {
          _timeOfDay=pickedTime;
          _todoTimeController.text = pickedTime.format(context);
        });
      }
  }
  //time end
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.red,
        appBar: AppBar(
          title: Text("TO-DO-LIST"),
          backgroundColor: Colors.yellow,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: (){createNewtask(context);},
          child: Icon(Icons.add),
        ),

        body: ListView.builder(
            itemCount: toDoList.length,
            itemBuilder: (context,index){
              return ToDoList(
                title: toDoList[index][0],
                dece: toDoList[index][1],
                taskComplted: toDoList[index][2],
                date:toDoList[index][3],
                time:toDoList[index][4],
                onChanged: (value) => checkboxChanged(value,index),
                deleteFunction: (context) => deletetask(index),
              );
            }

        )
    );
  }
}

