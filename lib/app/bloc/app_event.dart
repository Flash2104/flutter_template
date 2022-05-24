part of 'app_bloc.dart';

abstract class AppEvent extends Equatable {
  const AppEvent();

  @override
  List<Object> get props => [];
}

/// Notifies bloc to increment state.
class ThemeChangePressed extends AppEvent {
  const ThemeChangePressed(this.theme);

  final ThemeState theme;

  @override
  List<Object> get props => [theme];
}
