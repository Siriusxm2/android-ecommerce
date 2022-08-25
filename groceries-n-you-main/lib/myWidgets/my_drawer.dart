import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:groceries_n_you/constants/routes.dart';
import 'package:groceries_n_you/dimensions.dart';
import 'package:groceries_n_you/models/category_model.dart';
import 'package:groceries_n_you/myWidgets/my_list_tile.dart';

import '../blocs/blocs.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: BlocBuilder<CategoryBloc, CategoryState>(
        builder: (context, state) {
          if (state is CategoryLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is CategoryLoaded) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  decoration: const BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xffFFAE2D),
                        //offset: Offset(0, 8),
                      )
                    ],
                  ),
                  height: Dimensions.height140,
                  child: DrawerHeader(
                    padding: EdgeInsets.symmetric(vertical: Dimensions.height16),
                    child: Row(
                      children: [
                        Container(
                          height: Dimensions.height20,
                          width: Dimensions.width10,
                          color: const Color(0xffFFAE2D),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: Dimensions.width5),
                          child: Text(
                            'CATEGORIES',
                            style: TextStyle(
                              fontSize: Dimensions.font24,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xffFFAE2D),
                            ),
                          ),
                        ),
                        Container(
                          height: Dimensions.height20,
                          width: Dimensions.width130,
                          color: const Color(0xffFFAE2D),
                        ),
                      ],
                    ),
                    decoration: const BoxDecoration(
                      color: Color(0xff4382FF),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height - Dimensions.height140,
                  child: ListView.builder(
                    itemCount: state.categories.length,
                    itemBuilder: (context, index) {
                      return MyListTileExpand(
                        children: [
                          ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: state.categories[index].subcategories.length,
                            itemBuilder: (context2, index2) {
                              return MyListTileSub(
                                state.categories[index].subcategories[index2],
                                () {
                                  Navigator.of(context).pushNamedAndRemoveUntil(
                                    categoryRoute,
                                    (route) => true,
                                    arguments: state.categories[index],
                                  );
                                },
                                const SizedBox(),
                              );
                            },
                          ),
                        ],
                        imageAsset: state.categories[index].image,
                        bgColor: const Color(0xff699BFF),
                        borderColor: const Color(0xffB4CDFF),
                        text: state.categories[index].name,
                      );
                    },
                  ),
                ),
              ],
            );
          } else {
            return const Text('Something went wrong');
          }
        },
      ),
    );
  }
}
