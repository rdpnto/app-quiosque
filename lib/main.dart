import 'package:flutter/material.dart';
import 'package:mobile/core/app_state.dart';
import 'package:mobile/pages/entrypoint.dart';
import 'package:month_year_picker/month_year_picker.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
	runApp(App());
}

class App extends StatelessWidget {
	const App({super.key});

	@override
	Widget build(BuildContext context) {
		return ChangeNotifierProvider(
			create: (context) => AppState(),
			child: MaterialApp(
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          MonthYearPickerLocalizations.delegate,
        ],
        locale: const Locale('pt','BR'),
        debugShowCheckedModeBanner: false,
				title: 'App Quiosque',
				theme: ThemeData(
					useMaterial3: true,
					colorScheme: ColorScheme.fromSeed(seedColor: Colors.green)
				),
				home: Entrypoint()
			)
		);
	}
}