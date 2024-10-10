import 'package:flutter/material.dart';
import 'package:flutter_app/features/tasks/taskView.dart';
import 'package:flutter_app/features/tasks/widgets/add_task_bottom_sheet_widget.dart';
class LayoutView extends StatefulWidget {
  const LayoutView({super.key});

  @override
  State<LayoutView> createState() => _LayoutViewState();
}

class _LayoutViewState extends State<LayoutView> {
  int currentIndex = 0;
  List<Widget> screensList = [
    const TaskView(),

  ];
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (context) => const AddTaskBottomSheetWidget());
        },
        backgroundColor: Colors.white,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0),
        ),
        child: CircleAvatar(
          backgroundColor: theme.primaryColor,
          radius: 25,
          child: const Icon(
            Icons.add,
            color: Colors.white,
            size: 35,
          ),
        ),
      ),
      body: screensList[currentIndex],
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        height: 90,
        padding: EdgeInsets.zero,
        notchMargin: 50,
        shape: const CircularNotchedRectangle(),
        child: BottomNavigationBar(
          backgroundColor: Colors.white,
          currentIndex: currentIndex,
          onTap: (value) {
            setState(() {
              currentIndex = value;
            });
          },
          items: const [
            BottomNavigationBarItem(
                icon: ImageIcon(
                  AssetImage("assets/icons/icon_list.png"),
                ),
                label: "Tasks"),
            BottomNavigationBarItem(
                icon: ImageIcon(
                  AssetImage("assets/icons/icon_settings.png"),
                ),
                label: "settings"),
          ],
        ),
      ),
    );
  }
}

class SettingsView {
  const SettingsView();
}
