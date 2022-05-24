import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'app_event.dart';
part 'app_state.dart';

/// A `CounterBloc` which handles converting `CounterEvent`s into `int`s.
class AppBloc extends Bloc<AppEvent, AppState> {
  /// The initial state of the `CounterBloc` is 0.
  AppBloc() : super(AppState(theme: ThemeState.dark)) {
    /// When a `CounterIncrementPressed` event is added,
    /// the current `state` of the bloc is accessed via the `state` property
    /// and a new state is emitted via `emit`.
    on<ThemeChangePressed>((event, emit) => emit(AppState(theme: event.theme)));
  }
}
