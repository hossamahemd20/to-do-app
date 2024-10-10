import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/core/app_them_manger.dart';
import 'package:flutter_app/core/page_route_name.dart';
import 'package:flutter_app/core/routes_generotors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_app/services/loading_service.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'firebase_options.dart';
void main()

async{
  // to make sure that every await task is done .........
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
  configLoading();
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
  //Navigator.pushNamed(context, PageRoutesNames.initial);
    return MaterialApp(
      title: 'TO DO APP',
      debugShowCheckedModeBanner: false,
      theme:  ApplicationThemeManger.lightThemData,
      initialRoute: PageRoutesNames.initial,
      onGenerateRoute: RoutesGenrtors.onGenerateRoute,
      builder: EasyLoading.init(
        builder: BotToastInit(),
      ),
    );

  }
}



