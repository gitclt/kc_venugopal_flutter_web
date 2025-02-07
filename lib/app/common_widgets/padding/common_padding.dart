import 'package:flutter/material.dart';

class CommonPagePadding extends StatelessWidget {
  final Widget? child;
  const CommonPagePadding({super.key, this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, top: 20, right: 15, bottom: 20),
      child: child,
    );
  }
}
