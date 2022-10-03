import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../note_type.dart';
import '../providers/note.dart';
import '../widgets/drawer.dart';

class ChecklistScreen extends StatefulWidget {
  static const routeName = '/checklist';
  Note? note;

  ChecklistScreen({this.note, Key? key}) : super(key: key);

  @override
  State<ChecklistScreen> createState() => _ChecklistScreenState();
}

class _ChecklistScreenState extends State<ChecklistScreen> {
  Note? note;
  TextEditingController _titleController = TextEditingController();
  TextEditingController _bodyController = TextEditingController();
  bool checkValue = false;
  List checklist = [
    // {'body': 'This is the item body', 'isChecked': true},
    // {'body': 'This is the item body', 'isChecked': false},
    // {'body': 'This is the item body', 'isChecked': false}
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    note = widget.note;
    if (note != null) {
      _titleController.text = note!.title;
      checklist = note!.body;
    }
  }

  // NoteType? noteType;

  Future<void> save(context, NoteType noteType) async {
    String title = _titleController.text;
    List body = checklist;
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
    List body = checklist;

    Note updateNote =
        Note(body: checklist, title: title, id: note.id, type: note.type);

    if (title.isNotEmpty || checklist.isNotEmpty) {
      await Provider.of<Notes>(context, listen: false)
          .updateNote(note.id, updateNote);
      Navigator.of(context).pop();
    }
  }

  void updateEntry(int index, String entry) {
    checklist[index]['body'] = entry;
  }

  void updateCheck(int index, bool check) {
    checklist[index]['isChecked'] = check;
  }

  void dismissEntry(int index) {
    checklist.removeAt(index);
  }

  @override
  Widget build(BuildContext context) {
    NoteType noteType = note != null
        ? note!.type
        : ModalRoute.of(context)!.settings.arguments as NoteType;
    return Scaffold(
      drawer: AppDrawer(),
      backgroundColor: Color.fromRGBO(248, 238, 226, 1),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Color.fromARGB(255, 217, 97, 76),
          onPressed: () =>
              note != null ? update(context, note!) : save(context, noteType),
          // save(context, noteType),
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
                      // textInputAction: TextInputAction.next,
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
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          if (checklist.isNotEmpty)
                            ListView.builder(
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                primary: false,
                                itemCount: checklist.length,
                                itemBuilder: (context, index) {
                                  return ChecklistTile(
                                      checklist[index]['body'],
                                      checklist[index]['isChecked'],
                                      index,
                                      updateEntry,
                                      dismissEntry,
                                      updateCheck);
                                }),
                          Card(
                            child: ListTile(
                              contentPadding: EdgeInsets.zero,
                              minVerticalPadding: 0,
                              visualDensity:
                                  VisualDensity(horizontal: -4, vertical: -4),
                              leading: Checkbox(
                                value: checkValue,
                                fillColor: MaterialStateProperty.all(
                                    Theme.of(context).colorScheme.primary),
                                onChanged: (value) {
                                  setState(() {
                                    checkValue = value!;
                                  });
                                },
                              ),
                              title: TextField(
                                onEditingComplete: () {
                                  // print('done');
                                  if (_bodyController.text.isNotEmpty) {
                                    setState(() {
                                      checklist.add({
                                        'body': _bodyController.text,
                                        'isChecked': checkValue
                                      });
                                      _bodyController.clear();
                                    });
                                  }
                                },
                                maxLines: null,
                                style: TextStyle(
                                  fontFamily: 'Nunito',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: Color.fromRGBO(89, 85, 80, 1),
                                ),
                                controller: _bodyController,
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                    hintText: 'New item ...',
                                    hintStyle: TextStyle(
                                      fontFamily: 'Nunito',
                                      fontSize: 14,
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
                            ),
                          ),
                        ],
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

class ChecklistTile extends StatefulWidget {
  String _body;
  bool _isChecked;
  int index;
  Function update;
  Function dismiss;
  Function check;
  ChecklistTile(this._body, this._isChecked, this.index, this.update,
      this.dismiss, this.check,
      {Key? key})
      : super(key: key);

  @override
  State<ChecklistTile> createState() => _ChecklistTileState();
}

class _ChecklistTileState extends State<ChecklistTile> {
  TextEditingController _bodyController = TextEditingController();
  // bool checkValue = false;
  String? body;
  bool? isChecked;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    body = widget._body;
    isChecked = widget._isChecked;
    _bodyController.text = widget._body;
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(widget.index.toString()),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        color: Theme.of(context).colorScheme.primary,
        child: Icon(
          Icons.delete,
          color: Colors.white,
        ),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        minVerticalPadding: 0,
        visualDensity: VisualDensity(horizontal: -4, vertical: -4),
        leading: Checkbox(
          value: isChecked,
          fillColor:
              MaterialStateProperty.all(Theme.of(context).colorScheme.primary),
          onChanged: (value) {
            widget.check(widget.index, value);
            setState(() {
              isChecked = value!;
            });
          },
        ),
        title: TextField(
          onEditingComplete: () {
            if (_bodyController.text.isNotEmpty) {
              widget.update(widget.index, _bodyController.text);
            }
          },
          maxLines: null,
          style: TextStyle(
            fontFamily: 'Nunito',
            fontSize: 14,
            decoration: isChecked == true ? TextDecoration.lineThrough : null,
            fontWeight: FontWeight.w700,
            color: isChecked == true
                ? Color.fromRGBO(99, 95, 90, 0.5)
                : Color.fromRGBO(79, 75, 70, 1),
          ),
          controller: _bodyController,
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
              hintText: 'Item',
              hintStyle: TextStyle(
                fontFamily: 'Nunito',
                decoration: TextDecoration.lineThrough,
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
      ),
    );
  }
}
