import 'package:dars_56_home/data/models/cart.dart';

sealed class CartState{}

final class InitialCartState extends CartState{}

final class LoadingCartState extends CartState{}

final class LoadedCartState extends CartState{
  List<Cart> products = [];

  LoadedCartState(this.products);
}

final class ErrorCartState extends CartState{
  String message;

  ErrorCartState(this.message);
}