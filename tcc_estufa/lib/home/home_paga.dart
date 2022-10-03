import 'dart:html';

import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:tcc_estufa/app_widget.dart';
import 'package:tcc_estufa/firebase_options.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static const String _title = 'Estufa Automatizada';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: _title,
        home: Scaffold(
          appBar: AppBar(title: const Text(_title)),
          body: const Center(
            child: MyStatefulWidget(),
          ),
        ));
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({super.key});

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
DatabaseReference ref = FirebaseDatabase.instance.ref();
    String data = '';
  String _displayText = " ";
  void _activateListeners() {
    ref.child('/ESP32_APP/HUMIDITY').onValue.listen((event) {
      setState(() {
        _displayText = (event.snapshot.value.toString());
      });
    });
  }

  Widget config(){
  return  Column(
    children:[
     const Text("Configuracoes Manuais"),
      SwitchListTile(
        title:   const Text('Modo Automatico'),
        value: _modoauto,
        onChanged: (bool value) async {
          ref.update({
            "auto": value,
          });
          setState(() {
            _modoauto = value;
          }
          );
        },

        secondary: const Icon(Icons.lightbulb_outline),
      ),
  
    SwitchListTile(
        title: const Text('Ventilação'),
        value: _ventilador,
        onChanged: (bool value) async {
          ref.update({
            "ventilador": value,
          });
          setState(() {
            _ventilador = value;
          }
          );
        },

        secondary: const Icon(Icons.lightbulb_outline),
      ),
  
        SwitchListTile(
        title: const Text('Iluminação'),
        value: _luz,
        onChanged: (bool value) async {
          ref.update({
            "luz": value,
          });
          setState(() {
            _luz = value;
          }
          );
        },

        secondary: const Icon(Icons.lightbulb_outline),
      ),
  
     SwitchListTile(
         title: const Text('Irrigação'),
        value: _bomba,
         onChanged: (bool value) async {
          ref.update({
             "bomba": value,
           });
          setState(() {
             _bomba = value;
           });
         },
         secondary: const Icon(Icons.lightbulb_outline),
       ),
      
    ]
   
  );
   

   
  }


Widget auto(){
  return Column(
    children:[
       const Text('Configurações Automaticas'),
      const Text('Temperatura'),
        RangeSlider(
        values: tempRange,
        max: 100,
        divisions: 10,
        labels: RangeLabels(
          tempRange.start.round().toString(),
          tempRange.end.round().toString(),
        ),
        onChanged: (RangeValues values) {
          setState(() {
            tempRange = values;
          });
        },
      ),
            
      const Text('Umidade'),
        RangeSlider(
        values: umiRange,
        max: 100,
        divisions: 10,
        labels: RangeLabels(
          umiRange.start.round().toString(),
          umiRange.end.round().toString(),
        ),
        onChanged: (RangeValues values) {
          setState(() {
            umiRange = values;
          });
        },
      ),
      const Text('Tempo para ativação'),
    ]
  );
}

Widget home(){
  return Column(
    children: [
      Container(
        child: Column(
          children: [
            Row(
              children: [
                Text(_displayText),
              ],
            ),
            Row()
          ],
        
        ),
      ),
    ],
  );
}

RangeValues umiRange = const RangeValues(40, 80);
  bool _modoauto = false; 
  bool _luz = false;
  bool _bomba = false;
  bool _ventilador = false;
  RangeValues tempRange = const RangeValues(40, 80);
  
 int selectedIndex = 0;
 void onItemTapped(int index) {
  setState(() {
    selectedIndex = index;
  });
}
  @override
  Widget build(BuildContext context) {
    _activateListeners();
    return Scaffold(
     
     bottomNavigationBar: BottomNavigationBar(
    items: const <BottomNavigationBarItem>[
      
        
      BottomNavigationBarItem(
        icon: Icon(Icons.home),
        label: 'Home',
        
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.tune),
        label: 'Configurações Automáticas',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.settings),
        label: 'Configurações Manuais',
      ),
      
    ],  
       currentIndex: selectedIndex, //New
  onTap: onItemTapped,      
     ),
//body: <Widget>[
       body:<Widget>[
      Container(
         child:home(),
        ),

        
        
     
        
        Container(
         child:auto(),
        ),
       
     
       
  
        Center(
          child: config(),
        ),
    
       
      ] [selectedIndex],
    );
  }


}    
    
     







   
 


      