part of 'register_bloc.dart';

@immutable
sealed class RegisterEvent {}

final class RegisterClick extends RegisterEvent {}
final class CodeVerificationClick extends RegisterEvent {}
