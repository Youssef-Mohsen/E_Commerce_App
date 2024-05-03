import 'package:e_commerce/Cubit/add_status.dart';
import 'package:e_commerce/models/category_item_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../Cubit/app_cubit.dart';

class CategoryItem extends StatefulWidget {
  const CategoryItem({super.key, required this.catItem});

  final CategoryItemModel catItem;

  @override
  State<CategoryItem> createState() => _CategoryItemState();
}

class _CategoryItemState extends State<CategoryItem> {
  @override
  Widget build(BuildContext context) {
    AppCubit cubit = AppCubit.get(context);
    return BlocBuilder<AppCubit, AddStates>(
      builder: (context, dynamic state) {
        return Card(
          margin: const EdgeInsets.all(8),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          clipBehavior: Clip.hardEdge,
          elevation: 2,
          child: InkWell(
            onTap: () {
              cubit.onSelectedItem(context, widget.catItem);
            },
            child: Stack(
              children: [
                FadeInImage(
                  placeholder: MemoryImage(kTransparentImage),
                  image: NetworkImage(widget.catItem.imageUrl),
                  fit: BoxFit.cover,
                  height: 210,
                  width: double.infinity,
                ),
                Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: InkWell(
                      onTap: () {
                        cubit.onSelectedItem(context, widget.catItem);
                      },
                      child: Container(
                        color: Colors.black54,
                        height: 72,
                        padding: const EdgeInsets.symmetric(
                            vertical: 6, horizontal: 44),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              widget.catItem.title,
                              maxLines: 2,
                              textAlign: TextAlign.center,
                              softWrap: true,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.work,
                                  size: 18,
                                  color: Colors.white,
                                ),
                                const SizedBox(
                                  width: 12,
                                ),
                                Text(
                                  widget.catItem.complexity,
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                const Icon(
                                  Icons.attach_money,
                                  size: 18,
                                  color: Colors.white,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  widget.catItem.affordable,
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 16),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ))
              ],
            ),
          ),
        );
      },
    );
  }
}
