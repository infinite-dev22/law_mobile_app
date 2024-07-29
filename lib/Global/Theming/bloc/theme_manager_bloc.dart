import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'theme_manager_event.dart';
part 'theme_manager_state.dart';

class ThemeManagerBloc extends Bloc<ThemeManagerEvent, ThemeManagerState> {
  ThemeManagerBloc() : super(const ThemeManagerState()) {
    on<SwitchThemeEvent>(_mapSwitchThemeEventToState);
  }

  ThemeMode _themeMode = ThemeMode.system;

  get themeMode => _themeMode;

  _mapSwitchThemeEventToState(
      SwitchThemeEvent event, Emitter<ThemeManagerState> emit) {
    _themeMode = event.isDark ? ThemeMode.dark : ThemeMode.light;
    emit(state.copyWith(isDark: event.isDark));
  }
}
