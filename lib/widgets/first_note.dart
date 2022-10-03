import 'package:flutter/material.dart';

class FirstNote extends StatelessWidget {
  const FirstNote({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 40),
      width: double.infinity,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset('assets/images/Group 84 1.png'),
            SizedBox(
              height: 20,
            ),
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
            const Text(
              'Add a note about anything (your thoughts on climate change, or your history essay) and share it witht the world.',
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