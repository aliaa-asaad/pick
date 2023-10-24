part of 'order_bloc.dart';

@immutable
sealed class OrderEvent {}

final class OrderDataClick extends OrderEvent {
  /* final OrderModel orderModel;
  OrderClick(this.orderModel); */
}
