import 'package:flutter/material.dart';
import 'package:groceries_n_you/myWidgets/my_popup_product.dart';
import 'package:groceries_n_you/custom_widget_functions.dart';
import 'package:groceries_n_you/dimensions.dart';

import '../models/product_model.dart';

class MyProductWidget extends StatelessWidget {
  final ProductModel product;
  final bool view;

  const MyProductWidget({Key? key, required this.product, required this.view}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: view
          ? EdgeInsets.only(
              left: Dimensions.width50 / 2,
              right: Dimensions.width50 / 2,
              top: Dimensions.height10,
              bottom: Dimensions.height10,
            )
          : EdgeInsets.symmetric(
              horizontal: Dimensions.width20,
              vertical: Dimensions.height10,
            ),
      width: view ? Dimensions.width145 : MediaQuery.of(context).size.width,
      height: view ? Dimensions.height315 : Dimensions.height130,
      child: GestureDetector(
        onLongPress: () {
          showGeneralDialog(
            barrierDismissible: true,
            barrierLabel: 'Barrier',
            barrierColor: Colors.black.withOpacity(0.75),
            context: context,
            pageBuilder: (context, __, ___) {
              return MyPopupProductWidget(product: product);
            },
          );
        },
        child: view
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: CustomWidgets.isPromotionGrid(
                  product: product,
                  quantity: 1,
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: CustomWidgets.isPromotionList(
                  product: product,
                  quantity: 1,
                ),
              ),
      ),
    );
  }
}
