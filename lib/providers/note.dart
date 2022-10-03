import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

import '../note_type.dart';
import 'auth.dart';

class Note {
  final title;
  final body;
  final type;
  final id;
  Note({this.title, this.body, this.type, this.id});
}

// class Checklist {
//   final title;
//   final list;
//   final type;
//   final id;
//   Checklist({this.title, this.list, t})
// }

class Notes with ChangeNotifier {
  String? _authToken;
  String? _userId;

  void update(Auth? auth, [List<Note> notes = const []]) {
    if (auth != null) {
      _authToken = auth.token;
      _userId = auth.userId;
    }
    if (notes.isNotEmpty) {
      _notes = notes;
    }
  }

  List<Note> _notes = [];

  List<Note> get notes {
    return _notes;
  }

  Future<void> fetchAndSetNotes() async {
    _notes = [];
    final url = Uri.parse(
        'https://note-app-326cf-default-rtdb.firebaseio.com/notes/$_userId.json?auth=$_authToken');
    try {
      final response = await http.get(url);
      if (json.decode(response.body) == null) {
        return;
      }
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      // print(response.body);
      final List<Note> loadedNotes = [];
      extractedData.forEach((noteId, note) {
        loadedNotes.add(Note(
            id: noteId,
            title: note['title'],
            type: note['type'] == 'note' ? NoteType.note : NoteType.checklist,
            body: note['body']));
      });
      _notes = loadedNotes;
      notifyListeners();
    } catch (error) {
      print('Note Fetching Error');
      print(error);
    }
  }

  Future<void> addNote(String title, var body, NoteType noteType) async {
    final url = Uri.parse(
        'https://note-app-326cf-default-rtdb.firebaseio.com/notes/$_userId.json?auth=$_authToken');
    try {
      final response = await http.post(url,
          body: json.encode({
            'title': title,
            'type': noteType == NoteType.note ? 'note' : 'checklist',
            'body': body
          }));
      final newNote = Note(
          id: json.decode(response.body)['name'],
          title: title,
          type: noteType,
          body: body);
      _notes.add(newNote);
      print(newNote.id);
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> updateNote(String id, Note newNote) async {
    final noteIndex = _notes.indexWhere((note) => note.id == id);
    if (noteIndex >= 0) {
      final url = Uri.parse(
          'https://note-app-326cf-default-rtdb.firebaseio.com/notes/$_userId/$id.json?auth=$_authToken');
      await http.patch(url,
          body: json.encode({
            'title': newNote.title,
            'type': newNote.type == NoteType.note ? 'note' : 'checklist',
            'body': newNote.body
          }));
      _notes[noteIndex] = newNote;
    } else {
      print('note was not found');
    }

    notifyListeners();
  }

  Future<void> deleteNote(
    String id,
  ) async {
    final url = Uri.parse(
        'https://note-app-326cf-default-rtdb.firebaseio.com/notes/$_userId/$id.json?auth=$_authToken');
    final noteIndex = notes.indexWhere((note) => note.id == id);
    // dynamic existingNote = _notes[noteIndex];
    final response = await http.delete(url);
    if (response.statusCode >= 400) {
      // _notes.insert(noteIndex, existingNote);
      throw Error();
    }
    _notes.removeAt(noteIndex);
    notifyListeners();
  }
}
