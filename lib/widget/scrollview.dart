import 'package:flutter/material.dart';

class WScrollView extends StatelessWidget {
  const WScrollView({
    super.key,
    required this.child,
    this.center = false,
    this.padding = EdgeInsets.zero,
  });

  final Widget child;
  final bool center;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    var scroll = SingleChildScrollView(child: child);
    var widget = center ? Center(child: scroll) : scroll;
    return SafeArea(child: Padding(padding: padding, child: widget));
  }
}
