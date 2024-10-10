import 'package:flutter/material.dart';
import 'package:flutter_app/core/firebase_utils.dart';
import 'package:flutter_app/model/task_model.dart';
import 'package:flutter_app/services/snack_bar_service.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';

class AddTaskBottomSheetWidget extends StatefulWidget {
  const AddTaskBottomSheetWidget({super.key});

  @override
  State<AddTaskBottomSheetWidget> createState() => _AddTaskBottomSheetWidgetState();
}

class _AddTaskBottomSheetWidgetState extends State<AddTaskBottomSheetWidget> {
  var formkey = GlobalKey <FormState>();
  var titleController = TextEditingController();
  var descriptionController = TextEditingController();
  DateTime selectData=DateTime.now();
  @override
  Widget build(BuildContext context) {
    var theme= Theme.of(context);
   return Container(
     padding: const EdgeInsets.only(
       top: 30,
       right: 20,
       left: 20,
       bottom: 20,
     ),
     decoration: BoxDecoration(
       color: Colors.white,
       borderRadius: BorderRadius.circular(15.0),

     ),
     child:Form(
       key: formkey,
       child: Column(
         crossAxisAlignment: CrossAxisAlignment.stretch,

         children: [
            Text("Add new task",
              style:
              theme.textTheme.bodyLarge?.copyWith(
                color: Colors.black
              ),
              textAlign: TextAlign.center,
            ),

         const SizedBox(height: 50,),
         TextFormField(
           controller: titleController,
           decoration: const InputDecoration(
             hintText: "Enter task Title ",
           ),
           validator: (value)
           {
             if(value==null|| value.trim().isEmpty)
               {
                 return " please Enter Title";
               }
             return null ;

           },
         ),
           const SizedBox(height: 20,),
           TextFormField(
             controller: descriptionController,
             maxLines: 2,
             decoration: const InputDecoration(
               hintText: "Enter task description ",
             ),
             validator: (value)
             {
               if(value==null|| value.trim().isEmpty)
               {
                 return " please Enter Description";
               }
               return null ;

             },
           ),
           const SizedBox(height: 20,),
           Text("Select Time",
             style: theme.textTheme.bodyLarge?.copyWith(
               color: Colors.black,
               fontWeight: FontWeight.w500,
             ),
           ),
           const SizedBox(height: 20,),
           InkWell(
             onTap: () {
            getSelectedData();
             },
             child: Text(
               DateFormat("dd MMM yyyy").format(selectData),
               textAlign: TextAlign.center,
               style: theme.textTheme.bodyLarge?.copyWith(
                 color: Colors.black,
                 fontWeight: FontWeight.w500,

               ),
             ),
           ),
           const Spacer(),
           FilledButton(onPressed: (){
             if(formkey.currentState!.validate())
               {
                 var taskModel=
                 TaskModel(
                     title: titleController.text,
                     description: descriptionController.text,
                     selectedData: selectData
                 );
                 EasyLoading.show();
                 FirebaseUtils.addTaskToFirestore(taskModel).then((value) {
                   Navigator.pop(context);
                   EasyLoading.dismiss();//to hide loading
                   SnackBarService.showSuccessMessage("Task successfully added !");

                 });
               }


           },
               child: const Text("Save Changes")),
         ],
       ),
     ),

   );
  }
  getSelectedData()  async{
    var currentData = await showDatePicker(context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(
        const Duration(days: 365),
      ), initialDate: DateTime.now(),

    );
  if(currentData != null)
    {
      setState(() {
        selectData =currentData;
      });
    }
  }
}
