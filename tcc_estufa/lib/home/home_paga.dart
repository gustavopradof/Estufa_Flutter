import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
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
    
          //appBar: AppBar(title: const Text(_title)),
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
  String umidadeVal= " ";
  double umidadeDisplay = 0;
  String luzVal = "";
  double luzDisplay = 0 ;
  
  String umidadeSoloVal= " ";
  double umidadeSoloDisplay = 0;
  String temperaturaVal = "";
  double temperaturaDisplay = 0 ;

  void _leumidade() {
    ref.child('/estufa_tcc/sensores/umidade').onValue.listen((event) {
      setState(() {
        umidadeVal = (event.snapshot.value.toString());
        umidadeDisplay = double.parse(umidadeVal)/100;
       
      });
    });
  }


  void _leluz() {
    ref.child('/estufa_tcc/sensores/luz').onValue.listen((event) {
      setState(() {
        luzVal = (event.snapshot.value.toString());
        luzDisplay = double.parse(luzVal)/100;
       
      });
    });
  }

  void _letemp() {
    ref.child('/estufa_tcc/sensores/temperatura').onValue.listen((event) {
      setState(() {
        temperaturaVal = (event.snapshot.value.toString());
        temperaturaDisplay = double.parse(temperaturaVal);

       
      });
    });
  }
 
  void _leumidadesolo() {
    ref.child('/estufa_tcc/sensores/umidade_solo').onValue.listen((event) {
      setState(() {
        umidadeSoloVal = (event.snapshot.value.toString());
        umidadeSoloDisplay = double.parse(umidadeSoloVal)/100;
       
      });
    });
  }


  
  
Widget config(){
 
return Container(
  
 color: Color(0xFF1E202C),
child:  Column(
    
    children:[
      
     const Text("Configuracoes Manuais",
      style: TextStyle(
  fontSize: 28,
  fontWeight: FontWeight.w600,
  color: Colors.white,
      ),),
      SwitchListTile(
        
        title:   const Text('Modo Automatico', 
        style: 
        TextStyle(color: Colors.white),),
activeColor: Colors.greenAccent,
tileColor:Colors.amber ,

        value: _modoauto,
        onChanged: (bool value) async {
          ref.update({
            "/estufa_tcc/variaveis/auto": value,
          });
          setState(() {
            _modoauto = value;
          }
          );
        },

        secondary: const Icon(Icons.lightbulb_outline, color: Colors.white70,),
      ),
  
    SwitchListTile(
        title: const Text('Ventilação',
           style: TextStyle(
  
  color: Colors.white,
      ),),
      activeColor: Colors.greenAccent,
        value: _ventilador,
        onChanged: (bool value) async {
          ref.update({
            "/estufa_tcc/atuadores/ventilador": value,
          });
          setState(() {
            _ventilador = value;
          }
          );
        },

        secondary: const Icon(MdiIcons.fan,  color: Colors.white70,),
      ),
  
        SwitchListTile(
        title: const Text('Iluminação',
          style: TextStyle(
  
  color: Colors.white,
      ),),
      activeColor: Colors.greenAccent,
        value: _luz,
        onChanged: (bool value) async {
          ref.update({
            "/estufa_tcc/atuadores/luz": value,
          });
          setState(() {
            _luz = value;
          }
          );
        },

        secondary: const Icon(Icons.lightbulb_outline,  color: Colors.white70,),
      ),
  
     SwitchListTile(
         title: const Text('Irrigação',
               style: TextStyle(
  
  color: Colors.white,
      ),),
      activeColor: Colors.greenAccent,
        value: _bomba,
         onChanged: (bool value) async {
          ref.update({
             "/estufa_tcc/atuadores/bomba": value,
           });
          setState(() {
             _bomba = value;
           });
         },
         secondary: const Icon(MdiIcons.waterOutline,  color: Colors.white70,),
       ),
      
    ]
  ),
  );
   

   
  }

 
Widget auto(){
  return Container(

     color: Color(0xFF1E202C),
     
   child: Column(
    
    children:[
      const Text('Configurações Automaticas',
      style: TextStyle(
  fontSize: 28,
  fontWeight: FontWeight.w600,
  color: Colors.white,
      ),
      ),
      const Text('Temperatura',
      style: TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.w300,
  color: Color(0xFFAFB6C5),
      ),
      ),
        RangeSlider(
          activeColor: Colors.greenAccent,
        inactiveColor: Colors.black26,
        values: tempRange,
        max: 100,
        divisions: 100,
        labels: RangeLabels(
          tempRange.start.round().toString(),
          tempRange.end.round().toString(),
        ),
        onChanged:  (RangeValues values) async {
          ref.update({
            "/estufa_tcc/variaveis/maxTemp": tempRange.end,
            "/estufa_tcc/variaveis/minTemp": tempRange.start,
          });
          setState(() {
            
            tempRange = values;
          });
        },
      ),
            
      const Text('Umidade',
           style: TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.w300,
  color: Color(0xFFAFB6C5),
  ),
  ),
        RangeSlider(
           activeColor: Colors.greenAccent,
        values: umiRange,
        max: 100,
        divisions: 10,
        labels: RangeLabels(
          umiRange.start.round().toString(),
          umiRange.end.round().toString(),
        ),
        onChanged: (RangeValues values) {
          ref.update({
            "/estufa_tcc/variaveis/maxUmi": umiRange.end,
            "/estufa_tcc/variaveis/minUmi": umiRange.start,
          });
          setState(() {
            umiRange = values;
          });
        },
      ),
      const Text('Tempo para ativação',
           style: TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.w300,
  color: Color(0xFFAFB6C5),)
  ),
    ]
  ),
  );
}


Widget home(){

  return Container(
   color: Color(0xFF1E202C),
   child:Column(
    
    children: [
            
        Column(
          
          children: [
            Row(
              children: [
             Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: 207,
                      height: 207,
                      child: CircularProgressIndicator(
                       value: umidadeDisplay,                 
                        strokeWidth: 20,
                      ),
                    ),
                    Text(
                      umidadeVal,
                      style: const TextStyle(fontSize: 40),
                    ),
                  ],
            ),
            Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: 207,
                      height: 207,
                      child: CircularProgressIndicator(

                       value: temperaturaDisplay,                 
                        strokeWidth: 10,
                      ),
                    ),
                    Text(
                      temperaturaVal,
                      style: const TextStyle(fontSize: 40),
                    ),
                  ],
            )
            
              ],
            ),
       

  
            
          ],
    
  
          
        
        ),
      
    ],
   ),
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
    _leumidade();
    _leluz();
    _letemp();
    _leumidadesolo();
   
    return Scaffold(
     
     bottomNavigationBar: BottomNavigationBar(
      
     backgroundColor: Color(0xFF1E202C),
    items: const <BottomNavigationBarItem>[
      
        
      BottomNavigationBarItem(
        icon: Icon(Icons.home),
        label: 'Home',
        
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.tune),
        label: 'Automático ',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.settings),
        label: 'Manual',
      ),
      
    ],  
       currentIndex: selectedIndex, //New
  onTap: onItemTapped,      
     ),
//body: <Widget>[
       body:<Widget>[
      Container(
        color: Colors.blue,
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
    
     







   
 


      