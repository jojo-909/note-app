import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screens/onboarding_screen.dart';
import './screens/signup_screen.dart';
import './screens/subscription_screen.dart';
import './screens/note_overview_screen.dart';
import './screens/first_note_screen.dart';
import './screens/note_screen.dart';
import './screens/checklist_screen.dart';
import './providers/auth.dart';
import './providers/note.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Auth()),
        ChangeNotifierProxyProvider<Auth, Notes>(
          create: (context) => Notes(),
          update: (context, auth, previousNotes) => previousNotes!..update(auth, previousNotes.notes),
        )
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          key: UniqueKey(),
          title: 'Note',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            scaffoldBackgroundColor: Color(0xF8EEE2),
            // primarySwatch: Colors.blue,
            colorScheme: ColorScheme.fromSwatch().copyWith(
              primary: Color.fromARGB(255, 217, 97, 76),
              secondary: Color.fromRGBO(248, 238, 226, 1),
            )
          ),
          home: auth.isAuth ? (auth.newUSer ? SubscriptionScreen() : NoteOverviewScreen()) : OnboardingScreen(),
          // ChecklistScreen(),
          routes: {
            // FirstNoteScreen.routeName: (ctx) => FirstNoteScreen(),
            NoteOverviewScreen.routeName: (context) => NoteOverviewScreen(),
            NoteScreen.routeName:(context) => NoteScreen(),
            OnboardingScreen.routeName: (context) => OnboardingScreen(),
            SignupScreen.routeName: (context) => SignupScreen(false),
            SubscriptionScreen.routeName: (context)=> SubscriptionScreen(),
            ChecklistScreen.routeName: ((context) => ChecklistScreen())
          },
        ),
      )
    );
  }
}

