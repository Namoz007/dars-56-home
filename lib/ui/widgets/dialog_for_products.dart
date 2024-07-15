import 'package:dars_56_home/cubits/product_cubit.dart';
import 'package:dars_56_home/data/models/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DialogForProducts extends StatefulWidget {
  bool isAdd;
  Product? product;
  DialogForProducts({super.key,required this.isAdd,this.product});

  @override
  State<DialogForProducts> createState() => _DialogForProductsState();
}

class _DialogForProductsState extends State<DialogForProducts> {
  final _formKey = GlobalKey<FormState>();
  final _productTitle = TextEditingController();
  final _productPrice = TextEditingController();
  final _productImgUrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final productCubit = context.read<ProductCubit>();
    return AlertDialog(
      title: widget.isAdd ? const Text("Add Product") : const Text("Edit Product"),
      content: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                validator: (value){
                  if(value == null || value.isEmpty)
                    return "Please, return input product title";

                  return null;
                },
                controller: _productTitle,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  hintText: widget.isAdd ? "Product title" : "${widget.product!.title}",
                ),
              ),

              SizedBox(height: 20,),

              TextFormField(
                validator: (value){
                  if(value == null || value.isEmpty)
                    return "Please, return input product price";

                  try{
                    double.parse(value);
                    return null;
                  }catch(e){
                    return "Prduct price type not true";
                  }
                },
                controller: _productPrice,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  hintText: widget.isAdd ? "Product price" : widget.product!.imageUrl,
                ),
              ),
              SizedBox(height: 20,),

              TextFormField(
                validator: (value){
                  if(value == null || value.isEmpty)
                    return "Please, return input product img url";

                  if(value.endsWith('.jpeg') || value.endsWith('.jpg') || value.endsWith('.png')) {
                    return null;
                  }
                  return "Img format not true";
                },
                controller: _productImgUrl,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  hintText: widget.isAdd ? "Product img url" : widget.product!.imageUrl,
                ),
              )
            ],
          ),
        ),
      ),
      actions: [
        ElevatedButton(onPressed: (){
          Navigator.pop(context);
        }, child: Text("Bekor qilish"),),

        ElevatedButton(onPressed: (){
          if(_formKey.currentState!.validate()){
            if(widget.isAdd){
              productCubit.addProduct(Product(id: ''.toString(), title: _productTitle.text,price: double.parse(_productPrice.text), imageUrl: _productImgUrl.text, isFavorite: false),);
              Navigator.pop(context);
            }else{
              productCubit.editProduct(widget.product!.id, _productTitle.text, _productImgUrl.text);
              Navigator.pop(context);
            }
          }
        }, child: const Text("Save"),),
      ],
    );
  }
}
