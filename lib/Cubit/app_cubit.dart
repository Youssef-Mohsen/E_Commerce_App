import 'package:dio/dio.dart';
import 'package:e_commerce/main.dart';
import 'package:e_commerce/models/product.dart';
import 'package:e_commerce/data/category_item_data.dart';
import 'package:e_commerce/models/category_item_model.dart';
import 'package:e_commerce/models/category_model.dart';
import 'package:e_commerce/screens/Item/item_details.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../data/category_data.dart';
import '../data/dark_mode.dart';
import '../screens/Category/categories.dart';
import '../screens/Item/item_info_screen.dart';
import '../screens/Item/items.dart';
import 'add_status.dart';
import 'package:flutter/material.dart';

class AppCubit extends Cubit<AddStates> {
  AppCubit() : super(InitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  //Attributes
  List<Product> filteredItems = [];
  List<Product> filteredItems2 = [];
  List<CategoryItemModel> filteredCategoryItems = [];
  List<CategoryModel> filterDrawer = categories;
  List<Product> cart = [];

  int selected = 0;
  int totalPrice = 0;
  bool isLoading = false;
  bool isNotLightMode = isDarkMode;

  //Methods
  void selectedCategory(BuildContext context, CategoryModel category) async {
    filteredCategoryItems = categoriesItems
        .where((item) => item.category == category.category)
        .toList();
    Navigator.of(context).push(MaterialPageRoute(
        builder: (ctx) => ItemScreen(title: category.category)));
  }

  void onSelectedItem(BuildContext context, CategoryItemModel catItem) async {
    counter = 0;
    isLoading = false;
    await getData2(catItem.category);
    filteredItems2 =
        filteredItems.where((item) => catItem.title == item.brand).toList();
    Navigator.of(context).push(MaterialPageRoute(
        builder: (ctx) => ItemInfoScreen(
              title: catItem.title,
              category: catItem.category,
            )));
    await Future.delayed(const Duration(seconds: 2));
    isLoading = true;
    emit(GetData());
  }

  void addToCart(Product product, BuildContext context) {
    bool exist = true;
    for (int i = 0; i < cart.length; i++) {
      if ((cart[i].title == product.title)) {
        exist = false;
      }
    }
    if (exist) {
      cart.add(product);
      totalPrice += product.price;
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar( SnackBar(
        backgroundColor: isDarkMode?Colors.orange:theme.onPrimaryContainer,
        duration: const Duration(seconds: 2),
        content: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "The Item Added",
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ));
      emit(AddData());
    } else {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar( SnackBar(
        backgroundColor: isDarkMode?Colors.orange:theme.onPrimaryContainer,
        duration: const Duration(seconds: 2),
        content: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "The Item Already Exist",
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ));
    }
  }

  void deleteCart(Product product) {
    cart.remove(product);
    totalPrice -= product.price;
    emit(DeleteItem());
  }

  void onSubmit(BuildContext context) {
    cart.clear();
    totalPrice = 0;
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (ctx) => const MyHomePage()));
    emit(DeleteData());
  }

  onPressYes(BuildContext context) async {
    showDialog(
      context: context,
      builder: (BuildContext context) =>  Center(
        child: SpinKitThreeBounce(
          color: isDarkMode?Colors.white:theme.onPrimaryContainer,
          size: 50.0,
          duration: const Duration(seconds: 2),
        ),
      ),
    );
    await Future.delayed(const Duration(seconds: 2));
    showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
                backgroundColor: isDarkMode?Colors.orange:theme.onPrimaryContainer,
                title: const Text(
                  "Wonderful!",
                  style: TextStyle(color: Colors.white, fontSize: 19),
                  textAlign: TextAlign.center,
                ),
                content: const Text(
                  "Your Order is Submitted Successfully",
                  style: TextStyle(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                actions: [
                  TextButton(
                      onPressed: () {
                        onSubmit(context);
                      },
                      child: const Text(
                        'OK',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ))
                ]));
  }

  void toDetails(BuildContext context, Product product) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (ctx) => ItemDetailScreen(
              product: product,
            )));
    emit(UpdateData());
  }

  void onFilter(BuildContext context, String category) {
    selected = 0;
    categories =
        filterDrawer.where((item) => item.category == category).toList();
    Navigator.of(context).pop();
    emit(UpdateData());
  }

  void onAll(BuildContext context) {
    selected = 0;
    categories = filterDrawer;
    Navigator.of(context).pop();
    emit(UpdateData());
  }

  //Api//////////////////////////////////////////
  final Dio dio = Dio();
  List<Product> productsList = [];

  Future<List> getProducts() async {
    Response response = await dio.get("https://dummyjson.com/products");
    emit(GetData());
    return response.data["products"];
  }

  List<Product> convertToProducts(List products) {
    for (var product in products) {
      if (product["images"] == null ||
          product["title"] == null ||
          product["price"] == null) {
        continue;
      }
      productsList.add(Product(
          images: product["images"],
          price: product["price"],
          title: product["title"],
          brand: product["brand"],
          rating: product["rating"],
          category: product["category"],
          stock: product["stock"],
          description: product["description"],
          discountPercentage: product["discountPercentage"],
          id: product["id"],
          thumbnail: product["thumbnail"]));
    }
    return productsList;
  }

  Future<void> getData() async {
    List products2List = await getProducts();
    productsList = convertToProducts(products2List);
    emit(AddData());
  }

  Future<List> getCategories(String category) async {
    late Response response;
    try {
      response =
          await dio.get("https://dummyjson.com/products/category/$category");
      emit(GetData());
    } catch (e) {
      print(e);
    }
    return response.data["products"];
  }

  static int counter = 0;

  List<Product> convertToCategories(List categories) {
    bool exist = false;
    for (var category in categories) {
      if (category["images"] == null || category["category"] == null) {
        continue;
      }
      if (counter == 0) {
        filteredItems.clear();
        exist = true;
        counter++;
      }

      if (exist) {
        filteredItems.add(Product(
            images: category["images"],
            price: category["price"],
            title: category["title"],
            brand: category["brand"],
            rating: category["rating"],
            category: category["category"],
            stock: category["stock"],
            description: category["description"],
            discountPercentage: category["discountPercentage"],
            id: category["id"],
            thumbnail: category["thumbnail"]));
      }
    }
    return filteredItems;
  }

  Future<void> getData2(String category) async {
    List products2List = await getCategories(category);
    filteredItems = convertToCategories(products2List);
    emit(AddData());
  }

  void darkMode() {
    isDarkMode = !isDarkMode;
    emit(UpdateData());
  }
}
