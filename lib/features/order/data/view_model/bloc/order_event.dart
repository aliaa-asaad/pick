part of 'order_bloc.dart';

@immutable
sealed class OrderEvent {}

final class OrderDataClick extends OrderEvent {}
final class OrderImagesClick extends OrderEvent {}
final class OrderSubmitClick extends OrderEvent {}

