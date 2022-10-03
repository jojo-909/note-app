import 'package:flutter/material.dart';
import 'package:note_app/screens/signup_screen.dart';

import '../widgets/page_dots.dart';
import '../widgets/onboarding1.dart';

class OnboardingScreen extends StatefulWidget {
  static const routeName = '/onboarding';
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _pageController = PageController(initialPage: 0);
  int _currentPage = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(248, 238, 226, 1),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'NOTELY',
              style: TextStyle(
                  fontFamily: 'TitanOne',
                  fontWeight: FontWeight.bold,
                  fontSize: 24),
            ),
            Expanded(
              child: PageView(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      _currentPage = index + 1;
                    });
                  },
                  children: [
                    Onboarding1(1, _currentPage),
                    Onboarding1(2, _currentPage),
                    Onboarding1(3, _currentPage)
                  ]),
            ),
            Container(
                width: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    PageDots(1, _currentPage),
                    PageDots(2, _currentPage),
                    PageDots(3, _currentPage)
                  ],
                )),
            SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 40),
              width: double.infinity,
              height: 70,
              child: TextButton(
                onPressed: () => _currentPage != 3
                    ? _pageController.nextPage(
                        duration: Duration(milliseconds: 500),
                        curve: Curves.linear)
                    : Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => SignupScreen(false))),
                child: Text(
                  _currentPage == 3 ? 'GET STARTED' : 'NEXT',
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
            GestureDetector(
              onTap: (() => Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => SignupScreen(true)))),
              child: Text(
                'Already have an account?',
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.w800,
                    color: Color.fromARGB(255, 217, 97, 76)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
