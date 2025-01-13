import 'package:flutter/material.dart';

class ResponsiveLayout extends StatelessWidget {
  const ResponsiveLayout({
    super.key,
    required this.mobileLayout,
    required this.tabletLayout,
    required this.desktopLayout,
  });

  final Widget mobileLayout;
  final Widget tabletLayout;
  final Widget desktopLayout;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) {
        if (constraints.maxWidth < 500) {
          return mobileLayout;
        } else if (constraints.maxWidth < 1100) {
          return tabletLayout;
        } else {
          return desktopLayout;
        }
      },
    );
  }
}
