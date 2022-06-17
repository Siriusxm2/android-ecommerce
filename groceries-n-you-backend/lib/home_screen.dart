import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gny_backend/dimensions.dart';
import 'package:gny_backend/screens/products_page.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GnY Backend'),
      ),
      body: SizedBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: double.infinity,
              height: Dimensions.height150,
              padding: EdgeInsets.symmetric(horizontal: Dimensions.width10),
              child: InkWell(
                onTap: () {
                  Get.to(() => ProductsPage());
                },
                child: const Card(
                  child: Center(
                    child: Text('Go To Products'),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
