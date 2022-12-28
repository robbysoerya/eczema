import 'package:equatable/equatable.dart';

class LoginState extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginLoaded extends LoginState {
  final bool value;

  LoginLoaded({required this.value});

  @override
  List<Object?> get props => [value];
}

class LoginFailure extends LoginState {}
