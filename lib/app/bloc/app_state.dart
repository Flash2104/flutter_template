part of 'app_bloc.dart';

enum ThemeState { light, dark }

class AppState extends Equatable {
  const AppState({this.theme = ThemeState.dark});

  final ThemeState theme;

  @override
  List<Object> get props => [theme];
}
