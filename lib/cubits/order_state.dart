import 'package:dars_56_home/data/models/order.dart';

sealed class OrderState{}

final class InitialOrderState extends OrderState{}

final class LoadingOrderState extends OrderState{}

final class LoadedOrderState extends OrderState{
  List<Order> orders = [
  ];

  LoadedOrderState(this.orders);
}

final class ErrorOrderState extends OrderState{
  String message;

  ErrorOrderState(this.message);
}