import 'package:devspace_test/features/home/home.dart';
import 'package:devspace_test/l10n/l10n.dart';
import 'package:devspace_test/repository/repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeBloc>(
      create: (context) => HomeBloc(repository: DataRepository()),
      child: MaterialApp(
        theme: ThemeData(
          appBarTheme:
              const AppBarTheme(color: Color.fromARGB(255, 19, 102, 255)),
          colorScheme: ColorScheme.fromSwatch(
            accentColor: Color.fromARGB(255, 19, 121, 255),
          ),
        ),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: const HomePage(),
      ),
    );
  }
}
