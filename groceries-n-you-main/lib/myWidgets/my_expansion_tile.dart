import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:groceries_n_you/dimensions.dart';

class MyExpansionTile extends StatefulWidget {
  String parentText;
  String childText;
  MyExpansionTile(this.parentText, this.childText, {Key? key})
      : super(key: key);

  @override
  State<MyExpansionTile> createState() => _MyExpansionTileState();
}

class _MyExpansionTileState extends State<MyExpansionTile> {
  bool _isExpanded = false;
  String _pText = '';
  String _cText = '';

  @override
  void initState() {
    _pText = widget.parentText;
    _cText = widget.childText;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      onExpansionChanged: (value) {
        setState(() {
          _isExpanded = value;
        });
      },
      tilePadding: EdgeInsets.symmetric(horizontal: Dimensions.height10),
      expandedAlignment: Alignment.centerLeft,
      trailing: const SizedBox(),
      leading: AnimatedRotation(
        turns: _isExpanded ? 0.25 : 0,
        duration: const Duration(milliseconds: 300),
        child: Transform.rotate(
          angle: 90 * math.pi / 180,
          child: const Icon(
            Icons.expand_less,
            color: Color(0xff666666),
            size: 30,
          ),
        ),
      ),
      title: SizedBox(
        width: Dimensions.width20,
        child: Text(
          _pText,
          style: const TextStyle(
            color: Color(0xff333333),
          ),
        ),
      ),
      children: [
        Container(
          margin: EdgeInsets.only(left: Dimensions.width60),
          padding: EdgeInsets.symmetric(vertical: Dimensions.height10),
          width: MediaQuery.of(context).size.width - Dimensions.width100,
          child: Text(_cText),
        ),
      ],
    );
  }
}
