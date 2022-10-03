import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../note_type.dart';
import '../providers/note.dart';

class NoteScreen extends StatefulWidget {
  static const routeName = '/note';
  Note? note;

  NoteScreen({this.note, Key? key}) : super(key: key);

  @override
  State<NoteScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  Note? note;
  TextEditingController _titleController = TextEditingController();
  TextEditingController _bodyController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    note = widget.note;
    if (note != null) {
      _titleController.text = note!.title;
      _bodyController.text = note!.body;
    }
  }

  // NoteType? noteType;

  Future<void> save(context, NoteType noteType) async {
    String title = _titleController.text;
    String body = _bodyController.text;
    NoteType type = noteType;

    // Note note = Note(body: body, title: title, type: type);

    if (title.isNotEmpty || body.isNotEmpty) {
      await Provider.of<Notes>(context, listen: false)
          .addNote(title, body, noteType);
      Navigator.of(context).pop();
    }
  }

  Future<void> update(context, Note note) async {
    String title = _titleController.text;
    String body = _bodyController.text;

    Note updateNote =
        Note(body: body, title: title, id: note.id, type: note.type);

    if (title.isNotEmpty || body.isNotEmpty) {
      await Provider.of<Notes>(context, listen: false)
          .updateNote(note.id, updateNote);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    NoteType noteType = note != null
        ? note!.type
        : ModalRoute.of(context)!.settings.arguments as NoteType;
    return Scaffold(
      backgroundColor: Color.fromRGBO(248, 238, 226, 1),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Color.fromARGB(255, 217, 97, 76),
          onPressed: () =>
              note != null ? update(context, note!) : save(context, noteType),
          child: Icon(Icons.save)),
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
                      'Note',
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
                          Icons.delete,
                          size: 30,
                          color: Color.fromRGBO(64, 59, 54, 1),
                        ),
                        onPressed: () async {
                          if (note != null) {
                            await Provider.of<Notes>(context, listen: false)
                                .deleteNote(note!.id);
                            Navigator.of(context).pop();
                          } else {
                            Navigator.of(context).pop();
                          }
                        },
                      )),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Image.asset('assets/images/More ver..png'))
                ]),
              ),
              SizedBox(height: 20),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    TextField(
                      style: TextStyle(
                        fontFamily: 'Nunito',
                        fontSize: 16,
                        fontWeight: FontWeight.w900,
                        color: Color.fromRGBO(89, 85, 80, 1),
                      ),
                      controller: _titleController,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                          hintText: 'Title',
                          hintStyle: TextStyle(
                            fontFamily: 'Nunito',
                            fontSize: 24,
                            fontWeight: FontWeight.w900,
                            color: Color.fromRGBO(89, 85, 80, 1),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          )),
                    ),
                    SizedBox(height: 5),
                    Expanded(
                      child: TextField(
                        controller: _bodyController,
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                            hintText: 'Content',
                            hintStyle: TextStyle(
                            fontFamily: 'Nunito',
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Color.fromRGBO(89, 85, 80, 1),
                          ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            )),
                      ),
                    )
                  ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
