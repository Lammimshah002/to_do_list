import 'package:flutter/material.dart';

class Dialogbox extends StatelessWidget {
  final TextEditingController titleController;
  final TextEditingController descriptionController;
  final TextEditingController todoDateController;
  final TextEditingController todotimeController;
  VoidCallback onSave;
  VoidCallback oncencel;
  final Function(BuildContext) onDateSelect;
  final Function(BuildContext) onTimeSelect;
  Dialogbox({super.key,
    required this.titleController,
    required this.descriptionController,
    required this.todoDateController,
    required this.todotimeController,
    required this.oncencel,
    required this.onSave,
    required this.onDateSelect,
    required this.onTimeSelect
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.yellow,
      content: Container(
        height: 450,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Add to your title",
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Add to your dece",
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: todoDateController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Date',
                  hintText: "Pick a date",
                  prefixIcon: InkWell(
                    onTap:
                        (){
                      onDateSelect(context);
                    },
                    child: Icon(Icons.calendar_today),
                  )
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: todotimeController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'time',
                  hintText: "Pick a time",
                  prefixIcon: InkWell(
                    onTap:
                        (){
                          onTimeSelect(context);
                    },
                    child: Icon(Icons.alarm),
                  )
              ),
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                /// Mybutton(text: "save", onPressed: (){},),
                /// Mybutton(text: "cencel", onPressed: (){}),
                ElevatedButton(
                  onPressed: onSave,
                  child: Text('save',),
                ),
                SizedBox(width: 2,),
                ElevatedButton(
                  onPressed: oncencel,
                  child: Text('cencel',),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
