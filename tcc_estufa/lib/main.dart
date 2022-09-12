import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:tcc_estufa/app_widget.dart';
import 'firebase_options.dart';

FirebaseDatabase database = FirebaseDatabase.instance;
final ref = FirebaseDatabase.instance.ref();

//
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
  );

    
  runApp(const AppWidget());
}



 
  


 
 // String data = '';
 //String _displayText = " ";
  //   void  _activateListeners()  {
    
  //   ref.child('/ESP32_APP/HUMIDITY').onValue.listen((event){
  //          setState(() {
  //       _displayText = (event.snapshot.value.toString());
  //     });
    
  //   });
    
  // }

