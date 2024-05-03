import 'package:e_commerce/Cubit/add_status.dart';
import 'package:e_commerce/Cubit/app_cubit.dart';
import 'package:e_commerce/screens/Item/item_grid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../data/dark_mode.dart';
import '../../main.dart';
import '../Carts/cart_screen.dart';
import '../Category/categories.dart';

class ItemInfoScreen extends StatefulWidget {
  const ItemInfoScreen({
    super.key,
    required this.category,
    required this.title,
  });

  final String category;
  final String title;

  @override
  State<ItemInfoScreen> createState() => _ItemInfoScreenState();
}

class _ItemInfoScreenState extends State<ItemInfoScreen> {
  @override
  Widget build(BuildContext context) {
    AppCubit cubit = AppCubit.get(context);
    cubit.selected = 0;
    return BlocBuilder<AppCubit, AddStates>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              widget.title,
              style: const TextStyle(color: Colors.white, fontSize: 18),
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
          body: cubit.isLoading
              ? GridView(
                  padding: const EdgeInsets.all(24),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.4,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                  ),
                  children: [
                    for (final item in cubit.filteredItems2)
                      ItemGrid(item: item)
                  ],
                )
              : Center(
                  child: SpinKitThreeBounce(
                    color: isDarkMode ? Colors.white : theme.onPrimaryContainer,
                    size: 50.0,
                    duration: const Duration(seconds: 2),
                  ),
                ),
        );
      },
    );
  }
}
