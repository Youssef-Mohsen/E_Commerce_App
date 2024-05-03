import 'package:e_commerce/Cubit/add_status.dart';
import 'package:e_commerce/Cubit/app_cubit.dart';
import 'package:e_commerce/data/category_item_data.dart';
import 'package:e_commerce/models/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ItemGrid extends StatefulWidget {
  const ItemGrid({super.key, required this.item});

  final Product item;

  @override
  State<ItemGrid> createState() => _ItemGridState();
}

class _ItemGridState extends State<ItemGrid> {
  @override
  Widget build(BuildContext context) {
    AppCubit cubit = AppCubit.get(context);
    return BlocBuilder<AppCubit, AddStates>(
      builder: (context, state) {
        return Column(
          children: [
            InkWell(
              onTap: () {
                cubit.toDetails(context, widget.item);
              },
              child: Image(
                image: NetworkImage(widget.item.images[0]),
                height: 250,
                width: 200,
                fit: BoxFit.cover,
              ),
            ),
            Text(
              widget.item.title,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Price: ',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12),
                ),
                const SizedBox(
                  width: 2,
                ),
                Text(
                  widget.item.price.toString(),
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                ),
                const SizedBox(
                  width: 2,
                ),
                const Text(
                  "\$",
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
                const SizedBox(
                  width: 10,
                ),
                const Text(
                  "Available",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                cubit.addToCart(widget.item, context);
              },
              child: const Row(
                children: [
                  Text('Add To Cart',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold)),
                  SizedBox(
                    width: 10,
                  ),
                  Icon(
                    Icons.shopping_cart,
                    color: Colors.white,
                  )
                ],
              ),
            )
          ],
        );
      },
    );
  }
}
