import 'dart:math';
import 'package:flutter/material.dart';
import 'package:public_app/Core/unit/color_data.dart';
import 'package:public_app/Core/unit/shadow_data.dart';
import 'package:public_app/Core/unit/size_data.dart';

enum TrailingAngels {
  rightAndDown,
  upAndDown
}

class ExpansionTileCustomController extends ValueNotifier<bool> {
  ExpansionTileCustomController({bool initiallyExpanded = false}) : super(initiallyExpanded);

  void open() {
    value = true;
  }

  void close() {
    value = false;
  }

  void toggle() {
    value = !value;
  }
}

class ExpansionTileCustom extends StatefulWidget {
  final Widget title;
  final List<Widget> children;
  final Widget trailing;
  final TrailingAngels trailingAngels;
  final EdgeInsets padding;
  final ExpansionTileCustomController? controller;
  final bool initiallyExpanded;

  const ExpansionTileCustom({
    super.key,
    required this.title,
    required this.children,
    required this.trailing,
    required this.trailingAngels,
    this.controller,
    this.padding = const EdgeInsets.all(0),
    this.initiallyExpanded = false,
  });

  @override
  State<ExpansionTileCustom> createState() => _ExpansionTileCustomState();
}

class _ExpansionTileCustomState extends State<ExpansionTileCustom> {
  late bool _isOpen;

  @override
  void initState() {
    super.initState();
    _isOpen = widget.controller?.value ?? widget.initiallyExpanded;
    widget.controller?.addListener(_toggleExpansion);
  }

  @override
  void dispose() {
    widget.controller?.removeListener(_toggleExpansion);
    super.dispose();
  }

  void _toggleExpansion() {
    setState(() {
      _isOpen = widget.controller?.value ?? _isOpen;
    });
    //print(_isOpen);
  }

  void _handleTap() {
    if (widget.controller != null) {
      widget.controller!.toggle();
      //print(widget.controller!.value);
      //print("Toggling");
    } else {
      setState(() {
        _isOpen = !_isOpen;
      });
      //print("Tapped");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding,
      child: GestureDetector(
        onTap: _handleTap,
        child: Container(
          decoration: BoxDecoration(
            color: ColorData.whiteColor200,
            borderRadius: BorderRadius.circular(SizeData.s16),
            boxShadow: ShadowData.boxShadow1,
          ),
          padding: EdgeInsets.all(SizeData.s16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: SizeData.s8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    widget.title,
                    Transform.rotate(
                      angle: _isOpen ? 0.5 * pi : (widget.trailingAngels == TrailingAngels.upAndDown ? -0.5 * pi : 0),
                      child: widget.trailing,
                    ),
                  ],
                ),
              ),
              if (_isOpen) ...widget.children,
            ],
          ),
        ),
      ),
    );
  }
}
