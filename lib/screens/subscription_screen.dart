import 'package:flutter/material.dart';

import '../widgets/subscription.dart';
import 'first_note_screen.dart';
import './note_overview_screen.dart';

class SubscriptionScreen extends StatefulWidget {
  static const routeName = '/subscription';
  const SubscriptionScreen({Key? key}) : super(key: key);

  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(248, 238, 226, 1),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.symmetric(vertical: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            // mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 35,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: Stack(children: [
                  Align(
                    alignment: Alignment(0, 0),
                    child: const Text(
                      'Notely Premium',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Nunito',
                        fontWeight: FontWeight.w900,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Align(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                        icon: Icon(
                          Icons.close,
                          size: 30,
                          color: Color.fromRGBO(64, 59, 54, 1),
                        ),
                        onPressed: () => Navigator.of(context).pop(),
                      ))
                ]),
              ),
              Expanded(
                child: Subscription(),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 40),
                width: double.infinity,
                height: 70,
                child: TextButton(
                  onPressed: () => Navigator.of(context).popAndPushNamed(NoteOverviewScreen.routeName),
                  child: Text(
                    'SUBSCRIBE',
                    style: TextStyle(
                        fontFamily: 'Nunito',
                        fontSize: 16,
                        fontWeight: FontWeight.w900,
                        color: Color.fromARGB(255, 255, 251, 250)),
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        Color.fromARGB(255, 217, 97, 76)),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20))),
                  ),
                ),
              ),
              SizedBox(height: 15),
              const Text(
                'Already have an account?',
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.w800,
                    color: Color.fromARGB(255, 217, 97, 76)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
