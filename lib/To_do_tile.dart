import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ToDoList extends StatelessWidget {
  final String title;
  final String dece;
  final bool taskComplted;
  final String date;
  final String time;
  Function (bool?)? onChanged;
  Function(BuildContext)? deleteFunction;

  ToDoList({super.key,
    required this.title,
    required this.dece,
    required this.taskComplted,
    required this.date,
    required this.time,
    required this.onChanged,
    required this.deleteFunction,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Slidable(
        endActionPane: ActionPane(
          motion: StretchMotion(), children: [
          SlidableAction(onPressed: deleteFunction,
            icon: Icons.delete,
            backgroundColor: Colors.green,
          )
        ],

        ),
        child: Container(
          decoration: BoxDecoration(color: Colors.yellow,borderRadius: BorderRadius.circular(10)),
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              Checkbox(value: taskComplted, onChanged: onChanged),
              const SizedBox(width: 10),
              Expanded(
                child:Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:[Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text(title,
                      style: TextStyle(fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.green,
                          decoration: taskComplted ? TextDecoration.lineThrough: TextDecoration.none)),
                   Text("$date & $time",style: TextStyle(color:taskComplted ? Colors.green : Colors.red),),
                    ///Text(time,style: TextStyle(color:taskComplted ? Colors.green : Colors.red),),
                  ],
                ),
                    const SizedBox(height: 4),
                    // Description below the title
                    Text(
                      dece,
                      style: TextStyle(
                        color: taskComplted ? Colors.green : Colors.red,
                      ),
                    ),
                ],
              ),

          ),
          ],
        ),
      ),
    ),
    );
  }
}
