import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:tcc_estufa/app_widget.dart';
import 'package:tcc_estufa/firebase_options.dart';
import 'package:numberpicker/numberpicker.dart';
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

  int tempoativacao = 3;
  String data = '';
  String umidadeVal= " ";
  double umidadeDisplay = 0;
  String luzVal = "";
  double luzDisplay = 0 ;
  
  String umidadeSoloVal= " ";
  double umidadeSoloDisplay = 0;
  String temperaturaVal = "";
  double temperaturaDisplay = 0 ;
   final desligado= const Text('Desligado', style: TextStyle (color: Colors.red),);
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
        temperaturaDisplay = double.parse(temperaturaVal)/100;

       
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
return  SafeArea(
      bottom: true,
      top: true,
   child: Container(
  
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

        secondary: const Icon(Icons.hdr_auto_rounded, color: Colors.white70,),
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
  ),
  );
   

   
  }

 
Widget auto(){
 return  SafeArea(
      bottom: true,
      top: true,
   child: Container(

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
        min: 0,
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
        divisions: 100,
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
      const Text('Tempo ativacao da bomba',
           style: TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.w300,
  color: Color(0xFFAFB6C5),)
  ),
      NumberPicker(
       textStyle: TextStyle(color: Color(0x230E151B)),
          value: tempoativacao,
          minValue: 0,
          maxValue: 100,
        
         // onChanged: (value) => setState(() => tempoativacao = value),
          onChanged: (value) {
            ref.update({
            "/estufa_tcc/variaveis/tempoativacao": tempoativacao +1 ,
          } 
          
            );
            setState(() {
            tempoativacao = value;
          });
          }
      ),
    ]
  ),
  ),
  );
}


Widget home(){
return Scaffold(
  backgroundColor:  Color(0xFF1E202C),
  body: 
     
  SafeArea(
      bottom: true,
      top: true,
    child: Scrollbar(child: SingleChildScrollView(
    child:  Container(
   color: Color(0xFF1E202C),
   child:Column(
      children:[
         circular2(),
         circular1(),
          
        
       
   
        lista(),
      ]
  
    
  
          
        
        ),
) ,
  ),)
 
  ),
    );
      

}


Widget circular1(){
  return Padding(
  padding: EdgeInsetsDirectional.fromSTEB(4, 4, 4, 4),
  child: Container(
    width: double.infinity,
    decoration: BoxDecoration(
      color: Color(0xFF1E202C),
       boxShadow: [
        BoxShadow(
          blurRadius:  5,
          color:  Color(0xFF1E202C),
          offset:  Offset(0, 2),
        )
      ],
      borderRadius: BorderRadius.circular(12),
    ),
    child: Padding(
   padding: EdgeInsetsDirectional.fromSTEB(16, 16, 16, 16),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
         const Padding(
             padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 12),
           
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 12),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(16, 12, 16, 0),
                        child: circuloUmidadesolo(),
                         
                      ),
                     const Text(
                        'Umidade do Solo',
            style:   TextStyle(color: Colors.white),
                                
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 12),
                        child: circuloLuz()
                      ),
                     const Text(
                        'Luminosidade',
                       style:   TextStyle( color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  ),
);

}    

Widget circular2(){
  return Padding(
   padding: EdgeInsetsDirectional.fromSTEB(4, 4, 4, 4),
  child: Container(
    width: double.infinity,
    decoration: BoxDecoration(
      color:  Color(0xFF1E202C),
      boxShadow: [
        BoxShadow(
          blurRadius: 5,
          color: Color(0xFF1E202C),
          offset: Offset(0, 2),
        )
      ],
      borderRadius: BorderRadius.circular(12),
    ),
    child: Padding(
     padding: EdgeInsetsDirectional.fromSTEB(16, 12, 0, 0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
           padding: EdgeInsetsDirectional.fromSTEB(16, 16, 16, 16),
            child: Text(
              'Leitura dos Sensores',
               style:   TextStyle(fontSize: 20, color: Colors.white),
            ),
          ),
          Padding(
             padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 12),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 12),
                        child: circulotemp(),
                         
                      ),
                      Text(
                        'Temperatura',
            style:   TextStyle( color: Colors.white),
                                
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 12),
                        child: circuloUmidade()
                      ),
                      Text(
                        'Umidade',
                         style:   TextStyle( color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  ),
);

}    


Widget circuloUmidade(){
  return Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: 100,
                      height: 100,
                      child: CircularProgressIndicator(
                      color: Colors.blueAccent,
                       value: umidadeDisplay ,                 
                        strokeWidth: 10,
                      ),
                    ),
                    Text(
                      '$umidadeVal%',
                      style: const TextStyle(fontSize: 40, color: Colors.white),
                    ),
                  ],
            );
}


Widget circuloUmidadesolo(){
  return Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: 100,
                      height: 100,
                      child: CircularProgressIndicator(
                        color: Colors.greenAccent,
                       value: umidadeSoloDisplay ,                 
                        strokeWidth: 10,
                      ),
                    ),
                    Text(
                      '$umidadeSoloVal%',
                      style: const TextStyle(fontSize: 40, color: Colors.white),
                    ),
                  ],
            );
}


Widget circuloLuz(){
  return Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: 100,
                      height: 100,
                      child: CircularProgressIndicator(
                        color: Colors.yellow,
                       value: luzDisplay ,                 
                        strokeWidth: 10,
                      ),
                    ),
                    Text(
                      '$luzVal%',
                      style: const TextStyle(fontSize: 40, color: Colors.white),
                    ),
                  ],
            );
}

Widget circulotemp(){
  return Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: 100,
                      height: 100,
                      child: CircularProgressIndicator(

                       value: temperaturaDisplay,              
                        strokeWidth: 10,
                        color: Colors.red,
                      ),
                    ),
                    Text(
                      '$temperaturaVal C',
                      style: const TextStyle(fontSize: 40, color: Colors.white),
                    ),
                  ],
            );
}



Widget lista(){
return Column(
  
  children: [
    Card(
      margin: EdgeInsetsDirectional.fromSTEB(16, 2, 16, 0),
      color: Color(0xFF1E202C),
      child: ListTile(
       textColor: Colors.white,
        leading: const Icon(Icons.hdr_auto_rounded, color: Colors.white70,),
        title: Text('Modo automatico:  Desligado'              ),
         
      ),
    ),
    Card(
       margin: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
        color: Color(0xFF1E202C),
        
      child: ListTile(
         textColor: Colors.white,
        leading: const Icon(MdiIcons.fan,  color: Colors.white70,),
        title: Text('Ventilação:  Desligado' , 
       ),
      ),
    ),
    Card(
      margin: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
       color: Color(0xFF1E202C),
      child: ListTile(
         
        leading: const Icon(Icons.lightbulb_outline, color: Colors.white70,),
         textColor: Colors.white,
        title: Text('Aquecimento:  Desligado'),
      ),
    ),
    Card(
      margin: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
       color: Color(0xFF1E202C),
      child: ListTile(
         textColor: Colors.white,
        leading: const Icon(MdiIcons.waterOutline,  color: Colors.white70,),
        title: Text('Irrigação:  Desligado' ),
      ),
    ),
  ]
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
      unselectedItemColor: Colors.grey,
      selectedItemColor: Colors.greenAccent,
     backgroundColor: Color.fromARGB(255, 14, 21, 27),
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
    







   
 


      