import 'package:flutter/material.dart';
import 'package:groceries_n_you/dimensions.dart';
import 'package:groceries_n_you/models/product_model.dart';
import 'package:pay/pay.dart';

class GooglePay extends StatelessWidget {
  final List<ProductModel> products;
  final num total;

  const GooglePay({
    Key? key,
    required this.total,
    required this.products,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _paymentItems = products
        .map(
          (product) => PaymentItem(
            label: product.name,
            amount: product.price.toStringAsFixed(2),
            type: PaymentItemType.item,
            status: PaymentItemStatus.final_price,
          ),
        )
        .toList();

    _paymentItems.add(
      PaymentItem(
        label: 'Total',
        amount: total.toStringAsFixed(2),
        type: PaymentItemType.total,
        status: PaymentItemStatus.final_price,
      ),
    );

    void onGooglePayResults(paymentResult) {
      debugPrint(paymentResult.toString());
    }

    return SizedBox(
      width: MediaQuery.of(context).size.width - Dimensions.width50,
      child: GooglePayButton(
        paymentConfigurationAsset: 'default_payment_profile_google_pay.json',
        onPaymentResult: onGooglePayResults,
        paymentItems: _paymentItems,
        style: GooglePayButtonStyle.flat,
        type: GooglePayButtonType.pay,
        margin: EdgeInsets.only(top: Dimensions.height10),
        loadingIndicator: const CircularProgressIndicator(),
      ),
    );
  }
}
