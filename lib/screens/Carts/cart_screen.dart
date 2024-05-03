import 'package:e_commerce/Cubit/add_status.dart';
import 'package:e_commerce/Cubit/app_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import '../../data/dark_mode.dart';
import '../../main.dart';
import '../Category/categories.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    AppCubit cubit = AppCubit.get(context);
    cubit.selected = 1;
    return BlocBuilder<AppCubit, AddStates>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Carts',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            centerTitle: true,
          ),
          bottomNavigationBar: BottomNavigationBar(
            elevation: 50,
            currentIndex: cubit.selected,
            onTap: (index) {
              cubit.selected = index;
              if (cubit.selected == 1) {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => const CartScreen()));
                cubit.selected = 0;
              } else {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => const MyHomePage()));
              }
            },
            items: const [
              BottomNavigationBarItem(label: "Home", icon: Icon(Icons.home)),
              BottomNavigationBarItem(
                  label: "Cart", icon: Icon(Icons.shopping_cart)),
            ],
          ),
          body: ConditionalBuilder(
            condition: cubit.cart.isNotEmpty,
            builder: (context) {
              return Column(
                children: [
                  SizedBox(
                    height: 577,
                    child: ListView.separated(
                        itemBuilder: (context, index) => Dismissible(
                              key: Key(cubit.cart[index].id.toString()),
                              onDismissed: (direction) {
                                cubit.deleteCart(cubit.cart[index]);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 60,
                                      backgroundColor: isDarkMode?Colors.orange:theme.onPrimaryContainer,
                                      backgroundImage: NetworkImage(
                                          cubit.cart[index].images[0]),
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Expanded(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            cubit.cart[index].title,
                                            style:  TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: isDarkMode?Colors.white:Colors.black),
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                cubit.cart[index].price
                                                    .toString(),
                                                style: const TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.grey),
                                              ),
                                              const Text(
                                                "\$",
                                                style: TextStyle(
                                                    color: Colors.grey),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                        separatorBuilder: (context, index) => Container(
                              color: Colors.grey,
                              height: 1,
                              width: 500,
                            ),
                        itemCount: cubit.cart.length),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Total Price: ',
                        style: TextStyle(color: Colors.white),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            cubit.totalPrice.toString(),
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          const Text(
                            '\$',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                                backgroundColor: isDarkMode?Colors.orange:theme.onPrimaryContainer,
                                title: Text(
                                  "You Will Pay ${cubit.totalPrice} \$",
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 19),
                                  textAlign: TextAlign.center,
                                ),
                                content: const Text(
                                  "Are You Submit It?",
                                  style: TextStyle(color: Colors.white),
                                  textAlign: TextAlign.center,
                                ),
                                actions: [
                                  Row(
                                    children: [
                                      TextButton(
                                        onPressed: () {
                                          cubit.onPressYes(context);
                                        },
                                        child: const Text(
                                          'Yes',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                      const Spacer(),
                                      TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text(
                                            'No',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ))
                                    ],
                                  )
                                ],
                              ));
                    },
                    child: const Text(
                      "CheckOut",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                  )
                ],
              );
            },
            fallback: (context) {
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.shopping_cart,
                      color: Colors.grey,
                      size: 70,
                    ),
                    Text(
                      "No Items Yet",
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),
                    )
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
