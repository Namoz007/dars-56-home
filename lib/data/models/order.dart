import 'package:dars_56_home/data/models/cart.dart';

class Order {
  List<Cart> carts;
  double price;

  Order({
    required this.carts,
    required this.price,
  });
}
