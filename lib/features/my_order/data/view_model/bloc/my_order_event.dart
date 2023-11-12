class MyOrderEvent {}

final class OrderStatusClick extends MyOrderEvent {
  
}
final class OrderGetData extends MyOrderEvent {
  final int orderId;
  OrderGetData({required this.orderId});
}