import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PinterestButton {
  final Function() onPressed;
  final IconData icon;

  PinterestButton({required this.onPressed,required this.icon});

}

class PinterestMenu extends StatelessWidget {

  final bool mostrar;
  final Color backgroundColor;
  final Color primaryColor;
  final Color secondaryColor;
  final List<PinterestButton> items;

  PinterestMenu({
    this.mostrar = true,
    this.backgroundColor = Colors.white,
    this.primaryColor = Colors.black,
    this.secondaryColor = Colors.blueGrey,
    required this.items
  });
  
  /*final List<PinterestButton> items = [
    PinterestButton(icon: Icons.pie_chart, onPressed: () {print('icon pie_chart');}),
    PinterestButton(icon: Icons.search, onPressed: ()=> print('icon search')),
    PinterestButton(icon: Icons.notifications, onPressed: ()=> print('icon notifications')),
    PinterestButton(icon: Icons.supervised_user_circle, onPressed: ()=> print('icon supervised_user_circle'))
  ];*/

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => _MenuModel(),
      child: AnimatedOpacity(
        duration: Duration(milliseconds: 250),
        opacity: (mostrar) ? 1 : 0,
        child: Builder(builder: (BuildContext context) {
          Provider.of<_MenuModel>(context).backgroundColor = backgroundColor;
          Provider.of<_MenuModel>(context).primaryColor = primaryColor;
          Provider.of<_MenuModel>(context).secondaryColor = secondaryColor;

          return _PinterestMenuBackground(child: _MenuItems(items));
        }),
      ),
    );
  }
}

class _PinterestMenuBackground extends StatelessWidget {

  final Widget child;

  const _PinterestMenuBackground({
    required this.child
  });

  @override
  Widget build(BuildContext context) {
    Color bkgColor = Provider.of<_MenuModel>(context).backgroundColor;

    return Container(
      child: child,
      width: 250,
      height: 60,
      decoration: BoxDecoration(
        color: bkgColor,
        borderRadius: BorderRadius.all(Radius.circular(100)),
        boxShadow: <BoxShadow> [
          BoxShadow(
            color: Colors.black38,
            //offset: Offset(10,10)
            blurRadius: 10,
            spreadRadius: -5
          )
        ]
      ),
    );
  }
}

class _MenuItems extends StatelessWidget {
  final List<PinterestButton> menuItems;

  _MenuItems(this.menuItems);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(menuItems.length, (index) => _PinterestMenuButton(index, menuItems[index]))
    );
  }
}

class _PinterestMenuButton extends StatelessWidget {

  final int index;
  final PinterestButton button;

  _PinterestMenuButton(this.index, this.button);

  @override
  Widget build(BuildContext context) {
    final itemSeleccionado = Provider.of<_MenuModel>(context).itemSeleccionado;
    final menuModel = Provider.of<_MenuModel>(context);

    return GestureDetector(
      //onTap: button.onPressed,
      onTap: (){
        Provider.of<_MenuModel>(context, listen: false).itemSeleccionado = index;
        button.onPressed();
      },
      behavior: HitTestBehavior.translucent,
      child: Container(
        child: Icon(
          button.icon, 
          size: (itemSeleccionado == index)? 30: 25, 
          color: (itemSeleccionado == index) ? menuModel.primaryColor: menuModel.secondaryColor,
        ),
      ),
    );
  }
}

class _MenuModel with ChangeNotifier {
  int _itemSeleccionado = 0;
  Color _primaryColor = Colors.black;
  Color _secondaryColor = Colors.grey;
  Color _backgroundColor = Colors.white;

  int get itemSeleccionado => _itemSeleccionado;
  Color get primaryColor => _primaryColor;
  Color get secondaryColor => _secondaryColor;
  Color get backgroundColor => _backgroundColor;


  set itemSeleccionado(int index) {
    _itemSeleccionado = index;
    notifyListeners();
  }

  // ignore: unnecessary_getters_setters
  set primaryColor(Color color) => _primaryColor = color;
  set secondaryColor(Color color) => _secondaryColor = color;
  set backgroundColor(Color color) => _backgroundColor = color;

}