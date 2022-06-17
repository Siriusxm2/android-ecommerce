import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gny_backend/models/product_model.dart';
import 'package:gny_backend/screens/new_product_page.dart';

import '../../dimensions.dart';
import '../controllers/product_controller.dart';

class ProductsPage extends StatelessWidget {
  ProductsPage({Key? key}) : super(key: key);

  final ProductController productController = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Products')),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Dimensions.width10,
          vertical: Dimensions.height10,
        ),
        child: Column(
          children: [
            InkWell(
              onTap: () {
                Get.to(() => NewProductPage());
              },
              child: SizedBox(
                height: Dimensions.height50 * 2,
                child: Card(
                  margin: EdgeInsets.zero,
                  color: const Color(0xff8EB4FF),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(Dimensions.border5),
                    side: BorderSide(
                      width: Dimensions.width8 / 4,
                      color: const Color(0xffFFAE2D),
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: Dimensions.width10),
                        child: const Icon(
                          Icons.add_circle,
                          color: Color(0xffFFAE2D),
                        ),
                      ),
                      Text(
                        'Add new product',
                        style: TextStyle(
                          color: const Color(0xff333333),
                          fontSize: Dimensions.font16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Obx(
                () => ListView.builder(
                  itemCount: productController.products.length,
                  itemBuilder: (context, index) {
                    return SizedBox(
                      height: Dimensions.height200 + Dimensions.height20,
                      child: ProductCard(
                        product: productController.products[index],
                        index: index,
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final ProductModel product;
  final int index;
  final ProductController productController = Get.find();

  ProductCard({
    Key? key,
    required this.product,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(top: 10),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              product.name,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              product.manu,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                SizedBox(
                  height: 120,
                  width: 120,
                  child: Image.network(
                    product.picture,
                    fit: BoxFit.cover,
                  ),
                ),
                Column(
                  children: [
                    Row(
                      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const SizedBox(width: 10),
                            const Text('Sale'),
                            Checkbox(
                              value: product.isOnSale,
                              onChanged: (value) {
                                productController.updateProductIsSale(
                                  index,
                                  product,
                                  value!,
                                );
                                productController.saveNewProductIsSale(
                                  product,
                                  'is_sale',
                                  value,
                                );
                              },
                            ),
                          ],
                        ),
                        const SizedBox(width: 30),
                        Row(
                          children: [
                            const Text('Sale Amount'),
                            const SizedBox(width: 10),
                            SizedBox(
                              height: 20,
                              width: 25,
                              child: TextFormField(
                                textAlign: TextAlign.center,
                                initialValue: product.saleAmount.toString(),
                                onChanged: (value) {
                                  productController.updateProductSaleAmount(
                                    index,
                                    product,
                                    value == '' ? 0 : int.parse(value),
                                  );
                                },
                                onFieldSubmitted: (value) {
                                  productController.saveNewProductSaleAmount(
                                    product,
                                    'sale_amount',
                                    value == '' ? 0 : int.parse(value),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Row(
                          children: [
                            const Text('Price'),
                            const SizedBox(width: 10),
                            SizedBox(
                              height: 20,
                              width: 40,
                              child: TextFormField(
                                textAlign: TextAlign.center,
                                initialValue: product.price.toString(),
                                onChanged: (value) {
                                  productController.updateProductPrice(
                                    index,
                                    product,
                                    value == '' ? 0 : double.parse(value),
                                  );
                                },
                                onFieldSubmitted: (value) {
                                  productController.saveNewProductPrice(
                                    product,
                                    'product_price',
                                    value == '' ? 0.0 : double.parse(value),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 30),
                        Row(
                          children: [
                            const Text('In Storage'),
                            const SizedBox(width: 10),
                            SizedBox(
                              height: 20,
                              width: 25,
                              child: TextFormField(
                                textAlign: TextAlign.center,
                                initialValue: product.inStorage.toString(),
                                onChanged: (value) {
                                  productController.updateProductInStorage(
                                    index,
                                    product,
                                    value == '' ? 0 : int.parse(value),
                                  );
                                },
                                onFieldSubmitted: (value) {
                                  productController.saveNewProductInStorage(
                                    product,
                                    'in_storage',
                                    value == '' ? 0 : int.parse(value),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
