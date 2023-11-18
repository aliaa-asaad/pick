/* part of 'login_cubit.dart';

@immutable
sealed  */
class AuthEvent {}

final class ChooseTypeClick extends AuthEvent {}

final class ChooseCountryTypeClick extends AuthEvent {}

final class LoginClick extends AuthEvent {}

final class RegisterClick extends AuthEvent {}

final class CodeVerificationClick extends AuthEvent {}

final class ForgetPasswordClick extends AuthEvent {}

final class NewPasswordClick extends AuthEvent {}

final class LogoutClick extends AuthEvent {}
