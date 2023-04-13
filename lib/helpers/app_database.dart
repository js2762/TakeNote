import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import '../models/note.dart';
import '../dao/noteDAO.dart';

part 'app_database.g.dart';

@Database(version: 1, entities: [Notes])
abstract class AppDatabase extends FloorDatabase {
  NoteDAO get noteDao;
}

class databaseMethods {
  var _myDatabase = $FloorAppDatabase.databaseBuilder('my_database.db').build();

  Future<void> addNote(String id, String title, String description) async {
    final _noteDao = (await _myDatabase).noteDao;
    final note = Notes(id: id, title: title, description: description);
    await _noteDao.insertNote(note);
  }

  fetchNotes() async {
    final _noteDao = (await _myDatabase).noteDao;
    final noteList = await _noteDao.getAllNotes();
    return noteList;
  }

  deleteNote(String id) async {
    final _noteDao = (await _myDatabase).noteDao;
    final deleteNote = await _noteDao.findNoteById(id);
    //print(deleteNote);
    await _noteDao.deleteNote(deleteNote as Notes);
  }

  deleteAllNotes() async {
    final _noteDao = (await _myDatabase).noteDao;
    await _noteDao.deleteAllNotes();
  }

  updateNote(String id, String title, String description) async {
    final _noteDao = (await _myDatabase).noteDao;
    final updatedNote = await _noteDao.findNoteById(id);
    updatedNote!.title = title;
    updatedNote.description = description;
    await _noteDao.updateNote(updatedNote);
  }
}
