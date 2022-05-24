import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_template/app/bloc/app_bloc.dart';
import 'package:flutter_template/home/home.dart';
import 'package:flutter_template/l10n/l10n.dart';
import 'package:flutter_template/theme/theme.dart';
import 'package:todos_repository/todos_repository.dart';

class App extends StatelessWidget {
  const App({Key? key, required this.todosRepository}) : super(key: key);

  final TodosRepository todosRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: todosRepository,
      child: BlocProvider(
        create: (_) => AppBloc(),
        child: const AppPage(),
      ),
    );
  }
}

class AppPage extends StatelessWidget {
  const AppPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      buildWhen: (previousState, state) {
        return previousState.theme != state.theme;
      },
      builder: (context, state) => AppView(selectedTheme: state.theme),
      // child: const AppView(),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({Key? key, required this.selectedTheme}) : super(key: key);
  final ThemeState selectedTheme;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: selectedTheme == ThemeState.light
          ? FlutterTodosTheme.light
          : FlutterTodosTheme.dark,
      darkTheme: FlutterTodosTheme.dark,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: const HomePage(),
    );
  }
}
