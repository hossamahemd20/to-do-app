// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/core/firebase_utils.dart';
import 'package:flutter_app/features/tasks/widgets/task_item_widget.dart';
import 'package:flutter_app/model/task_model.dart';
// import 'package:flutter_app/model/task_model.dart';

class TaskView extends StatefulWidget {
  const TaskView({super.key});

  @override
  State<TaskView> createState() => _TaskViewState();
}

class _TaskViewState extends State<TaskView> {
  final EasyInfiniteDateTimeController controller =
      EasyInfiniteDateTimeController();
  var focusDate = DateTime.now();

  get tasksList => null;
  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    var theme = Theme.of(context);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 40.0),
          child: Stack(
            alignment: Alignment.bottomCenter,
            clipBehavior: Clip.none,
            children: [
              Container(
                padding: const EdgeInsets.only(
                  top: 60,
                  left: 51,
                ),
                width: mediaQuery.size.width,
                height: mediaQuery.size.height * 0.18,
                color: theme.primaryColor,
                child: Text(
                  "To Do List ",
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: Colors.white,
                  ),
                ),
              ),
              Positioned(
                top: 100,
                child: SizedBox(
                  width: mediaQuery.size.width,
                  child: EasyInfiniteDateTimeLine(
                    firstDate: DateTime(2024),
                    focusDate: focusDate,
                    lastDate: DateTime.now().add(
                      const Duration(days: 365),
                    ),
                    onDateChange: (selectedDate) {
                      setState(() {
                        focusDate = selectedDate;
                        print(focusDate);
                      });
                    },
                    showTimelineHeader: false,
                    timeLineProps: const EasyTimeLineProps(
                      separatorPadding: 15,
                    ),
                    dayProps: EasyDayProps(
                      activeDayStyle: DayStyle(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        monthStrStyle: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                        dayStrStyle: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                        dayNumStyle: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      inactiveDayStyle: DayStyle(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        monthStrStyle: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Colors.black,
                        ),
                        dayStrStyle: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Colors.black,
                        ),
                        dayNumStyle: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                      todayStyle: DayStyle(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        monthStrStyle: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Colors.black,
                        ),
                        dayStrStyle: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Colors.black,
                        ),
                        dayNumStyle: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        // Expanded(
        //   child: StreamBuilder<QuerySnapshot<TaskModel>>(
        //     stream: FirebaseUtils.getRealTimeDataFromFirestore(focusDate),
        //     builder: (context, snapshot) {
        //       if (snapshot.hasError) {
        //         return const Text('some thing went wrong ');
        //       }
        //       if (snapshot.connectionState == ConnectionState.waiting) {
        //         return Center(
        //           child: CircularProgressIndicator(
        //             color: theme.primaryColor,
        //           ),
        //         );
        //       }
        //      // var tasksList = snapshot.data; // now the data is return
        //       List<TaskModel> tasksList =
        //       snapshot.data?.docs.map((e) => e.data()).toList()??[];
        //       return ListView.builder(
        //         padding: EdgeInsets.zero,
        //         itemBuilder: (context, index) => TaskItemWidget(
        //           taskModel: tasksList[index],
        //         ),
        //         itemCount: tasksList.length ?? 0,
        //       );
        //     },
        //   ),
        // ),
        Expanded(
          child: FutureBuilder<List<TaskModel>>(
            future: FirebaseUtils.getOneTimeReadFromFirestore(focusDate),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Text('some thing went wrong ');
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(
                    color: theme.primaryColor,
                  ),
                );
              }
              var tasksList = snapshot.data; // now the data is return
              return Expanded(
                  child: ListView.builder(
                // padding: EdgeInsets.zero,
                itemBuilder: (context, index) => TaskItemWidget(
                  taskModel: tasksList![index],
                ),
                //   (taskModel:
                // tasksList![index],),
                itemCount: tasksList?.length??0,
              ));
            },
          ),
        ),
      ],
    );
  }
}

class EasyInfiniteDateTimeController {}
