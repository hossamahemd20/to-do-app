
import 'package:flutter/material.dart';
import 'package:flutter_app/core/firebase_utils.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';

import '../../../model/task_model.dart';
// import 'package:flutter_app/model/task_model.dart';

class TaskItemWidget extends StatelessWidget {
  final TaskModel taskModel;
  const TaskItemWidget({super.key, required this.taskModel});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Slidable(
      startActionPane: ActionPane(
        motion: const BehindMotion(),
        extentRatio: 4,
        dismissible: DismissiblePane(onDismissed: () {}),
        children: [
          SlidableAction(
            padding: EdgeInsets.zero,
            onPressed: (context) {
              EasyLoading.show();
              FirebaseUtils.deleteTask(taskModel).then((value) => EasyLoading.dismiss());
            },
            backgroundColor: const Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
          // SlidableAction(
          //   onPressed: (context) {},
          //   backgroundColor: Color(0xFF21B7CA),
          //   foregroundColor: Colors.white,
          //   icon: Icons.share,
          //   label: 'Share',
          // ),
         ],
      ),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: ListTile(
          leading: Container(
            width: 6,
            height: 140,
            decoration: BoxDecoration(
              color: taskModel.isDone? const Color(0xFF61E757): theme.primaryColor,
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          trailing:taskModel.isDone? Text(
          "IS Done ! ",
          style: theme.textTheme.bodyLarge?.copyWith(
              color:   const Color(0xFF61E757),
              fontWeight: FontWeight.bold,
              fontSize: 22),
        )
              : InkWell(
            onTap: (){
              EasyLoading.show();

              FirebaseUtils.updataTask(taskModel).then((value) => EasyLoading.dismiss());
            },
                child: Container(
            width: 69,
            height: 34,
            decoration: BoxDecoration(
                color: theme.primaryColor,
                borderRadius: BorderRadius.circular(12.0),
            ),
            child: const Icon(
                Icons.check,
                color: Colors.white,
            ),
          ),
              ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
               taskModel.title,
                style: theme.textTheme.bodyLarge?.copyWith(
                    color:  taskModel.isDone? const Color(0xFF61E757): theme.primaryColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 18),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
               taskModel.description,
                style: theme.textTheme.bodyLarge?.copyWith(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  const Icon(
                    Icons.alarm,
                    size: 12,
                    color: Colors.black,
                  ),
                  Text(
                     // " 10 AM",
                    DateFormat("dd MMM ,yy").format(taskModel.selectedData),
                    style: theme.textTheme.titleLarge?.copyWith(
                      color: Colors.black,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
