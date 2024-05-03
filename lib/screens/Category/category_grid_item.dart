import 'package:e_commerce/Cubit/add_status.dart';
import 'package:e_commerce/Cubit/app_cubit.dart';
import 'package:e_commerce/models/category_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/dark_mode.dart';
import '../../main.dart';

class CategoryGridItem extends StatefulWidget {
  const CategoryGridItem({super.key, required this.category});

  final CategoryModel category;

  @override
  State<CategoryGridItem> createState() => _CategoryGridItemState();
}

class _CategoryGridItemState extends State<CategoryGridItem> {
  @override
  void initState() {
    while (widget.category.imageUrl==null) {
      showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
                  backgroundColor:
                      isDarkMode ? Colors.orange : theme.onPrimaryContainer,
                  title: const Text(
                    "Connection Error!",
                    style: TextStyle(color: Colors.white, fontSize: 19),
                    textAlign: TextAlign.center,
                  ),
                  content: const Text(
                    "Unable to connect with the server. Check your Internet connection and try again.",
                    style: TextStyle(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                  actions: [
                    TextButton(
                        onPressed: () {
                          if (widget.category.imageUrl!=null) {
                            Navigator.pop(context);
                          }
                        },
                        child: const Text(
                          'Try again',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ))
                  ]));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppCubit cubit = AppCubit.get(context);
    return BlocBuilder<AppCubit, AddStates>(
      builder: (context, state) {
        return InkWell(
          onTap: () {
            cubit.selectedCategory(context, widget.category);
          },
          splashColor: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: isDarkMode ? Colors.orange : theme.onPrimaryContainer),
            child: Column(
              children: [
                Text(
                  widget.category.category.substring(0, 1).toUpperCase() +
                      widget.category.category.substring(1),
                  maxLines: 1,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Colors.white,
                      ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Image(
                  image: NetworkImage(widget.category.imageUrl),
                  height: 85,
                  width: 400,
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
