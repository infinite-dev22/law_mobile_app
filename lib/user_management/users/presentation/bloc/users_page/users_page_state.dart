part of 'users_page_bloc.dart';

sealed class UsersPageState extends Equatable {
  const UsersPageState();
}

final class UsersPageInitial extends UsersPageState {
  @override
  List<Object> get props => [];
}
