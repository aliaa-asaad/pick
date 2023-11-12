part of 'otp_bloc.dart';

@immutable
sealed class OTPState {}

final class OtpInitial extends OTPState {}

final class OTPLoading extends OTPState {}

final class OTPLoaded extends OTPState {}

final class OTPError extends OTPState {}
