import 'package:disenios_app/src/widgets/slideshow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SlideShowPage extends StatelessWidget {
  const SlideShowPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Color(0xffE43A78),
      body: Column(
        children: [
          Expanded(child: MiSlideShow()), //Expanded para no definir un tamanio fijo
          Expanded(child: MiSlideShow())
        ],
      )
    );
  }
}

class MiSlideShow extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return SlideShow(
      puntosArriba: false,
      colorPrimario: Color(0xffE43A78),
      bulletPrimario: 15,
      bulletSecundario: 10,
      slides: <Widget>[
        SvgPicture.asset('assets/svg/slide-0.svg'),
        SvgPicture.asset('assets/svg/slide-1.svg'),
        SvgPicture.asset('assets/svg/slide-2.svg'),
        SvgPicture.asset('assets/svg/slide-3.svg'),
        SvgPicture.asset('assets/svg/slide-4.svg')
      ],
    );
  }
}