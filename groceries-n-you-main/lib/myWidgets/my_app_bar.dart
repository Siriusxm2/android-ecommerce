import 'package:flutter/material.dart';
import 'package:groceries_n_you/constants/routes.dart';
import 'package:groceries_n_you/dimensions.dart';
//import 'dart:developer' as devtools show log;

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  MyAppBar({Key? key}) : super(key: key);

  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBar(
          toolbarHeight: Dimensions.height50,
          titleSpacing: 0.0,
          centerTitle: true,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                iconSize: 30.0,
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                icon: const Icon(Icons.menu),
              ),
              Stack(
                alignment: Alignment.center,
                children: [
                  IconButton(
                    iconSize: 30.0,
                    onPressed: () {
                      if (ModalRoute.of(context)!.settings.name !=
                          profileRoute) {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            profileRoute, (route) => true);
                      }
                    },
                    icon: const Icon(Icons.person_outline),
                  ),
                ],
              ),
              Expanded(
                child: Center(
                  child: GestureDetector(
                    onTap: () {
                      if (ModalRoute.of(context)!.settings.name != homeRoute) {
                        Navigator.of(context)
                            .pushNamedAndRemoveUntil(homeRoute, (_) => false);
                      }
                    },
                    child: Image.asset(
                      'assets/logo.png',
                      fit: BoxFit.cover,
                      width: Dimensions.width40,
                      height: Dimensions.height40,
                    ),
                  ),
                ),
              ),
            ],
          ),
          automaticallyImplyLeading: false,
          actions: [
            MySearchWidget(),
            IconButton(
              iconSize: 28.0,
              onPressed: () {
                if (ModalRoute.of(context)!.settings.name != cartRoute) {
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil(cartRoute, (route) => true);
                }
              },
              icon: const Icon(Icons.shopping_cart),
            ),
          ],
        ),
        // !expanded
        //     ? Stack()
        //     : Stack(
        //         children: [
        //           Center(
        //             child: Container(
        //               width: MediaQuery.of(context).size.width,
        //               height: Dimensions.height50,
        //               decoration: const BoxDecoration(
        //                 color: Color(0xffffffff),
        //               ),
        //               child: Container(
        //                 margin: EdgeInsets.only(top: Dimensions.height10),
        //                 padding: EdgeInsets.symmetric(
        //                     horizontal: Dimensions.height20),
        //                 alignment: Alignment.center,
        //                 child: TextFormField(
        //                   decoration: InputDecoration(
        //                     border: OutlineInputBorder(
        //                       borderRadius: BorderRadius.all(
        //                         Radius.circular(Dimensions.border5),
        //                       ),
        //                       borderSide: const BorderSide(
        //                         color: Color(0xffD4D4D4),
        //                       ),
        //                     ),
        //                     hintText: 'Delivery date',
        //                     hintStyle: const TextStyle(
        //                       color: Color(0xff959595),
        //                     ),
        //                     contentPadding:
        //                         EdgeInsets.only(left: Dimensions.width10),
        //                     suffixIcon: InkWell(
        //                       onTap: () {},
        //                       child: const Icon(
        //                         Icons.insert_invitation,
        //                         color: Color(0xffcccccc),
        //                       ),
        //                     ),
        //                   ),
        //                 ),
        //               ),
        //             ),
        //           ),
        //         ],
        //       ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class MySearchWidget extends StatefulWidget {
  MySearchWidget({Key? key}) : super(key: key);

  @override
  State<MySearchWidget> createState() => _MySearchWidgetState();
}

class _MySearchWidgetState extends State<MySearchWidget> {
  ValueNotifier<bool> expanded = ValueNotifier<bool>(false);
  OverlayEntry? _overlayEntry;

  @override
  void initState() {
    OverlayState? overlayState = Overlay.of(context);
    expanded.addListener(() {
      if (expanded.value) {
        _overlayEntry = _createOverlay();

        overlayState!.insert(_overlayEntry!);
      } else {
        _overlayEntry!.remove();
      }
    });
    super.initState();
  }

  OverlayEntry _createOverlay() {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    var size = renderBox.size;

    return OverlayEntry(
      builder: (context) => Positioned(
        top: 80,
        left: 0,
        width: MediaQuery.of(context).size.width,
        child: Material(
          elevation: 5.0,
          child: Center(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: Dimensions.height60,
              decoration: const BoxDecoration(
                color: Color(0xffffffff),
              ),
              child: Container(
                margin: EdgeInsets.only(
                  top: Dimensions.height10,
                  bottom: Dimensions.height10,
                ),
                padding: EdgeInsets.symmetric(horizontal: Dimensions.height20),
                alignment: Alignment.center,
                child: TextFormField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0xffD9E6FF),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(Dimensions.border5),
                      ),
                      borderSide: const BorderSide(
                        color: Color(0xffD4D4D4),
                      ),
                    ),
                    hintText: 'Search products...',
                    hintStyle: const TextStyle(
                      color: Color(0xff000000),
                    ),
                    contentPadding: EdgeInsets.only(left: Dimensions.width10),
                    suffixIcon: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xff699BFF),
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(Dimensions.border5),
                          bottomRight: Radius.circular(Dimensions.border5),
                        ),
                      ),
                      child: InkWell(
                        onTap: () {},
                        child: const Icon(
                          Icons.search,
                          color: Color(0xffffffff),
                          size: 30,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color:
            !expanded.value ? const Color(0xff699BFF) : const Color(0xffD9E6FF),
      ),
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          setState(() {
            expanded.value = !expanded.value;
          });
        },
        child: Icon(
          Icons.search,
          size: 30,
          color: !expanded.value
              ? const Color(0xffffffff)
              : const Color(0xff999999),
        ),
      ),
    );
  }
}
