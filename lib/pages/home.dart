import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile/core/app_state.dart';
import 'package:month_year_picker/month_year_picker.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<AppState>();

    final style = Theme.of(context).textTheme.displayMedium!.apply(fontSizeFactor: 0.46);
    
    var date = DateFormat(DateFormat.YEAR_MONTH, 'pt_Br').format(DateTime(appState.year, appState.month));

    return Scaffold(
      appBar: AppBar(
        title: Text('Fechamento $date', style: style),
        actions: [
          IconButton(
            icon: const Icon(Icons.date_range),
            tooltip: 'Selecione a data',
            onPressed: () async {
              final selected = await showMonthYearPicker(
                context: context,
                initialDate: DateTime(appState.year, appState.month),
                firstDate: DateTime(2022),
                lastDate: DateTime(2030),
                locale: Locale('pt', 'BR'),
              );

              if (selected != null) {
                appState.setDate(selected.year, selected.month);
                await appState.getBalances();
              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: 'Atualizar',
            onPressed: () async => await appState.getBalances()
          )
        ]
      ),
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
          DataCell(Text('R\$ ${e.cash.toStringAsFixed(2).replaceFirst('.', ',')}')),
          DataCell(Text('R\$ ${e.pix.toStringAsFixed(2).replaceFirst('.', ',')}')),
          DataCell(Text('R\$ ${e.card.toStringAsFixed(2).replaceFirst('.', ',')}')),
          DataCell(Text('R\$ ${e.change.toStringAsFixed(2).replaceFirst('.', ',')}')),
          DataCell(Text('R\$ ${e.expenses.toStringAsFixed(2).replaceFirst('.', ',')}')),
          DataCell(Text('R\$ ${e.netBalance.toStringAsFixed(2).replaceFirst('.', ',')}'))
        ]);
      })
      .toList();
      
    var theme = Theme.of(context);
    var style = theme.textTheme.displayMedium!
      .copyWith(color: Colors.black87, fontStyle: FontStyle.italic)
      .apply(fontSizeFactor: 0.36);
    
    return InteractiveViewer(
      transformationController: TransformationController(),
      minScale: 1.0,
      maxScale: 2.0,
      constrained: false,
      child: DataTable(
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
      ),
    );
  }
}