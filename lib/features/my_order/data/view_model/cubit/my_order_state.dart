part of 'my_order_cubit.dart';

@immutable
sealed class MyOrderState {}

final class OrderStatusInitial extends MyOrderState {}

final class MyOrderLoading extends MyOrderState {}

final class MyOrderLoaded extends MyOrderState {}

final class MyOrderError extends MyOrderState {}
