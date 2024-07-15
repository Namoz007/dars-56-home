import 'package:dars_56_home/Utils/app_utils.dart';
import 'package:dars_56_home/cubits/cart_cubit.dart';
import 'package:dars_56_home/cubits/product_cubit.dart';
import 'package:dars_56_home/cubits/product_state.dart';
import 'package:dars_56_home/data/models/product.dart';
import 'package:dars_56_home/ui/screens/cart_screen.dart';
import 'package:dars_56_home/ui/widgets/custom_drawer.dart';
import 'package:dars_56_home/ui/widgets/dialog_for_products.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final productCubit = context.watch<ProductCubit>();
    final cartCubit = context.watch<CartCubit>();
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: const Text("Online shop"),
        centerTitle: true,
        actions: [
          IconButton(onPressed: (){
            showDialog(context: context, builder: (context) => DialogForProducts(isAdd: true));
          }, icon: const Icon(Icons.add),),
        ],
      ),
      body: BlocBuilder<ProductCubit,ProductState>(
        builder: (context,state){
          if(state is InitialState){
            return const Center(child: Text("Hozircha mahsulotlar mavjud emas"),);
          }

          if(state is LoadingState){
            return const Center(child: CircularProgressIndicator(color: Colors.red,),);
          }

          if(state is ErrorState){
            return const Center(child: Text("Kechirasiz malumot olishda xatolik kelib chiqdi"),);
          }

          final products = (state as LoadedState).products;
          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (context,index){
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                height: 150,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.grey),
                  image: DecorationImage(
                    image: NetworkImage(products[index].imageUrl),
                    fit: BoxFit.cover
                  ),
                ),
                alignment: Alignment.centerRight,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(onPressed: (){
                          productCubit.likeProduct(products[index].id);
                        }, icon: products[index].isFavorite ? const Icon(Icons.favorite,color: Colors.red,) : const Icon(Icons.favorite_border),),
                        IconButton(onPressed: (){
                          showDialog(context: context, builder: (context) => DialogForProducts(isAdd: false,product: products[index],));
                        }, icon: Icon(Icons.edit),),
                        IconButton(onPressed: (){
                          productCubit.deleteProduct(products[index].id);
                        }, icon: Icon(Icons.delete,color: Colors.red,),),
                     ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("\$${products[index].price}",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18),),
                        Text("${products[index].title}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: Colors.white),),
                        InkWell(
                          onTap: (){
                            cartCubit.addProduct(products[index]);
                          },
                          child: Icon(Icons.add_shopping_cart,size: 30,),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startDocked,
      floatingActionButton: InkWell(
        onTap: (){
          showModalBottomSheet(context: context, builder: (context) => CartScreen());
        },
        child: Container(
          height: 70,
          width: 70,
          decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.circular(15)
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Icon(Icons.shopping_cart,color: Colors.white,size: 40,),
              Padding(padding: EdgeInsets.only(left: 35,top: 35),child: Text(cartCubit.carts.length.toString(),style: TextStyle(fontWeight: FontWeight.bold,color: Colors.red,fontSize: 25),),)
            ],
          ),
        ),
      ),
    );
  }
}
