part of 'register_bloc.dart';

@immutable
sealed class RegisterEvent {}
final class RegisterPost extends RegisterEvent {}