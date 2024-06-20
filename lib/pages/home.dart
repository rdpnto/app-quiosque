
import 'package:flutter/material.dart';
import 'package:mobile/data/db_management.dart';
import 'package:mobile/pages/favorites.dart';
import 'package:mobile/pages/generator.dart';
import 'package:mobile/pages/test.dart';

class Home extends StatefulWidget {
  
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    DB.init();
  }

  @override
  Widget build(BuildContext context) {

    Widget page;
    switch (_selectedIndex) {
      case 0:
        page = GeneratorPage(); break;
      case 1:
        page = FavoritesPage(); break;
      case 2:
        page = TestingPage(); break;
      default:
        throw UnimplementedError('no widget for $_selectedIndex');
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          body: Column(
            children: [
              Expanded(
                child: SafeArea(
                  child: Container(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    child: page,
                  ),
                ),
              ),
              BottomNavigationBar(
                currentIndex: _selectedIndex,
                onTap: (value) {
                  setState(() {
                    _selectedIndex = value;
                  });
                },
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.favorite),
                    label: 'Favorites',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.functions),
                    label: 'Fuck?',
                  ),
                ],
              ),
            ]
          )
        );
      }
    );
  }
}
