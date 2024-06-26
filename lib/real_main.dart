import 'package:flutter/material.dart';
import 'package:mobile/core/app_state.dart';
import 'package:mobile/pages/entrypoint.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
	const App({super.key});

	@override
	Widget build(BuildContext context) {
		return ChangeNotifierProvider
		(
			create: (context) => AppState(),
			child: MaterialApp
			(
        debugShowCheckedModeBanner: false,
				title: 'App Quiosque',
				theme: ThemeData
				(
					useMaterial3: true,
					colorScheme: ColorScheme.fromSeed(seedColor: Colors.green)
				),
				home: Entrypoint()
			)
		);
	}
}