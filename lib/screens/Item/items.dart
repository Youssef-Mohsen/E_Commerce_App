import 'package:e_commerce/Cubit/add_status.dart';
import 'package:e_commerce/Cubit/app_cubit.dart';
import 'package:e_commerce/models/category_item_model.dart';

import 'package:e_commerce/screens/Cat_Item/cat_item.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/product.dart';
import '../Carts/cart_screen.dart';
import '../Category/categories.dart';

class ItemScreen extends StatefulWidget {
  const ItemScreen({
    super.key,
    required this.title,
  });

  final String title;

  @override
  State<ItemScreen> createState() => _ItemScreenState();
}

class _ItemScreenState extends State<ItemScreen> {
  @override
  Widget build(BuildContext context) {
    AppCubit cubit = AppCubit.get(context);
    cubit.selected = 0;
    return BlocBuilder<AppCubit, AddStates>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              widget.title.substring(0,1).toUpperCase()+widget.title.substring(1),
            ),
          ),
          body: ListView.builder(
              itemCount: cubit.filteredCategoryItems.length,
              itemBuilder: (ctx, index) => CategoryItem(
                    catItem: cubit.filteredCategoryItems[index],
                  )),
        );
      },
    );
  }
}
