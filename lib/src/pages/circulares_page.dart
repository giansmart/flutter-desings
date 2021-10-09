import 'package:disenios_app/src/widgets/radial_progress.dart';
import 'package:flutter/material.dart';

class CircularesPage extends StatefulWidget {
  const CircularesPage({ Key? key }) : super(key: key);

  @override
  _CircularesPageState createState() => _CircularesPageState();
}

class _CircularesPageState extends State<CircularesPage> {

  late double porcentaje = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.refresh),
        onPressed: (){
          setState(() {
            porcentaje += 10;
            if(porcentaje > 100) {
              porcentaje = 0;
            }
          });
        },
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget> [

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              CustomRadialProgress(porcentaje: porcentaje, color: Colors.blue,),
              CustomRadialProgress(porcentaje: porcentaje, color: Colors.red,)
            ],
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              CustomRadialProgress(porcentaje: porcentaje, color: Colors.green,),
              CustomRadialProgress(porcentaje: porcentaje, color: Colors.purple,)
            ],
          ),

        ],
      )
    );
  }
}

class CustomRadialProgress extends StatelessWidget {
  final double porcentaje;
  final Color color;

  CustomRadialProgress({
    required this.porcentaje,
    required this.color
  });


  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 150,
      //color: Colors.red,
      child: RadialProgress(
        porcentaje: porcentaje, 
        colorPrimario: color,
        colorSecundario: Colors.grey,
        grosorSecundario: 10,
        grosorPrimario: 10,
      ),
    );
  }
}