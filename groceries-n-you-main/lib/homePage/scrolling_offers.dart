import 'package:flutter/material.dart';
import 'package:groceries_n_you/dimensions.dart';
import 'package:groceries_n_you/myWidgets/homepage_seehere_button.dart';

class ScrollingOffers extends StatefulWidget {
  const ScrollingOffers({Key? key}) : super(key: key);

  @override
  State<ScrollingOffers> createState() => _ScrollingOffersState();
}

class _ScrollingOffersState extends State<ScrollingOffers> {
  PageController pageController = PageController();
  double _currentPageValue = 0.0;
  final _currentPageNotifier = ValueNotifier<int>(0);

  @override
  void initState() {
    pageController.addListener(() {
      setState(() {
        _currentPageValue = pageController.page!;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _currentPageNotifier.dispose();
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            SizedBox(
              height: Dimensions.height180,
              child: PageView.builder(
                  itemCount: 5,
                  controller: pageController,
                  onPageChanged: (index) {
                    _currentPageNotifier.value = index;
                  },
                  itemBuilder: (context, position) {
                    return _buildPageItem(position);
                  }),
            ),
            PositionedDirectional(
              start: 20,
              bottom: 14,
              child: Wrap(
                children: List.generate(
                  5,
                  (index) => _indicator(_currentPageValue == index),
                ),
              ),
            ),
            PositionedDirectional(
              end: 20,
              bottom: 0,
              child: MySeeHereButton(onPressed: () {}),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPageItem(int index) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fill,
          image: AssetImage('assets/Lasagna.png'),
        ),
      ),
    );
  }

  Widget _indicator(bool isActive) {
    return Container(
      child: isActive
          ? const Icon(
              Icons.radio_button_checked,
              size: 20,
              color: Color(0xffFFBE57),
            )
          : const Icon(
              Icons.radio_button_unchecked,
              size: 20,
              color: Color(0xffFFAE2D),
            ),
    );
  }
}
