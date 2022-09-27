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
  final List<Widget> _telas = [
   
  ];

  bool _bomba = false;
  bool _ventilador = false;
  RangeValues _currentRangeValues = const RangeValues(40, 80);
  DatabaseReference ref = FirebaseDatabase.instance.ref("/ESP32_APP/");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
        body: 
    
        Column(children: <Widget>[
       Center(
      child: Container(
        height: 50,
        padding: const EdgeInsets.fromLTRB(10, 20, 0, 10),
       child: const Align(
        alignment: Alignment.topLeft,
        child:Text("Configuração Manuais",
         textAlign: TextAlign.left,
         style: TextStyle(fontWeight: FontWeight.bold),
        ),
        ),
        ),
     ),
      Center(
          child: SwitchListTile(
        title: const Text('Ventilador'),
        value: _ventilador,
        onChanged: (bool value) async {
          ref.update({
            "ventilador": value,
          });
          setState(() {
            _ventilador = value;
          });
        },
        secondary: const Icon(Icons.lightbulb_outline),
      )),
      Center(
          child: SwitchListTile(
        title: const Text('Bomba'),
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
      )),
      RangeSlider(
        values: _currentRangeValues,
        max: 100,
        divisions: 10,
        labels: RangeLabels(
          _currentRangeValues.start.round().toString(),
          _currentRangeValues.end.round().toString(),
        ),
        onChanged: (RangeValues values) {
          setState(() {
            _currentRangeValues = values;
          });
        },
      ),
     
     
    ]
    )
    );
  }

  String data = '';
  String _displayText = " ";
  void _activateListeners() {
    ref.child('/ESP32_APP/HUMIDITY').onValue.listen((event) {
      setState(() {
        _displayText = (event.snapshot.value.toString());
      });
    });
  }
}
    