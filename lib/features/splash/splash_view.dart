import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app/core/page_route_name.dart';

class SplashVeiw extends StatefulWidget{
  @override
  State<SplashVeiw> createState() => _SplashVeiwState();
}

class _SplashVeiwState extends State<SplashVeiw> {
  void initState()
  {
    Timer(Duration(seconds: 6),
        () {Navigator.pushReplacementNamed(context, PageRoutesNames.login,
        );
      },
    );
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:const BoxDecoration(
        image: DecorationImage(image: AssetImage("assets/images/splash_background.png"),
         fit: BoxFit.cover
        ),
      ),
    );
  }
}