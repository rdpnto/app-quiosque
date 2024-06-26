import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile/core/app_state.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<AppState>();

    var month = appState.month;
    var year = appState.year;
    var date = DateFormat('MMMM/yy').format(DateTime(year, month));

    return Scaffold(
      appBar: AppBar(title: Text('Fechamento $date')),
      body: HomeTable()
    );
  }
}

class HomeTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    var theme = Theme.of(context);
    var style = theme.textTheme.displayMedium!
      .copyWith(color: theme.colorScheme.onPrimary, fontStyle: FontStyle.italic)
      .apply(fontSizeFactor: 0.8);

    return DataTable(
      columns: <DataColumn>[
        DataColumn(label: Expanded(child: Text('Data', style: style))),
        DataColumn(label: Expanded(child: Text('Dinheiro', style: style))),
        DataColumn(label: Expanded(child: Text('Pix', style: style))),
        DataColumn(label: Expanded(child: Text('Cartão', style: style))),
        DataColumn(label: Expanded(child: Text('Troco', style: style))),
        DataColumn(label: Expanded(child: Text('Saídas', style: style))),
        DataColumn(label: Expanded(child: Text('Total', style: style)))
      ],
      rows: <DataRow>[
        DataRow(
          cells: <DataCell>[
            DataCell(Text('Teste')),
            DataCell(Text('Teste')),
            DataCell(Text('Teste')),
            DataCell(Text('Teste')),
            DataCell(Text('Teste')),
            DataCell(Text('Teste')),
            DataCell(Text('Teste'))
          ]
        )
      ]
    );
  }
}