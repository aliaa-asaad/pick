part of 'payment_bloc.dart';

@immutable
sealed class PaymentEvent {}

final class KSAPaymentClick extends PaymentEvent {}

final class GetEGPaymentClick extends PaymentEvent {}

final class PostEGPaymentClick extends PaymentEvent {}