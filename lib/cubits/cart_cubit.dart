import 'package:bloc/bloc.dart';
import 'package:dars_56_home/cubits/cart_state.dart';
import 'package:dars_56_home/data/models/cart.dart';
import 'package:dars_56_home/data/models/product.dart';

class CartCubit extends Cubit<CartState>{
  CartCubit() : super(InitialCartState());
  List<Cart> _carts = [];

  void addProduct(Product product){
    emit(LoadingCartState());
    int i = _carts.indexWhere((element) => element.product.id == product.id);
    if(i != -1){
      int index = _carts.indexWhere((element) => element.product.id == product.id);
      _carts[index].amout++;
    }else{
      _carts.add(Cart(product: product, amout: 1),);
    }
    emit(LoadedCartState(_carts));
  }

  List<Cart> get carts {
    return [..._carts];
  }

  void removeAmountProduct(String id){
    emit(LoadingCartState());
    int index = _carts.indexWhere((element) => element.product.id == id);
    if(_carts[index].amout == 1){
      _carts.removeAt(index);
    }else{
      _carts[index].amout--;
    }
    emit(LoadedCartState(_carts));
  }

  void removeAllCart(){
    emit(LoadingCartState());
    _carts = [];
    emit(LoadedCartState(_carts));
  }

  void addProductAmout(String id){
    emit(LoadingCartState());
    int index = _carts.indexWhere((element) => element.product.id == id);
    _carts[index].amout++;
    emit(LoadedCartState(_carts));
  }

  void removeProductFromCart(String id){
    _carts.removeWhere((element) => element.product.id == id);
  }
}