import 'package:dars_56_home/cubits/order_cubit.dart';
import 'package:dars_56_home/data/models/order.dart';
import 'package:dars_56_home/ui/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderedScreen extends StatefulWidget {
  const OrderedScreen({super.key});

  @override
  State<OrderedScreen> createState() => _OrderedScreenState();
}

class _OrderedScreenState extends State<OrderedScreen> {
  @override
  Widget build(BuildContext context) {
    final orderedCubit = context.watch<OrderCubit>();
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: Text("Ordered Screen"),
        centerTitle: true,
      ),
      body: orderedCubit.orders.length == 0
          ? Center(
              child: Text("Hozirda buyurtma qilingan mahsulotlar mavjud emas"),
            )
          : ListView.builder(
            itemCount: orderedCubit.orders.length,
            itemBuilder: (context, index) {
              Order order = orderedCubit.orders[index];
              return Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(25)
                ),
                margin: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Prduct img"),
                        Text("Name"),
                        Text("Price"),
                        Text("Count")
                      ],
                    ),
                    SizedBox(height: 10,),
                    for(int i = 0; i < order.carts.length;i++)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 70,
                            width: 70,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage("${order.carts[i].product.imageUrl}"),
                                fit: BoxFit.cover
                              )
                            ),
                          ),
                          
                          Text("${order.carts[i].product.title}"),
                          Text("\$${order.carts[i].product.price}"),
                          Text("${order.carts[i].amout}"),
                        ],
                      ),

                    SizedBox(height: 20,),

                    Center(child: Text("Total price \$${order.price}",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),)
                  ],
                ),
              );
            },
          ),
    );
  }
}
