import 'package:bloc/bloc.dart';
import 'package:dars_56_home/cubits/order_state.dart';
import 'package:dars_56_home/data/models/cart.dart';
import 'package:dars_56_home/data/models/order.dart';

class OrderCubit extends Cubit<OrderState>{
  OrderCubit() : super(InitialOrderState());
  List<Order> _orders = [];

  void addOrder(List<Cart> carts){
    emit(LoadingOrderState());
    double price = 0;
    for(int i = 0; i < carts.length;i++){
      price += carts[i].amout * carts[i].product.price;
    }
    _orders.insert(0,Order(carts: carts, price: price));
    emit(LoadedOrderState(_orders));
  }

  List<Order> get orders{
    return [..._orders];
  }
}