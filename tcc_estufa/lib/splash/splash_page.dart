import 'package:flutter/material.dart';


class SplashPage extends StatefulWidget{
  // ignore: non_constant_identifier_names
  const SplashPage({Key? key}) : super (key: key);
  @override
  SplashPageState createState() => SplashPageState();
}


class SplashPageState extends State<SplashPage>{

void initializeSplash() async{
  await Future.delayed(const Duration(seconds: 4));
  Navigator.pushReplacementNamed(context, '/home');
}

  @override
void initState(){
  initializeSplash();
  super.initState();
}

  Widget build(BuildContext context){
    return  Scaffold(
      
       backgroundColor:Colors.blueGrey,
       body: Center(
        child: Image.asset("image/LOGO.png")
       )
    );
  }
}
