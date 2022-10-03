import 'package:flutter/material.dart';

import 'page_dots.dart';

class Onboarding1 extends StatelessWidget {
  final int thisPage;
  final int currentPage;
  const Onboarding1(this.thisPage, this.currentPage,{Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 40),
      // height: MediaQuery.of(context).size.height / 3.5,
      // margin: EdgeInsets.only(bottom: 40),
      width: double.infinity,
      child:
          Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Image.asset('assets/images/Group 82 1.png'),
        SizedBox(
          height: 15,
        ),
        const Text('Worlds Safest And Largest Digital Notebook',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontFamily: 'Nunito',
                fontWeight: FontWeight.w900,
                color: Color.fromRGBO(64, 59, 54, 1),
                fontSize: 24)),
        SizedBox(height: 10,),
        const Text(
          'Notely is the world’s safest, largest and intelligent digital notebook. Join over 10M+ users already using Notely.',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontFamily: 'Nunito',
              fontWeight: FontWeight.w700,
              color: Color.fromRGBO(89, 85, 80, 1),
              fontSize: 16),
        ),
      ]),
    );
  }
}
