import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:mobile/data/db_management.dart';
import 'package:mobile/pages/domain.dart';
import 'package:mobile/pages/home.dart';
import 'package:mobile/pages/register.dart';

class Entrypoint extends StatefulWidget {
  @override
  State<Entrypoint> createState() => _EntrypointState();
}

class _EntrypointState extends State<Entrypoint> {
  late DateFormat dateFormat;
  late DateFormat timeFormat;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    DB.init();
    
    initializeDateFormatting();
    dateFormat = DateFormat.yMMMMd('pt_BR');
    timeFormat = DateFormat.Hms('pt_BR');
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
        page = DomainPage(); break; //ConfigPage Domain
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
