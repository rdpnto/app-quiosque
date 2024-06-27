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
    var appState = context.watch<AppState>();
    var rows = appState
      .balances
      .map((e) {
        return DataRow(cells: [
          DataCell(Text(DateFormat('dd/MM/yyyy').format(e.date))),
          DataCell(Text(e.cash.toString())),
          DataCell(Text(e.pix.toString())),
          DataCell(Text(e.card.toString())),
          DataCell(Text(e.change.toString())),
          DataCell(Text(e.expenses.toString())),
          DataCell(Text(e.netBalance.toString()))
        ]);
      })
      .toList();
      
    var theme = Theme.of(context);
    var style = theme.textTheme.displayMedium!
      .copyWith(color: Colors.black87, fontStyle: FontStyle.italic)
      .apply(fontSizeFactor: 0.4);

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
      rows: rows
    );
  }
}