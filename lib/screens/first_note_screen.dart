import 'package:flutter/material.dart';

import '../widgets/first_note.dart';
import './note_screen.dart';
import '../note_type.dart';
import '../widgets/drawer.dart';

class NoNotes extends StatelessWidget {
  Function noteFunction;
  NoNotes({
    required this.noteFunction,
    Key? key,
  }) : super(key: key);

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: AppDrawer(),
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
                      'All Notes',
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
                          Icons.search,
                          size: 30,
                          color: Color.fromRGBO(64, 59, 54, 1),
                        ),
                        onPressed: () {},
                      )),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: IconButton(
                        icon: Icon(
                          Icons.menu,
                          size: 30,
                          color: Color.fromRGBO(64, 59, 54, 1),
                        ),
                        onPressed: () {
                          _scaffoldKey.currentState?.openDrawer();
                        },
                      ))
                ]),
              ),
              Expanded(
                child: FirstNote(),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 40),
                width: double.infinity,
                height: 70,
                child: TextButton(
                  onPressed: () async {
                    noteFunction(context);
                  },
                  child: Text(
                    'Create A Note',
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
              Text(
                'Import Notes',
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
