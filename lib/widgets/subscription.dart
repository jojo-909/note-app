import 'dart:io';

import 'package:flutter/material.dart';

import 'page_dots.dart';

class Subscription extends StatefulWidget {
  Subscription({Key? key}) : super(key: key);

  @override
  State<Subscription> createState() => _SubscriptionState();
}

class _SubscriptionState extends State<Subscription> {
  var _plan = 'Annual';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 40),
      width: double.infinity,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset('assets/images/Group 83 1.png'),
            
            Text('Start Using Notely with Premium Benefits',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.w900,
                    color: Color.fromRGBO(64, 59, 54, 1),
                    fontSize: 24)),
            SizedBox(
              height: 20,
            ),
            advantages('Save unlimited notes to a single project'),
            SizedBox(
              height: 10,
            ),
            advantages('Create unlimited projects and teams'),
            SizedBox(height: 10),
            advantages('Daily backups to keep your data safe'),
            SizedBox(height: 30),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  plan("Annual", '\$79.99', "per year", context),
                  plan("Monthly", '\$7.99', "per month", context)
                ],
              ),
            )
          ]),
    );
  }

  Widget advantages(String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(Icons.check),
        Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontFamily: 'Nunito',
              fontWeight: FontWeight.w700,
              color: Color.fromRGBO(89, 85, 80, 1),
              fontSize: 16),
        )
      ],
    );
  }

  Widget plan(
      String duration, String amount, String length, BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => setState(() {
        _plan = duration;
      }),
      child: Container(
          height: size.height / 5,
          width: size.height / 5,
          decoration: BoxDecoration(
              border: _plan == duration
                  ? Border.all(color: Color.fromRGBO(244, 127, 107, 1), width: 5)
                  : null,
              borderRadius: BorderRadius.circular(10),
              color: Color.fromRGBO(230, 237, 242, 1)),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  duration,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.w700,
                      color: Color.fromRGBO(89, 85, 80, 1),
                      fontSize: 16),
                ),
                Text(
                  amount,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.w900,
                      color: Color.fromRGBO(89, 85, 80, 1),
                      fontSize: 28),
                ),
                Text(
                  length,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.w800,
                      color: Color.fromRGBO(89, 85, 80, 1),
                      fontSize: 14),
                ),
              ])),
    );
  }
}
