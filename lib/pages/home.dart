import 'package:flutter/material.dart';
import 'package:mobile/core/app_state.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<AppState>();
    var total = appState.total;

    final theme = Theme.of(context);
    // final style = theme.textTheme.displayMedium!.copyWith(
    //   color: theme.colorScheme.onPrimary
    // );

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () => appState.insertBalance(),
                child: Text('Insert')
              ),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: () => appState.getBalances(),
                child: Text('Get Balances')
              ),
            ]
          ),
          SizedBox(height: 10),
          Center(
            child: Card(
              color: theme.colorScheme.primary,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  'total balances: $total'
                )
              )
            )
          )
        ]
      )
    );
  }
  
}