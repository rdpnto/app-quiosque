import 'package:flutter/material.dart';
import 'package:mobile/pages/home.dart';

class Entrypoint extends StatefulWidget {
  
  @override
  State<Entrypoint> createState() => _EntrypointState();
}

class _EntrypointState extends State<Entrypoint> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    Widget page;
    
    switch (_selectedIndex) {
      case 0:
        page = HomePage(); break;
      case 1:
        page = HomePage(); break;
      case 2:
        page = HomePage(); break;
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
                    child: page
                  ),
                ),
              ),
              BottomNavigationBar(
                currentIndex: _selectedIndex,
                onTap: (i) => setState(() { _selectedIndex = i; }),
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
                    label: 'Test',
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
