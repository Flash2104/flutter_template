import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_template/app/bloc/app_bloc.dart';
import 'package:flutter_template/l10n/l10n.dart';
import 'package:flutter_template/todos_overview/todos_overview.dart';

@visibleForTesting
enum TodosOverviewOption { toggleAll, clearCompleted, themeToggle }

class TodosOverviewOptionsButton extends StatelessWidget {
  const TodosOverviewOptionsButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    final todos = context.select((TodosOverviewBloc bloc) => bloc.state.todos);
    final selectedTheme = context.select((AppBloc bloc) => bloc.state.theme);
    final hasTodos = todos.isNotEmpty;
    final completedTodosAmount = todos.where((todo) => todo.isCompleted).length;

    return PopupMenuButton<TodosOverviewOption>(
      shape: const ContinuousRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      tooltip: l10n.todosOverviewOptionsTooltip,
      onSelected: (options) {
        switch (options) {
          case TodosOverviewOption.toggleAll:
            context
                .read<TodosOverviewBloc>()
                .add(const TodosOverviewToggleAllRequested());
            break;
          case TodosOverviewOption.clearCompleted:
            context
                .read<TodosOverviewBloc>()
                .add(const TodosOverviewClearCompletedRequested());
            break;
          case TodosOverviewOption.themeToggle:
            context.read<AppBloc>().add(ThemeChangePressed(
                selectedTheme == ThemeState.light
                    ? ThemeState.dark
                    : ThemeState.light));
        }
      },
      itemBuilder: (context) {
        return [
          PopupMenuItem(
            value: TodosOverviewOption.toggleAll,
            enabled: hasTodos,
            child: Text(
              completedTodosAmount == todos.length
                  ? l10n.todosOverviewOptionsMarkAllIncomplete
                  : l10n.todosOverviewOptionsMarkAllComplete,
            ),
          ),
          PopupMenuItem(
            value: TodosOverviewOption.clearCompleted,
            enabled: hasTodos && completedTodosAmount > 0,
            child: Text(l10n.todosOverviewOptionsClearCompleted),
          ),
          PopupMenuItem(
            value: TodosOverviewOption.themeToggle,
            child: BlocBuilder<AppBloc, AppState>(
                builder: (context, state) =>
                    _ThemeToggleButton(selectedTheme: state.theme)),
          ),
        ];
      },
      icon: const Icon(Icons.more_vert_rounded),
    );
  }
}

class _ThemeToggleButton extends StatelessWidget {
  const _ThemeToggleButton({
    Key? key,
    required this.selectedTheme,
  }) : super(key: key);

  final ThemeState selectedTheme;

  @override
  Widget build(BuildContext context) {
    return Container(
        // onPressed: null,
        child: Row(
      children: [
        Text('Theme'),
        Switch(
          onChanged: (value) => null,
          value: selectedTheme == ThemeState.light,
        )
      ],
    ));
  }
}
