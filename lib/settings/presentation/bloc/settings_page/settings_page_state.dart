part of 'settings_page_bloc.dart';

sealed class SettingsPageState extends Equatable {
  const SettingsPageState();
}

final class SettingsPageInitial extends SettingsPageState {
  @override
  List<Object> get props => [];
}
