
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app/model/task_model.dart';
import 'package:flutter_app/services/snack_bar_service.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class FirebaseUtils{

  static CollectionReference<TaskModel> getCollectionRef()
  {
    return
    FirebaseFirestore.instance.collection(TaskModel.collectionName)
        .withConverter<TaskModel>
      (fromFirestore: (snapshot,_)=>TaskModel.firestore(snapshot.data()!),
        toFirestore: (taskModel,_)=>taskModel.tofirestore(),
    );
  // we got collection from fire store
  }
   static Future<void> addTaskToFirestore(TaskModel taskModel)
  async{
// now we can read the data from date base
  var collectionRef = getCollectionRef();
  collectionRef.doc();//create to a new doc with Auto id
    var docRef= collectionRef.doc();// دي بترجع كل الدتا الي انا محتاجه
   taskModel.id = docRef.id;
    return docRef.set(taskModel);
  }
  static  Future< List<TaskModel>> getOneTimeReadFromFirestore(
      DateTime
     selectedDate
      )
  async{
    var  collectionRef = getCollectionRef()
        .where("selectedData",
        isEqualTo:selectedDate
    );
    QuerySnapshot<TaskModel> date = await collectionRef.get();
    List<TaskModel> tasksList=[];
     tasksList = date.docs.map((e)=>e.data()).toList();
     return tasksList;
     // function map hold list وبتلف عليها عنصر عنصر
  }
  static Stream<QuerySnapshot<TaskModel>>  getRealTimeDataFromFirestore(DateTime  selectedDate)
  {
    var collectionRef= getCollectionRef().where("selectedData",isEqualTo: selectedDate);
    return collectionRef.snapshots();
  }
  static Future<void> deleteTask(TaskModel taskModel)  async {
   var collectionRef= getCollectionRef();
   var docRef = collectionRef.doc(taskModel.id);
   return docRef.delete();
  }
  static Future<void> updataTask(TaskModel taskModel) async{
    var collectRef = getCollectionRef();
    var docRef = collectRef.doc(taskModel.id);
    taskModel.isDone = true;
    return docRef.update(
      taskModel.tofirestore()
    );
  }
  static Future <bool> createAccount(String emailAddress,String password ) async{
    try {
      return Future.value(true) ;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        SnackBarService.showErrorMessage("The password provided is too weak.");
        return Future.value(false);
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        SnackBarService.showErrorMessage("The account already exists for that email.");
        return Future.value(false);
      }
    } catch (e) {
      print(e);
      return Future.value(false);
    }
    return Future.value(false);


  }
  static Future<bool> singIn(String emailAddress,String password) async {
    try {
      EasyLoading.show();
       return Future.value(true);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        SnackBarService.showErrorMessage("No user found for that email.");
        EasyLoading.dismiss();
        return Future.value(false);
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        SnackBarService.showErrorMessage("Wrong password provided for that user.");
        EasyLoading.dismiss();
        return Future.value(false);
      }
      return Future.value(false);
    }
  }

}