import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:groceries_n_you/constants/routes.dart';
import 'package:groceries_n_you/dimensions.dart';
import 'package:groceries_n_you/homePage/scrolling_offers.dart';
import 'package:groceries_n_you/models/category_model.dart';

import '../blocs/blocs.dart';
import '../myWidgets/widgets.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: homeRoute),
      builder: (context) => const HomePage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(),
      drawer: const MyDrawer(),
      floatingActionButton: const MyFloatingButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      bottomNavigationBar: const MyBottomNavbar(),
      body: Column(
        children: [
          SizedBox(height: Dimensions.height15),
          const ScrollingOffers(),
          SizedBox(height: Dimensions.height10),
          BlocBuilder<CategoryBloc, CategoryState>(
            builder: (context, state) {
              if (state is CategoryLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is CategoryLoaded) {
                return CategoryCarousel(categories: state.categories);
              } else {
                return const Text('Something went wrong!');
              }
            },
          ),
        ],
      ),
    );
  }
}

class CategoryCarousel extends StatelessWidget {
  final List<CategoryModel> categories;
  const CategoryCarousel({
    Key? key,
    required this.categories,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: Dimensions.height10),
      height: Dimensions.height50 * 2,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return CategoryCard(category: categories[index]);
        },
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final CategoryModel category;

  const CategoryCard({
    Key? key,
    required this.category,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamedAndRemoveUntil(
          categoryRoute,
          (route) => true,
          arguments: category,
        );
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: Dimensions.width15),
        child: Column(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(category.image),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(Dimensions.border5),
                ),
                width: Dimensions.width80,
              ),
            ),
            SizedBox(height: Dimensions.height5),
            Text(
              category.name.toUpperCase(),
              style: TextStyle(
                fontSize: Dimensions.font12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
