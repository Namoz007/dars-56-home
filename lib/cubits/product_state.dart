import 'package:dars_56_home/data/models/product.dart';

sealed class ProductState{}

final class InitialState extends ProductState{}

final class LoadingState extends ProductState{}

final class LoadedState extends ProductState{
  List<Product> products = [];

  LoadedState(this.products);
}

final class ErrorState extends ProductState{
  String message;

  ErrorState(this.message);
}