import 'package:eczema/core/core.dart';
import 'package:eczema/core/domain/entities/guess_nationality_entity.dart';
import 'package:equatable/equatable.dart';

abstract class GuessNationalityState extends Equatable {
  @override
  List<Object?> get props => [];
}

class GuessNationalityInitial extends GuessNationalityState {}

class GuessNationalityLoading extends GuessNationalityState {}

class GuessNationalityLoaded extends GuessNationalityState {
  final GuessNationalityEntity entity;

  GuessNationalityLoaded({required this.entity});

  @override
  List<Object?> get props => [entity];
}

class GuessNationalityFailure extends GuessNationalityState {
  final Failure failure;

  GuessNationalityFailure({required this.failure});

  @override
  List<Object?> get props => [failure];
}
