import 'package:bloc/bloc.dart';
import 'package:dars_56_home/cubits/product_state.dart';
import 'package:dars_56_home/data/models/product.dart';
import 'package:flutter/cupertino.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(InitialState());
  List<Product> _products = [];

  void addProduct(Product product) {
    emit(LoadingState());
    if(_products.length != 0){
      product.id = (int.parse(_products[_products.length - 1].id) + 1).toString();
    }else{
      product.id = '1';
    }
    _products.add(product);
    emit(LoadedState(_products));
  }

  void likeProduct(String id){
    for(int i = 0;i < _products.length;i++)
      if(_products[i].id == id)
        _products[i].isFavorite = !_products[i].isFavorite;
    emit(LoadedState(_products));
  }

  void deleteProduct(String id){
    _products.removeWhere((value) => value.id == id);
    if(_products.length == 0){
      emit(InitialState());
    }else{
      emit(LoadedState(_products));
    }
  }

  void editProduct(String id,String title,String imgUrl){
    emit(LoadingState());
    print("bu kelgan id $id");
    for(int i = 0;i < _products.length;i++){
      print("bu id ${_products[i].id}");
      if(_products[i].id == id){
        _products[i].title = title;
        _products[i].imageUrl = imgUrl;
        print("Bu title ${_products[i].title}");
      }
    }
    emit(LoadedState(_products));
  }

}
