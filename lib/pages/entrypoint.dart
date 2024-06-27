import 'package:flutter/material.dart';
import 'package:mobile/data/db_management.dart';
import 'package:mobile/domain/service/balance_service.dart';
import 'package:mobile/pages/home.dart';
import 'package:mobile/pages/register.dart';

class Entrypoint extends StatefulWidget {
  
  @override
  State<Entrypoint> createState() => _EntrypointState();
}

class _EntrypointState extends State<Entrypoint> {
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
        page = HomePage(); break;
      case 1:
        page = RegisterPage(); break;
      case 2:
        page = HomePage(); break; //ConfigPage Domain
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
                    icon: Icon(Icons.attach_money),
                    label: 'Balances',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.add_chart),
                    label: 'Register',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.domain),
                    label: 'Config',
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
