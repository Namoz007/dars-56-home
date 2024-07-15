import 'package:dars_56_home/cubits/cart_cubit.dart';
import 'package:dars_56_home/cubits/order_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final cartCubit = context.watch<CartCubit>();
    final orderCubit = context.read<OrderCubit>();
    return Container(
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Center(
            child: Container(
              height: 7,
              width: 70,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(25),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "Cart in Products count ${cartCubit.carts.length}",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900),
              ),
              cartCubit.carts.length != 0 ?InkWell(
                onTap: (){
                  orderCubit.addOrder(cartCubit.carts);
                  cartCubit.removeAllCart();
                },
                child: Text("Buy",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25,color: Colors.red),),
              ) : SizedBox(),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          cartCubit.carts.length == 0
              ? Center(
                  child: Text(
                    "Hozirda savatchada mahsulotlar mavjud emas!",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                )
              : Expanded(
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return Container(
                        width: double.infinity,
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        height: 150,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 150,
                              width: 150,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage("${cartCubit.carts[index].product.imageUrl}"),
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: BorderRadius.only(topLeft: Radius.circular(25),bottomLeft: Radius.circular(25))
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text("${cartCubit.carts[index].product.title}",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,),),
                                Row(
                                  children: [
                                    InkWell(
                                      onTap: (){
                                        cartCubit.addProductAmout(cartCubit.carts[index].product.id);
                                      },
                                      child: Icon(Icons.add_circle_outlined),
                                    ),
                                    Text(cartCubit.carts[index].amout.toString(),style: TextStyle(fontSize: 20),),
                                    InkWell(
                                      onTap: (){
                                        cartCubit.removeAmountProduct(cartCubit.carts[index].product.id);
                                      },
                                      child: Icon(Icons.remove_circle,),
                                    )
                                  ],
                                ),
                                Text("\$${cartCubit.carts[index].amout * cartCubit.carts[index].product.price}")
                              ],
                            ),
                            SizedBox()
                          ],
                        ),
                      );
                    },
                    itemCount: cartCubit.carts.length,
                  ),
                ),
        ],
      ),
    );
  }
}
