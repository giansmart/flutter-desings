import 'package:flutter/material.dart';
import 'dart:math' as math;

class AnimacionesPage extends StatelessWidget {
  const AnimacionesPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CuadradoAnimado(),
      ),
    );
  }
}

class CuadradoAnimado extends StatefulWidget {
  const CuadradoAnimado({
    Key? key,
  }) : super(key: key);

  @override
  State<CuadradoAnimado> createState() => _CuadradoAnimadoState();
}

class _CuadradoAnimadoState extends State<CuadradoAnimado> with SingleTickerProviderStateMixin{

  late AnimationController controller;
  late Animation<double> rotacion;
  late Animation<double> opacidad;
  late Animation<double> opacidadOut;
  late Animation<double> moverDerecha;
  late Animation<double> agrandar;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 4000)
    );
    //rotacion = Tween(begin: 0.0, end: 2 * math.pi).animate(controller);
    rotacion = Tween(begin: 0.0, end: 2 * math.pi).animate( //grados
      CurvedAnimation(parent: controller, curve: Curves.easeOut)
    );

    //opacidad = Tween(begin: 0.1, end: 1.0).animate(controller);
    opacidad = Tween(begin: 0.1, end: 1.0).animate( //porcentajes
      CurvedAnimation(parent: controller, curve: const Interval(0,0.25, curve: Curves.easeOut))
    );

    opacidadOut = Tween(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(parent: controller, curve: const Interval(0.75, 1.0, curve: Curves.easeOut))
    );

    moverDerecha = Tween(begin: 0.0, end: 200.0).animate( //pixeles
      CurvedAnimation(parent: controller, curve: Curves.easeOut)
    );

    agrandar = Tween(begin: 0.3, end: 2.0).animate( //porcentajes
      CurvedAnimation(parent: controller, curve: Curves.easeOut)
    );

    controller.addListener(() {
      //print('status: ${controller.status}');
      if ( controller.status == AnimationStatus.completed) { 
        //controller.reverse();
        //controller.repeat();
        controller.reset();
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //Play
    controller.forward();
    //controller.repeat();
    return AnimatedBuilder(
      animation: controller,
      child: const _Rectangulo(),
      builder: (BuildContext context, Widget? rect) {
        //print('rotacion: ' + rotacion.value.toString());
        //print('Opacidad: ${opacidad.value}');
        //print('Rotacion: ${rotacion.value}');
        return Transform.translate(
          offset: Offset(moverDerecha.value,0),
          child: Transform.rotate(
            angle: rotacion.value,
            child: Opacity(
              opacity: opacidadOut.value,
              child: Transform.scale(
                scale: agrandar.value,
                child: rect
              ),
            )
          ),
        );
      },
    );
  }
}

class _Rectangulo extends StatelessWidget {
  const _Rectangulo({Key? key}) : super(key: key);

    @override
    Widget build(BuildContext context) {
    return Container(
       width: 70,
       height: 70,
       decoration: const BoxDecoration(
         color: Colors.red
       ),
     );
   }
}