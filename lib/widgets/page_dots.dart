import 'package:flutter/material.dart';

class PageDots extends StatelessWidget {
  final int thisPage;
  final int currentPage;
  const PageDots(this.thisPage, this.currentPage, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool onPage = thisPage == currentPage;
    return Container(
      height: onPage ? 10 : 8,
      width: onPage ? 10 : 8,
      decoration: BoxDecoration(
          color: onPage
              ? Color.fromRGBO(217, 97, 76, 1)
              : Color.fromRGBO(217, 97, 76, 0.5),
          borderRadius: BorderRadius.circular(3)),
    );
  }
}
