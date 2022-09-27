import 'package:flutter/material.dart';
import 'package:tcc_estufa/home/home_paga.dart';
import 'package:tcc_estufa/splash/splash_page.dart';
class AppWidget extends StatelessWidget{
  // ignore: non_constant_identifier_names
  const AppWidget({Key? Key}) : super (key: Key);

@override 

Widget build(BuildContext context)
{
  return  MaterialApp(
    debugShowCheckedModeBanner: false,
   initialRoute: '/splash',
   routes: {
    '/splash' : (context) => SplashPage(),
    '/home' : (context) => MyApp()
   }

    );
  

 
}

}