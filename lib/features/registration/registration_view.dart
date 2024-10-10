import 'package:flutter/material.dart';
import 'package:flutter_app/core/firebase_utils.dart';
import 'package:flutter_app/services/snack_bar_service.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class RegistrationVeiw extends StatefulWidget{
  @override
  State<RegistrationVeiw> createState() => _RegistrationVeiwState();
}

class _RegistrationVeiwState extends State<RegistrationVeiw> {
  bool isobscure =true;

  var formkey =GlobalKey<FormState>();
  TextEditingController usercontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var mediaQuery=MediaQuery.of(context);
    return Container(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            centerTitle: true,
            title: const Text("Create Account"),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Form(
              child: Column (
                key: formkey,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: mediaQuery.size.height*0.02,
                  ),
                  TextField(
                    controller: usercontroller,
                    decoration: InputDecoration(
                      label: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Name",
                            style: theme.textTheme.displayLarge?.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Icon(Icons.person),
                        ],
                      ),
                      hintText: "enter your name",
                      focusedBorder: OutlineInputBorder(
                        borderSide:BorderSide(
                          color:theme.primaryColor,
                          width: 2,
                        ),

                      ),

                    ),

                  ),
                  SizedBox(height: 30,),
                  TextFormField(
                    controller: emailcontroller,
                    validator: (value)
                    {
                      if(value==null||value.trim().isEmpty)
                      {
                        return "please enter email...." ;
                      }
                      var regex= RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$');
                      if(!regex.hasMatch(value))
                      {
                        return "invalid email";
                      }
                      return null;
                    },
                    onChanged: (value)
                    {
                      print(value);
                    },

                    decoration: InputDecoration(
                      label: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("E-mail",
                            style: theme.textTheme.displayLarge?.copyWith(
                              fontWeight: FontWeight.w500,
                            ),

                          ),

                          Icon(Icons.email),
                        ],

                      ),
                      hintText: "enter your Email address",
                      focusedBorder: OutlineInputBorder(
                        borderSide:BorderSide(
                          color:theme.primaryColor,
                          width: 2,
                        ),

                      ),

                    ),

                  ),
                  SizedBox(height: 30,),
                  // FilledButton(onPressed: (){
                  //   if(formkey.currentState!.validate())
                  //   {
                  //     print("valid");
                  //     print(emailcontroller.text);
                  //   }
                  // },
                  //   child: null,
                  // ),
                  TextField(

                    obscureText: isobscure,
                    controller: passwordcontroller,
                    decoration: InputDecoration(
                      labelText: ("password"),labelStyle: theme.textTheme.displayLarge,

                      suffixIcon:   InkWell(
                        onTap: (){
                          setState(() {
                            isobscure =!isobscure;
                          });
                        },
                        child: Icon(Icons.remove_red_eye),
                      ),
                      // Text("password",
                      //   style: theme.textTheme.displaySmall?.copyWith(
                      //     fontWeight: FontWeight.w500,
                      //   ),
                      // ),
                      hintText: "enter password",
                      focusedBorder: OutlineInputBorder(
                        borderSide:BorderSide(
                          color:theme.primaryColor,
                          width: 2,
                        ),
                      ),

                    ),
                  ),
                  SizedBox(height: 30,),
                  FilledButton(onPressed: (){

                    if(formkey.currentState!.validate())
                    {

                      FirebaseUtils.createAccount(emailcontroller.text, passwordcontroller.text)
                          .then((value){
                            if(value)
                              {
                                EasyLoading.dismiss();
                                SnackBarService.showSuccessMessage("Account create succsfully");
                                Navigator.pop(context);
                              }
                      });
                    }
                    print(passwordcontroller.text);
                  },
                    style: FilledButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                      backgroundColor: theme.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Create Account",
                          style: theme.textTheme.bodyLarge?.copyWith(
                            color: Colors.white,
                          ),
                        ),
                        Icon(Icons.arrow_forward),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
    );
  }
}