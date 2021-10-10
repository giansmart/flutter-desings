//import 'package:disenios_app/src/models/slider_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class SlideShow extends StatelessWidget {

  final List<Widget> slides;
  final bool puntosArriba;
  final Color colorPrimario;
  final Color colorSecundario;
  final double bulletPrimario;
  final double bulletSecundario;

  SlideShow({ 
    required this.slides,
    this.puntosArriba = false,
    this.colorPrimario = const Color(0xffE43A78),
    this.colorSecundario = Colors.grey,
    this.bulletPrimario = 12,
    this.bulletSecundario = 12,
   });


  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => _SlideShowModel(),
      child: SafeArea(
        child: Center(
            child: Builder(
              builder: (BuildContext context) {
                Provider.of<_SlideShowModel>(context).colorPrimario = colorPrimario;
                Provider.of<_SlideShowModel>(context).colorSecundario = colorSecundario;
                Provider.of<_SlideShowModel>(context).bulletPrimario = bulletPrimario;
                Provider.of<_SlideShowModel>(context).bulletSecundario = bulletSecundario;

                return _CrearEstructuraSlideShow(puntosArriba: puntosArriba, slides: slides);
              },
            )
          ),
      ),
    );
  }
}

class _CrearEstructuraSlideShow extends StatelessWidget {
  const _CrearEstructuraSlideShow({
    Key? key,
    required this.puntosArriba,
    required this.slides,
  }) : super(key: key);

  final bool puntosArriba;
  final List<Widget> slides;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        if(puntosArriba) 
          _Dots(slides.length),
        Expanded(child: _Slides(slides)),
        if(!puntosArriba) 
          _Dots(slides.length)
      ],
    );
  }
}



class _Dots extends StatelessWidget {

  final int totalSlides;


  _Dots(this.totalSlides);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 70,
      //color: Colors.red,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(totalSlides, (i) => _Dot(i)),
        //children: <Widget>[
        //  _Dot(0),
        //  _Dot(1),
        //  _Dot(2)
        //],

      ),
    );
  }
}

class _Dot extends StatelessWidget {

  final int index;

  _Dot(this.index);

  @override
  Widget build(BuildContext context) {
    final ssModel = Provider.of<_SlideShowModel>(context);

    double tamanio = 0;
    Color color;
    if (ssModel.currentPage >= index - 0.5 && ssModel.currentPage < index + 0.5) {
      tamanio = (ssModel.currentPage == index)
                      ? ssModel.bulletPrimario : ssModel.bulletSecundario;

      tamanio = ssModel.bulletPrimario;
      color = ssModel.colorPrimario;
    } else {
      tamanio = ssModel.bulletSecundario;
      color = ssModel.colorSecundario;
    }

    
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: tamanio,
      height: tamanio,
      margin: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle
      ),
    );
  }
}

class _Slides extends StatefulWidget {

  final List<Widget> slides;

  _Slides( //sin llaves para que sea un argumento posicional
    this.slides
  );

  @override
  State<_Slides> createState() => _SlidesState();
}

class _SlidesState extends State<_Slides> {
  final pageViewController = PageController();

  @override
  void initState() {
    super.initState();
    pageViewController.addListener(() {
      print('current page ${ pageViewController.page }');
      //Actualiza el provider sliderModel
      Provider.of<_SlideShowModel>(context, listen: false).currentPage = pageViewController.page!;

    });
  }

  @override
  void dispose() {
    pageViewController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: PageView(
        controller: pageViewController,
        //children: <Widget>[
        //  _Slide('assets/svg/slide-0.svg'),
        //  _Slide('assets/svg/slide-1.svg'),
        //  _Slide('assets/svg/slide-2.svg')
        //],
        children: widget.slides.map((slide) => _Slide(slide)).toList(),
      ),
    );
  }
}

class _Slide extends StatelessWidget {

  final Widget slide;

  _Slide(this.slide);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: EdgeInsets.all(30),
      child: slide
    );
  }
}


//modelo
class _SlideShowModel with ChangeNotifier{

  double _currentPage = 0;
  Color _colorPrimario = const Color(0xffE43A78);
  Color _colorSecundario = Colors.grey;
  double _bulletPrimario = 10;
  double _bulletSecundario = 12;

  double get currentPage => _currentPage;
  // ignore: unnecessary_getters_setters
  Color get colorPrimario => _colorPrimario;
  Color get colorSecundario => _colorSecundario;
  double get bulletPrimario => _bulletPrimario;
  double get bulletSecundario => _bulletSecundario;



  set currentPage(double currentPg){
    _currentPage = currentPg;
    notifyListeners();
  }

  set colorPrimario(Color color){
    _colorPrimario = color;
    //notifyListeners();
  }

  set colorSecundario(Color color){
    _colorSecundario = color;
    //notifyListeners();
  }

  set bulletPrimario(double tamanio){
    _bulletPrimario = tamanio;
    //notifyListeners();
  }

  set bulletSecundario(double tamanio){
    _bulletSecundario = tamanio;
    //notifyListeners();
  }
}