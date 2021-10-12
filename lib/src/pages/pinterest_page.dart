import 'package:disenios_app/src/widgets/pinterest_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';


class PinterestPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => _MenuModel(),
      child: Scaffold(
        //body: PinterestMenu(),
        //body: PinterestGrid()
        body: Stack(
          children: [
            PinterestGrid(),
            _PinterestMenuLocation()
          ],
        ),
       ),
    );
  }
}

class _PinterestMenuLocation extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final double widthScreen = MediaQuery.of(context).size.width;
    final mostrar = Provider.of<_MenuModel>(context).mostrar;
    return Positioned(
      bottom: 30,
      child: Container(
        //color: Colors.red,
        height: 100,
        width: widthScreen,
        child: Align(
          child: PinterestMenu(
            mostrar: mostrar,
            //backgroundColor: Colors.red,
            primaryColor: Colors.black,
            secondaryColor: Colors.grey,
            items: [
              PinterestButton(icon: Icons.pie_chart, onPressed: () {print('icon pie_chart');}),
              PinterestButton(icon: Icons.search, onPressed: ()=> print('icon search')),
              PinterestButton(icon: Icons.notifications, onPressed: ()=> print('icon notifications')),
              PinterestButton(icon: Icons.supervised_user_circle, onPressed: ()=> print('icon supervised_user_circle'))
            ],
          ),
        ),
      )
    );
  }
}

class PinterestGrid extends StatefulWidget {
  @override
  State<PinterestGrid> createState() => _PinterestGridState();
}

class _PinterestGridState extends State<PinterestGrid> {
  final List<int> items = List.generate(200, (index) => index);
  double scrollAnterior = 0;

  ScrollController controller = ScrollController();

  @override
  void initState() {
    controller.addListener(() {
      //print('scroll listener ${ controller.offset }');
      if(controller.offset > scrollAnterior && controller.offset > 150) {
        //print('ocultar menu');
        Provider.of<_MenuModel>(context, listen: false).mostrar = false; //en el initstate siempre listen=false
      } else {
        //print('mostrar menu');
        Provider.of<_MenuModel>(context, listen: false).mostrar = true;
      }
      scrollAnterior = controller.offset;
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
    return StaggeredGridView.countBuilder(
      controller: controller,
      crossAxisCount: 4,
      itemCount: items.length,
      itemBuilder: (BuildContext context, int index) => _PinterestItem(index),
      staggeredTileBuilder: (int index) =>
         StaggeredTile.count(2, index.isEven ? 2 : 3),
      mainAxisSpacing: 4.0,
      crossAxisSpacing: 4.0,
    );
  }
}

class _PinterestItem extends StatelessWidget {
  final int index;

  _PinterestItem(this.index);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(5),
        //color: Colors.blue,
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.all(Radius.circular(20))
        ),
        child: Center(
          child: CircleAvatar(
            backgroundColor: Colors.white,
            child: Text('$index'),
          ),
        ));
  }
}

class _MenuModel with ChangeNotifier {
  bool _mostrar = true;

  bool get mostrar => _mostrar;

  set mostrar(bool valor) {
    _mostrar = valor;
    notifyListeners();
  }
}