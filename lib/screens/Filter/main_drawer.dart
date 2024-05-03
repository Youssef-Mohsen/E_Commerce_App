import 'package:flutter/material.dart';

import '../../Cubit/app_cubit.dart';
import '../../data/dark_mode.dart';
import '../../main.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    AppCubit cubit = AppCubit.get(context);
    return Drawer(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Column(
        children: [
          DrawerHeader(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: LinearGradient(colors: [
                    isDarkMode
                        ? Colors.orange.withOpacity(0.55)
                        : theme.onPrimaryContainer.withOpacity(0.55),
                    isDarkMode
                        ? Colors.orange.withOpacity(0.9)
                        : theme.onPrimaryContainer.withOpacity(0.9),
                  ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
              child: Row(
                children: [
                  const Icon(
                    Icons.filter_list_alt,
                    size: 48,
                    color: Colors.white,
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  Text(
                    'Filters',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(color: Colors.white),
                  )
                ],
              )),
          ListTile(
            leading: Icon(
              Icons.phone_android,
              size: 26,
              color: Theme.of(context).colorScheme.onBackground,
            ),
            title: Text(
              "Smart Phones",
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                  fontSize: 24),
            ),
            onTap: () {
              cubit.onFilter(context, "smartphones");
            },
          ),
          const SizedBox(
            height: 5,
          ),
          ListTile(
            leading: Icon(
              Icons.laptop,
              size: 26,
              color: Theme.of(context).colorScheme.onBackground,
            ),
            title: Text(
              "Laptops",
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                  fontSize: 24),
            ),
            onTap: () {
              cubit.onFilter(context, "laptops");
            },
          ),
          const SizedBox(
            height: 5,
          ),
          ListTile(
            leading: Icon(
              Icons.cleaning_services,
              size: 26,
              color: Theme.of(context).colorScheme.onBackground,
            ),
            title: Text(
              "Fragrances",
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                  fontSize: 24),
            ),
            onTap: () {
              cubit.onFilter(context, "fragrances");
            },
          ),
          const SizedBox(
            height: 5,
          ),
          ListTile(
            leading: Icon(
              Icons.cleaning_services,
              size: 26,
              color: Theme.of(context).colorScheme.onBackground,
            ),
            title: Text(
              "Skin Care",
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                  fontSize: 24),
            ),
            onTap: () {
              cubit.onFilter(context, "skincare");
            },
          ),
          const SizedBox(
            height: 5,
          ),
          ListTile(
            leading: Icon(
              Icons.food_bank,
              size: 26,
              color: Theme.of(context).colorScheme.onBackground,
            ),
            title: Text(
              "Groceries",
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                  fontSize: 24),
            ),
            onTap: () {
              cubit.onFilter(context, "groceries");
            },
          ),
          const SizedBox(
            height: 5,
          ),
          ListTile(
            leading: Icon(
              Icons.shopping_basket_rounded,
              size: 26,
              color: Theme.of(context).colorScheme.onBackground,
            ),
            title: Text(
              "All",
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                  fontSize: 24),
            ),
            onTap: () {
              cubit.onAll(context);
            },
          )
        ],
      ),
    );
  }
}
