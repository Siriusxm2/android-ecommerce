import 'package:flutter/material.dart';
import 'package:groceries_n_you/dimensions.dart';

import '../myWidgets/widgets.dart';

class ContactsPage extends StatelessWidget {
  const ContactsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBarHeader(label: 'Contacts'),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // GOOGLE MAPS
            Container(
              height: Dimensions.height260,
              child: const MyGoogleMaps(),
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1,
                  color: const Color(0xffCCCCCC),
                ),
              ),
              margin: EdgeInsets.only(bottom: Dimensions.height10),
            ),
            // CONTACT INFO
            Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(left: Dimensions.width10),
              padding: EdgeInsets.symmetric(vertical: Dimensions.height10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: RichText(
                      text: TextSpan(
                        style: TextStyle(
                          fontSize: Dimensions.font16,
                          color: const Color(0xff333333),
                        ),
                        children: const [
                          TextSpan(
                            text: 'Email:',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(text: ' help@gny.bg'),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: Dimensions.height10),
                    child: RichText(
                      text: TextSpan(
                        style: TextStyle(
                          fontSize: Dimensions.font16,
                          color: const Color(0xff333333),
                        ),
                        children: const [
                          TextSpan(
                            text: 'Phone:',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(text: ' 0123 456 789'),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: Dimensions.height10),
                    child: RichText(
                      text: TextSpan(
                        style: TextStyle(
                          fontSize: Dimensions.font16,
                          color: const Color(0xff333333),
                        ),
                        children: const [
                          TextSpan(
                            text: 'Address:',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                              text: ' Varna, Levski 9010, ul. Studentska 1'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              indent: Dimensions.width10,
              endIndent: Dimensions.width10,
              thickness: 1,
              color: const Color(0xffcccccc),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: Dimensions.height30),
              child: Text(
                'Frequently asked questions',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: Dimensions.font18,
                  color: const Color(0xff333333),
                ),
              ),
            ),
            SizedBox(height: Dimensions.height10),
            Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: Dimensions.height10),
                  width: MediaQuery.of(context).size.width - Dimensions.width80,
                  child: Text(
                    'Feedback',
                    style: TextStyle(
                      color: const Color(0xff699BFF),
                      fontSize: Dimensions.font18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                MyExpansionTile(
                  'What dod',
                  'idk man fr fr idk man fr fr idk man fr fr idk man fr fr idk man fr fr idk man fr fr idk man fr fr ',
                ),
                MyExpansionTile(
                  'Nah man',
                  'watchu want cuh',
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: Dimensions.height10),
                  width: MediaQuery.of(context).size.width - Dimensions.width80,
                  child: Text(
                    'Delivery',
                    style: TextStyle(
                      color: const Color(0xff699BFF),
                      fontSize: Dimensions.font18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                MyExpansionTile(
                  'What do',
                  'idk man fr fr',
                ),
                MyExpansionTile(
                  'Nah man',
                  'watchu want cuh',
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: Dimensions.height10),
                  width: MediaQuery.of(context).size.width - Dimensions.width80,
                  child: Text(
                    'Payment',
                    style: TextStyle(
                      color: const Color(0xff699BFF),
                      fontSize: Dimensions.font18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                MyExpansionTile(
                  'What do',
                  'idk man fr fr',
                ),
                MyExpansionTile(
                  'Nah man',
                  'watchu want cuh',
                ),
              ],
            ),
          ],
        ),
      ),
      drawer: const MyDrawer(),
      floatingActionButton: const MyFloatingButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      bottomNavigationBar: const MyBottomNavbar(),
    );
  }
}
