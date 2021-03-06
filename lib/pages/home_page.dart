import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rapidinho/data/data.dart';
import 'package:rapidinho/model/navigation_category.dart';
import 'package:rapidinho/tabs/delivery_tab.dart';
import 'package:rapidinho/tabs/home_tab.dart';
import 'package:rapidinho/tabs/account_tab.dart';
import 'package:rapidinho/tabs/shopping_cart_tab.dart';
import 'package:rapidinho/ui/styling/rapidinho_style.dart';

class HomePage extends StatefulWidget {

  final int filter;

  HomePage({this.filter});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {

  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: navigationCategories.length);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List<BottomNavigationBarItem> navigationItems() {
    return navigationCategories.map((category){
      return BottomNavigationBarItem(
        title: new Text(category.name, style: RapidinhoTextStyle.bottomTextStyle),
        icon: new Icon(category.icon, size: category.name ==  'Entregas' ? 24.0 : 18.0, color: _currentIndex == category.index ? Colors.red : Colors.grey),
      );
    }).toList();
  }

  // selected index
  int _currentIndex = 0;

  Future<bool> _exitApp() async {
    return showDialog(
        context: context,
        builder: (builderContext) {
          return AlertDialog(
            title: new Text("Aviso", style: RapidinhoTextStyle.displayText),
            content: new Text("Tem a certeza que deseja sair do aplicativo?", style: RapidinhoTextStyle.largeText),
            actions: <Widget>[
              new FlatButton(
                onPressed: () => Navigator.of(builderContext).pop(false),
                child: new Text("Não", style: RapidinhoTextStyle.normalText),
              ),
              new FlatButton(
                onPressed: () => Navigator.of(builderContext).pop(true),
                child: new Text("Sim", style: RapidinhoTextStyle.normalText),
              )
            ],
          );
        }
    );
  }

  Widget _buildFloatingActionButton(NavigationCategory tab) {
    if(tab.name == 'Entregas' || tab.name == 'Casa')
      return null;

    return FloatingActionButton(
        key: tab.key,
        tooltip: tab.name,
        mini: true,
        backgroundColor: Colors.red,
        child: Icon(tab.name == 'Conta' ? Icons.edit : Icons.add),
        onPressed: (){

        }
    );
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _exitApp,
      child: Scaffold(
        backgroundColor: Colors.white,
        bottomNavigationBar: new BottomNavigationBar(
          currentIndex: _currentIndex,
          items: navigationItems(),
          onTap: (int index){
            setState(() {
              _currentIndex = index;
              Future.delayed(Duration(milliseconds: 500), (){
                _tabController.animateTo(_currentIndex);
              });
            });
          },
        ),
        body: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          controller: _tabController,
          children: [
            HomeTab(_currentIndex, widget.filter),
            DeliveryTab(_currentIndex),
            Center(
			  child: ShoppingCartTab(),
			),
            Padding(
              padding: const EdgeInsets.only(top: kToolbarHeight),
              child: AccountTab(),
            ),
          ],
        ),
        floatingActionButton: _buildFloatingActionButton(navigationCategories[_currentIndex]),
      ),
    );
  }
}
