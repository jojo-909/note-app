import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

import '../widgets/first_note.dart';
import './note_screen.dart';
import '../providers/note.dart';
import '../note_type.dart';
import '../providers/auth.dart';
import './first_note_screen.dart';
import 'checklist_screen.dart';
import '../widgets/drawer.dart';

class NoteOverviewScreen extends StatefulWidget {
  static const routeName = '/note_overview';
  NoteOverviewScreen({Key? key}) : super(key: key);

  @override
  State<NoteOverviewScreen> createState() => _NoteOverviewScreenState();
}

class _NoteOverviewScreenState extends State<NoteOverviewScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  NoteType noteType = NoteType.note;
  int? deleteHighlight = null;
  var _isInit = true;
  bool _isloading = false;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    if (_isInit) {
      setState(() {
        _isloading = true;
      });
      Provider.of<Notes>(context).fetchAndSetNotes()
          .then((_) {
            setState(() {
              _isloading = false;
            });
          })
          .catchError((error) {
        print(error);
        setState(() {
          _isloading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  Future<void> _selectNoteType(context) async {
    switch (await showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
              title: Text(
                'Select Note Type',
                style: TextStyle(
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.w900,
                    color: Color.fromRGBO(89, 85, 80, 1),
                    fontSize: 24),
              ),
              children: [
                SimpleDialogOption(
                  onPressed: () {
                    Navigator.pop(context, NoteType.note);
                  },
                  child: Text(
                    'Note',
                    style: TextStyle(
                        fontFamily: 'Nunito',
                        fontWeight: FontWeight.w700,
                        color: Color.fromRGBO(89, 85, 80, 1),
                        fontSize: 16),
                  ),
                ),
                SimpleDialogOption(
                  onPressed: () {
                    Navigator.pop(context, NoteType.checklist);
                  },
                  child: Text(
                    'Checklist',
                    style: TextStyle(
                        fontFamily: 'Nunito',
                        fontWeight: FontWeight.w700,
                        color: Color.fromRGBO(89, 85, 80, 1),
                        fontSize: 16),
                  ),
                )
              ]);
        })) {
      case NoteType.note:
        noteType = NoteType.note;
        Navigator.pushNamed(context, NoteScreen.routeName,
            arguments: NoteType.note);
        break;
      case NoteType.checklist:
        noteType = NoteType.checklist;
        Navigator.pushNamed(context, ChecklistScreen.routeName,
            arguments: NoteType.checklist);
        break;
      case null:
        break;
    }
  }

  Future<dynamic> deleteDialog(context) {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              'Delete Note?',
              style: TextStyle(
                  fontFamily: 'Nunito',
                  fontWeight: FontWeight.w700,
                  color: Color.fromRGBO(89, 85, 80, 1),
                  fontSize: 16),
            ),
            content: Text(
              'Do you want to delete this note?',
              style: TextStyle(
                  fontFamily: 'Nunito',
                  fontWeight: FontWeight.w700,
                  color: Color.fromRGBO(89, 85, 80, 1),
                  fontSize: 16),
            ),
            actions: [
              ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          Color.fromARGB(255, 217, 97, 76)),
                      foregroundColor: MaterialStateProperty.all(Colors.white)),
                  onPressed: () => Navigator.of(context).pop(true),
                  child: Text(
                    'Delete',
                    style: TextStyle(
                        fontFamily: 'Nunito',
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        fontSize: 16),
                  )),
              ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.white),
                      foregroundColor: MaterialStateProperty.all(
                          Color.fromARGB(255, 217, 97, 76))),
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                        fontFamily: 'Nunito',
                        fontWeight: FontWeight.w700,
                        color: Color.fromRGBO(89, 85, 80, 1),
                        fontSize: 16),
                  ))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final obtainedNotes = Provider.of<Notes>(context).notes;
    final notes = obtainedNotes.isEmpty ? [] : obtainedNotes;
    return _isloading 
        ? Scaffold(
          backgroundColor: Theme.of(context).colorScheme.secondary,
          body: Center(
            child: CircularProgressIndicator(),
          ),
        )
        : obtainedNotes.isEmpty
        ? NoNotes(
            noteFunction: _selectNoteType,
          )
        : Scaffold(
            key: _scaffoldKey,
            drawer: AppDrawer(),
            backgroundColor: Color.fromRGBO(248, 238, 226, 1),
            floatingActionButton: FloatingActionButton(
              backgroundColor: Theme.of(context).colorScheme.primary,
              onPressed: () async {
                await _selectNoteType(context);
              },
              child: Icon(Icons.add),
            ),
            body: SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height,
                padding: EdgeInsets.only(top: 40),
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
                            'Recent Notes',
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
                              onPressed: () =>
                                  _scaffoldKey.currentState?.openDrawer(),
                            ))
                      ]),
                    ),
                    Expanded(
                      child: MasonryGridView.count(
                        padding: EdgeInsets.all(15),
                        crossAxisCount: 2,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        itemCount: notes.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onLongPress: () async {
                              setState(() {
                                deleteHighlight = index;
                              });
                              if (await deleteDialog(context)) {
                                Provider.of<Notes>(context, listen: false)
                                    .deleteNote(notes[index].id);
                              }
                              setState(() {
                                deleteHighlight = null;
                              });
                            },
                            onTap: () {
                              if (notes[index].type == NoteType.note) {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        NoteScreen(note: notes[index])));
                              } else {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        ChecklistScreen(note: notes[index])));
                              }
                            },
                            child: Container(
                                padding: EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                    border: deleteHighlight == index
                                        ? Border.all(
                                            width: 3,
                                            color: Color.fromARGB(
                                                255, 217, 97, 76),
                                          )
                                        : null),
                                child: Column(
                                  children: [
                                    if (notes[index].title.isNotEmpty)
                                      Text(
                                        notes[index].title,
                                        style: TextStyle(
                                            fontFamily: 'Nunito',
                                            fontSize: 16,
                                            fontWeight: FontWeight.w900,
                                            color:
                                                Color.fromRGBO(89, 85, 80, 1)),
                                      ),
                                    if (notes[index].title.isNotEmpty)
                                      SizedBox(height: 5),
                                    notes[index].type == NoteType.checklist
                                        ? ListView.builder(
                                            padding: EdgeInsets.zero,
                                            shrinkWrap: true,
                                            primary: false,
                                            itemCount: notes[index].body.length,
                                            itemBuilder: (context, num) {
                                              return ListTile(
                                                  contentPadding:
                                                      EdgeInsets.zero,
                                                  minVerticalPadding: 0,
                                                  visualDensity: VisualDensity(
                                                      horizontal: -4,
                                                      vertical: -4),
                                                  leading: Checkbox(
                                                      value:
                                                          notes[index].body[num]
                                                              ['isChecked'],
                                                      fillColor:
                                                          MaterialStateProperty
                                                              .all(Theme.of(
                                                                      context)
                                                                  .colorScheme
                                                                  .primary),
                                                      onChanged: (_) {}),
                                                  title: Text(
                                                    notes[index].body[num]
                                                        ['body'],
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        fontFamily: 'Nunito',
                                                        fontSize: 14,
                                                        decoration: notes[index].body[num]['isChecked'] == true ? TextDecoration.lineThrough : null,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        color: notes[index].body[num]['isChecked'] == true
                                                          ? Color.fromRGBO(99, 95, 90, 0.5)
                                                          : Color.fromRGBO(79, 75, 70, 1),
                                                  )));
                                            },
                                          )
                                        : Text(
                                            notes[index].body,
                                            style: TextStyle(
                                                fontFamily: 'Nunito',
                                                fontSize: 14,
                                                fontWeight: FontWeight.w700,
                                                color: Color.fromRGBO(
                                                    89, 85, 80, 1)),
                                          )
                                  ],
                                )),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
