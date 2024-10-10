import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/core/page_route_name.dart';
// import 'package:flutter_app/moduels/lay_out_view.dart';
// import 'package:flutter_app/moduels/login/login_view.dart';
// import 'package:flutter_app/moduels/registration/registration_view.dart';
// import 'package:flutter_app/moduels/splash/splash_view.dart';

import '../features/lay_out_view.dart';
import '../features/login/login_view.dart';
import '../features/registration/registration_view.dart';
import '../features/splash/splash_view.dart';

class RoutesGenrtors{
 static Route<dynamic> onGenerateRoute(RouteSettings settings)
{
switch(settings.name)
    {
  case PageRoutesNames.initial:
    return MaterialPageRoute(builder:
        (context)=>SplashVeiw(),
    settings:settings);

  case PageRoutesNames.login:
    return MaterialPageRoute(builder: (context)=> LoginView(),settings: settings);
  case PageRoutesNames.registration:
    return MaterialPageRoute(builder: (context)=> RegistrationVeiw(),settings: settings);
  case PageRoutesNames.layout:
    return MaterialPageRoute(builder: (context)=> LayoutView(),settings: settings);
  default:
    return MaterialPageRoute(builder: (context)=> SplashVeiw(),settings: settings);

    }
}
}