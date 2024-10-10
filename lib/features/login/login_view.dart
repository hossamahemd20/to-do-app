import 'package:flutter/material.dart';
import 'package:flutter_app/core/page_route_name.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../core/firebase_utils.dart';

class LoginView extends StatefulWidget {
  @override
  State<LoginView> createState() => LoginViewState();
}

class LoginViewState extends State<LoginView> {
  bool isobscure = true;
  var formkey = GlobalKey<FormState>();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var mediaQuery = MediaQuery.of(context);
    return Container(
        child: Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text("login"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Form(
          child: Column(
            key: formkey,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: mediaQuery.size.height * 0.02,
              ),
              Text(
                "Wellcome back !",
                style: theme.textTheme.titleLarge?.copyWith(
                  color: Colors.white,
                ),
              ),
              TextFormField(
                controller: emailcontroller,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "please enter email....";
                  }
                  var regex =
                      RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$');
                  if (!regex.hasMatch(value)) {
                    return "invalid email";
                  }
                  return null;
                },
                onChanged: (value) {
                  print(value);
                },
                decoration: InputDecoration(
                  label: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "E-mail",
                        style: theme.textTheme.displayLarge?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Icon(Icons.email),
                    ],
                  ),
                  hintText: "enter your Email address",
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: theme.primaryColor,
                      width: 2,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              ),
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
                  labelText: ("password"),
                  labelStyle: theme.textTheme.displayLarge,

                  suffixIcon: InkWell(
                    onTap: () {
                      setState(() {
                        isobscure = !isobscure;
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
                    borderSide: BorderSide(
                      color: theme.primaryColor,
                      width: 2,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                "forget password ??",
                style: theme.textTheme.displaySmall
                    ?.copyWith(decoration: TextDecoration.underline),
              ),
              const SizedBox(
                height: 30,
              ),
              FilledButton(
                onPressed: () {
                  // print(passwordcontroller.text);
                  Navigator.pushNamed(context, PageRoutesNames.layout);
                  FirebaseUtils.createAccount(
                          emailcontroller.text, passwordcontroller.text)
                      .then((value) {
                    if (value) {
                      EasyLoading.dismiss();

                      Navigator.pushReplacementNamed(
                          context, PageRoutesNames.layout);
                    }
                  });
                },
                style: FilledButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  backgroundColor: theme.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "login",
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: Colors.white,
                      ),
                    ),
                    Icon(Icons.arrow_forward)
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    PageRoutesNames.registration,
                  );
                },
                child: Text(
                  "or create anew account !!",
                  style: theme.textTheme.displaySmall
                      ?.copyWith(decoration: TextDecoration.underline),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
