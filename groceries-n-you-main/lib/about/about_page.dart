import 'package:flutter/material.dart';
import 'package:groceries_n_you/dimensions.dart';

import '../myWidgets/widgets.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBarHeader(label: 'About Us'),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: Dimensions.height35),
          Container(
            margin: EdgeInsets.only(left: Dimensions.width30),
            height: Dimensions.height16,
            child: Text(
              "For Groceries'N'You",
              textAlign: TextAlign.left,
              style: TextStyle(
                color: const Color(0xff699BFF),
                fontSize: Dimensions.font16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          SizedBox(height: Dimensions.height18),
          Center(
            child: SizedBox(
              height: Dimensions.height56,
              width: Dimensions.width300,
              child: Text(
                "Ние от Groceries’N’You целим да предоставим бързо и улеснено пазаруване на всички. Предлагаме възможност за осигуряване на повече свободно време за Вас и Вашите близки.",
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: Dimensions.font12),
              ),
            ),
          ),
          SizedBox(height: Dimensions.height8),
          Center(
            child: SizedBox(
              height: Dimensions.height42,
              width: Dimensions.width300,
              child: Text(
                "Гарантираме качество на доставката и възможност за връщане на продукти при лошо състояние или при липса при доставка.",
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: Dimensions.font12),
              ),
            ),
          ),
          SizedBox(height: Dimensions.height8),
          Center(
            child: SizedBox(
              height: Dimensions.height56,
              width: Dimensions.width300,
              child: Text(
                "Гарантираме качество на доставката и възможност за връщане на продукти при лошо състояние или при липса при доставка.",
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: Dimensions.font12),
              ),
            ),
          ),
          SizedBox(height: Dimensions.height8),
          Center(
            child: SizedBox(
              height: Dimensions.height42,
              width: Dimensions.width300,
              child: Text(
                "Гарантираме качество на доставката и възможност за връщане на продукти при лошо състояние или при липса при доставка.",
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: Dimensions.font12),
              ),
            ),
          ),
          SizedBox(height: Dimensions.height20),
          Divider(
            indent: Dimensions.width10,
            endIndent: Dimensions.width10,
            thickness: 1,
            color: const Color(0xffcccccc),
          ),
        ],
      ),
      drawer: const MyDrawer(),
      persistentFooterButtons: [
        Center(
          child: SizedBox(
            width: Dimensions.width320,
            height: Dimensions.height32,
            child: Text(
              "Уебсайтът groceriesnyou.bg е собственост на Ритейл Квартирката АД, БУЛСТАТ 420420420.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: Dimensions.font10,
                color: const Color(0xff999999),
              ),
            ),
          ),
        ),
      ],
      floatingActionButton: const MyFloatingButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      bottomNavigationBar: const MyBottomNavbar(),
    );
  }
}
