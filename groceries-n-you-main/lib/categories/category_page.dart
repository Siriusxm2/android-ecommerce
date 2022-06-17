import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:groceries_n_you/customIcons/custom_icons_icons.dart';
import 'package:groceries_n_you/dimensions.dart';

import '../blocs/blocs.dart';
import '../models/product_model.dart';
import '../myWidgets/widgets.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  late bool _gridState;
  late bool _listState;

  @override
  void initState() {
    _gridState = true;
    _listState = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBarHeader(label: 'Beer'),
      drawer: const MyDrawer(),
      floatingActionButton: const MyFloatingButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      bottomNavigationBar: const MyBottomNavbar(),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Container(
                      margin: EdgeInsets.fromLTRB(
                        Dimensions.width20,
                        Dimensions.height10,
                        0,
                        Dimensions.height10,
                      ),
                      child: Row(
                        children: [
                          OutlinedButton(
                            onPressed: () {},
                            child: Text(
                              'Astika',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.w300,
                                color: const Color(0xff333333),
                                fontSize: Dimensions.font12,
                              ),
                            ),
                            style: OutlinedButton.styleFrom(
                              minimumSize:
                                  Size(Dimensions.width80, Dimensions.height40),
                              maximumSize: Size(
                                  Dimensions.width100, Dimensions.height40),
                              side: const BorderSide(
                                width: 0.5,
                                color: Color(0xffFFBE57),
                              ),
                              shape: const BeveledRectangleBorder(),
                            ),
                          ),
                          SizedBox(width: Dimensions.width5),
                          OutlinedButton(
                            onPressed: () {},
                            child: Text(
                              'Tuborg',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.w300,
                                color: const Color(0xff333333),
                                fontSize: Dimensions.font12,
                              ),
                            ),
                            style: OutlinedButton.styleFrom(
                              minimumSize:
                                  Size(Dimensions.width80, Dimensions.height40),
                              maximumSize: Size(
                                  Dimensions.width100, Dimensions.height40),
                              side: const BorderSide(
                                width: 0.5,
                                color: Color(0xffFFBE57),
                              ),
                              shape: const BeveledRectangleBorder(),
                            ),
                          ),
                          SizedBox(width: Dimensions.width5),
                          OutlinedButton(
                            onPressed: () {},
                            child: Text(
                              'Heineken',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.w300,
                                color: const Color(0xff333333),
                                fontSize: Dimensions.font12,
                              ),
                            ),
                            style: OutlinedButton.styleFrom(
                              minimumSize:
                                  Size(Dimensions.width80, Dimensions.height40),
                              maximumSize: Size(
                                  Dimensions.width100, Dimensions.height40),
                              side: const BorderSide(
                                width: 0.5,
                                color: Color(0xffFFBE57),
                              ),
                              shape: const BeveledRectangleBorder(),
                            ),
                          ),
                          SizedBox(width: Dimensions.width5),
                          OutlinedButton(
                            onPressed: () {},
                            child: Text(
                              'Ariana',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.w300,
                                color: const Color(0xff333333),
                                fontSize: Dimensions.font12,
                              ),
                            ),
                            style: OutlinedButton.styleFrom(
                              minimumSize:
                                  Size(Dimensions.width80, Dimensions.height40),
                              maximumSize: Size(
                                  Dimensions.width100, Dimensions.height40),
                              side: const BorderSide(
                                width: 0.5,
                                color: Color(0xffFFBE57),
                              ),
                              shape: const BeveledRectangleBorder(),
                            ),
                          ),
                          SizedBox(width: Dimensions.width5),
                          OutlinedButton(
                            onPressed: () {},
                            child: Text(
                              'Shumensko',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.w300,
                                color: const Color(0xff333333),
                                fontSize: Dimensions.font12,
                              ),
                            ),
                            style: OutlinedButton.styleFrom(
                              minimumSize:
                                  Size(Dimensions.width80, Dimensions.height40),
                              maximumSize: Size(
                                  Dimensions.width100, Dimensions.height40),
                              side: const BorderSide(
                                width: 0.5,
                                color: Color(0xffFFBE57),
                              ),
                              shape: const BeveledRectangleBorder(),
                            ),
                          ),
                          SizedBox(width: Dimensions.width5),
                          OutlinedButton(
                            onPressed: () {},
                            child: Text(
                              'Pirinsko',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.w300,
                                color: const Color(0xff333333),
                                fontSize: Dimensions.font12,
                              ),
                            ),
                            style: OutlinedButton.styleFrom(
                              minimumSize:
                                  Size(Dimensions.width80, Dimensions.height40),
                              maximumSize: Size(
                                  Dimensions.width100, Dimensions.height40),
                              side: const BorderSide(
                                width: 0.5,
                                color: Color(0xffFFBE57),
                              ),
                              shape: const BeveledRectangleBorder(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Divider(
                    thickness: 1,
                    indent: Dimensions.width10,
                    endIndent: Dimensions.width10,
                    color: const Color(0xffcccccc),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Icon(
                          CustomIcons.gridView,
                          color: _gridState
                              ? const Color(0xff333333)
                              : const Color(0xffcccccc),
                        ),
                        onPressed: () {
                          setState(() {
                            _gridState = true;
                            _listState = false;
                          });
                        },
                      ),
                      SizedBox(width: Dimensions.width50 / 2),
                      IconButton(
                        icon: Icon(
                          CustomIcons.listView,
                          color: _listState
                              ? const Color(0xff333333)
                              : const Color(0xffcccccc),
                        ),
                        onPressed: () {
                          setState(() {
                            _listState = true;
                            _gridState = false;
                          });
                        },
                      ),
                    ],
                  ),
                  const Divider(
                    thickness: 1,
                    color: Color(0xffcccccc),
                  ),
                  BlocBuilder<ProductBloc, ProductState>(
                    builder: (context, state) {
                      if (state is ProductLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (state is ProductLoaded) {
                        return Container(
                          margin: EdgeInsets.only(top: Dimensions.height10),
                          //width: MediaQuery.of(context).size.width - Dimensions.width40,
                          child: _gridState
                              ? Wrap(
                                  alignment: WrapAlignment.center,
                                  children: _convertToView(
                                    state.products,
                                    state.products.length,
                                    _gridState,
                                  ),
                                )
                              : Column(
                                  children: _convertToView(
                                    state.products,
                                    state.products.length,
                                    _gridState,
                                  ),
                                ),
                        );
                      } else {
                        return const Text('Something went wrong!');
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

List<Widget> _convertToView(List<ProductModel> prods, int length, bool view) {
  List<Widget> productList = [];
  for (int i = 0; i < length; i++) {
    productList.add(MyProductWidget(
      product: prods[i],
      view: view,
    ));
  }
  return productList;
}
