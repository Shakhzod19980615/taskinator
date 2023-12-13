import 'package:flutter/material.dart';
import '../colors/colors.dart';
import '../db/db_helper.dart';
import '../model/task_model.dart';
import '../screens/update_page.dart';

class ListItem extends StatefulWidget {
  const ListItem({Key? key, required this.taskList, required this.index1})
      : super(key: key);
  final List<TaskModel>? taskList;
  final int index1;

  @override
  State<ListItem> createState() => _ListItemState();
}

class _ListItemState extends State<ListItem> {
  late final String? task_description;
  bool? isCompleted = false;
  late int? completed;
  final _sqliteService = SqliteService();

  @override
  void initState() {
    // TODO: implement initState
    task_description = widget.taskList![widget.index1].task_description;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var takDescription = widget.taskList![widget.index1].task_description ?? "";
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => UpdatePage(
                    taskId: widget.taskList![widget.index1].id,
                  )),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(20)),
        child: Card(
          elevation: 5,
          child: Column(
            children: [
              Container(
                color: widget.taskList![widget.index1].isCompleted == 1
                    ? bottomNavLight
                    : bottomNav,
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    Expanded(
                        child: Text(
                      widget.taskList![widget.index1].task_title ?? "",
                      style: TextStyle(
                          color: Colors.white,
                          decoration:
                              widget.taskList![widget.index1].isCompleted == 1
                                  ? TextDecoration.lineThrough
                                  : null,
                          decorationThickness: 3),
                    )),
                    const Icon(
                      Icons.access_time_rounded,
                      color: Colors.orange,
                    ),
                    Text(
                      widget.taskList![widget.index1].start_time ?? "",
                      style: const TextStyle(color: Colors.white),
                    ),
                    const Icon(
                      Icons.arrow_forward,
                      color: Colors.orange,
                    ),
                    Text(
                      widget.taskList![widget.index1].end_time ?? "",
                      style: const TextStyle(color: Colors.white),
                    )
                  ],
                ),
              ),
              Container(
                color: widget.taskList![widget.index1].isCompleted == 1
                    ? gray
                    : Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: Row(
                  children: [
                    Expanded(
                        child: task_description!.isEmpty
                            ? Text("Bu vazifa uchun tavsif qo‘shilmagan",
                                style: TextStyle(
                                    decoration: widget.taskList![widget.index1]
                                                .isCompleted ==
                                            1
                                        ? TextDecoration.lineThrough
                                        : null))
                            : Text(
                                task_description!,
                                style: TextStyle(
                                    decoration: widget.taskList![widget.index1]
                                                .isCompleted ==
                                            1
                                        ? TextDecoration.lineThrough
                                        : null),
                              )),
                    Checkbox(
                      onChanged: (bool? value) {
                        setState(() {
                          isCompleted = value!;
                          if (isCompleted == false) {
                            widget.taskList![widget.index1].isCompleted = 0;
                          } else {
                            widget.taskList![widget.index1].isCompleted = 1;
                          }
                          _sqliteService
                              .updateTasks(widget.taskList![widget.index1]);
                        });
                      },
                      value: widget.taskList![widget.index1].isCompleted == 1
                          ? true
                          : false,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
