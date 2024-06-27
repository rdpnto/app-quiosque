import 'package:flutter/material.dart';
import 'package:mobile/core/app_state.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<AppState>();

    var theme = Theme.of(context);
    var style = theme.textTheme.displayMedium!
      .copyWith(color: Colors.black87)
      .apply(fontSizeFactor: 0.4);
    
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
                onPressed: () async => await appState.insertBalance(),
                child: Text('Insert')
              ),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: () async => await appState.getBalances(),
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
                child: Text('')
              )
            )
          )
        ]
      ),
    );
  }
}

class InputTextField extends StatelessWidget {
  final IconData icon;
  final String label;
  final String hint;

  InputTextField({
    required this.icon,
    required this.label,
    required this.hint
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        prefixIcon: Icon(icon),
        suffixIcon: Icon(Icons.clear),
        labelText: label,
        hintText: hint,
        border: OutlineInputBorder()
      )
    );
  }
}