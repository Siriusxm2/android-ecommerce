import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gny_backend/models/product_model.dart';
import 'package:gny_backend/services/database_service.dart';
import 'package:gny_backend/services/storage_serivce.dart';
import 'package:image_picker/image_picker.dart';

import '../../dimensions.dart';
import '../controllers/product_controller.dart';

class NewProductPage extends StatelessWidget {
  final ProductController productController = Get.find();

  NewProductPage({Key? key}) : super(key: key);

  StorageService storage = StorageService();
  DatabaseService database = DatabaseService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Product')),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Dimensions.width10,
          vertical: Dimensions.height10,
        ),
        child: Obx(
          () => SingleChildScrollView(
            child: Column(
              children: [
                InkWell(
                  onTap: () async {
                    ImagePicker picker = ImagePicker();
                    final XFile? image =
                        await picker.pickImage(source: ImageSource.gallery);

                    if (image == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('No Image was selected.'),
                        ),
                      );
                    }

                    if (image != null) {
                      await storage.uploadImage(image);
                      var imageUrl = await storage.getDownloadURL(image.name);

                      productController.newProduct.update(
                          'product_image', (_) => imageUrl,
                          ifAbsent: () => imageUrl);
                    }
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
                            'Add an Image',
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
                const SizedBox(height: 20),
                Text(
                  'Product Information',
                  style: TextStyle(
                    color: const Color(0xff333333),
                    fontSize: Dimensions.font16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                _customTextFormField(
                  'ID',
                  'id',
                  productController,
                ),
                _customTextFormField(
                  'Product Name',
                  'name',
                  productController,
                ),
                _customTextFormField(
                  'Product Manufacturer',
                  'manu',
                  productController,
                ),
                _customTextFormField(
                  'Product Price',
                  'product_price',
                  productController,
                ),
                _customTextFormField(
                  'Product In Storage',
                  'in_storage',
                  productController,
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _customCheckbox(
                      'Sale',
                      'is_sale',
                      productController,
                      productController.isSale,
                    ),
                    Row(
                      children: [
                        const Text('Sale Amount'),
                        const SizedBox(width: 10),
                        SizedBox(
                          height: 20,
                          width: 30,
                          child: TextFormField(
                            textAlign: TextAlign.center,
                            onChanged: (value) {
                              productController.newProduct.update(
                                'sale_amount',
                                (_) => value,
                                ifAbsent: () => value,
                              );
                            },
                          ),
                        ),
                        const Text('%'),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    database.addProduct(
                      ProductModel(
                        id: int.parse(productController.newProduct['id']),
                        name: productController.newProduct['name'],
                        manu: productController.newProduct['manu'],
                        picture: productController.newProduct['product_image'],
                        price: double.parse(
                            productController.newProduct['product_price']),
                        isOnSale: productController.newProduct['is_sale'],
                        saleAmount: int.parse(
                            productController.newProduct['sale_amount']),
                        inStorage: int.parse(
                            productController.newProduct['in_storage']),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    primary: const Color(0xff8EB4FF),
                    side: const BorderSide(
                      color: Color(0xffFFAE2D),
                    ),
                  ),
                  child: const Text(
                    'Save',
                    style: TextStyle(
                      color: Color(0xff333333),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row _customCheckbox(
    String label,
    String name,
    ProductController productController,
    bool? controllerValue,
  ) {
    return Row(
      children: [
        const Text('Sale'),
        Checkbox(
          value: (controllerValue == null) ? false : controllerValue,
          onChanged: (value) {
            productController.newProduct.update(
              name,
              (_) => value,
              ifAbsent: () => value,
            );
          },
          activeColor: const Color(0xffFFBE57),
        ),
      ],
    );
  }

  TextFormField _customTextFormField(
    String text,
    String name,
    ProductController productController,
  ) {
    return TextFormField(
      decoration: InputDecoration(
        hintText: text,
      ),
      onChanged: (value) {
        productController.newProduct.update(
          name,
          (_) => value,
          ifAbsent: () => value,
        );
      },
    );
  }
}
