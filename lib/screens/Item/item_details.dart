import 'package:flutter/material.dart';
import 'package:e_commerce/models/product.dart';

import '../../Cubit/app_cubit.dart';
import '../Carts/cart_screen.dart';
import '../Category/categories.dart';

class ItemDetailScreen extends StatefulWidget {
  const ItemDetailScreen({super.key, required this.product});

  final Product product;

  @override
  State<ItemDetailScreen> createState() => _ItemDetailScreenState();
}

class _ItemDetailScreenState extends State<ItemDetailScreen> {
  @override
  Widget build(BuildContext context) {
    AppCubit cubit = AppCubit.get(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product.title),
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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image(
              image: NetworkImage(widget.product.images[0]),
              height: 300,
              fit: BoxFit.cover,
            ),
            const SizedBox(
              height: 10,
            ),
            Text('Description',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold)),
            const SizedBox(
              height: 5,
            ),
            Text(widget.product.description,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground)),
            const SizedBox(
              height: 10,
            ),
            Text('Rating:',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold)),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(widget.product.rating.toString(),
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground)),
                const SizedBox(
                  width: 2,
                ),
                const Icon(
                  Icons.star,
                  color: Colors.yellow,
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Text('Stock:',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold)),
            const SizedBox(
              height: 5,
            ),
            Text(widget.product.stock.toString(),
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground)),
            const SizedBox(
              height: 50,
            ),
            ElevatedButton(
              onPressed: () {
                cubit.addToCart(widget.product, context);
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Add To Cart',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold)),
                  SizedBox(
                    width: 20,
                  ),
                  Icon(
                    Icons.shopping_cart,
                    color: Colors.white,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
