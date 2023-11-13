part of 'register_bloc.dart';

@immutable
sealed class RegisterState {}

final class RegisterInitial extends RegisterState {}
final class RegisterLoading extends RegisterState {}

final class RegisterLoaded extends RegisterState {}

final class RegisterError extends RegisterState {}