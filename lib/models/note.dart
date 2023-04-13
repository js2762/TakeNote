import 'dart:async';
import 'package:flutter/material.dart';
import 'package:floor/floor.dart';
//import 'package:notes/screens/noteKeeperScreen.dart';
//import '../dao/noteDAO.dart';
import '../helpers/app_database.dart';

@Entity(tableName: 'notes')
class Notes {
  @PrimaryKey(autoGenerate: false)
  String? id;
  String? title;
  String? description;
  //final DateTime? date;
  Notes({required this.id, this.title, this.description});
}

class NoteKeeper with ChangeNotifier {
  List<Notes> _items = [];

  List<Notes> _searchedData = [];

  List<Notes> get items {
    return [..._items];
  }

  List<Notes> get searchItems {
    return [..._searchedData];
  }

  final ob = databaseMethods();

  void addProduct(String title, String description) {
    final newNote = Notes(
      id: DateTime.now().toString(),
      title: title,
      description: description,
    );
    _items.add(newNote);

    //print(_items);
    notifyListeners();
    ob.addNote(newNote.id.toString(), title, description);

    //print(_items);
  }
  //
  //
  //

  void updateNote(String id, String title, String description) {
    final noteIndex = _items.indexWhere((element) => element.id == id);
    if (noteIndex >= 0) {
      _items[noteIndex].title = title;
      _items[noteIndex].description = description;
      notifyListeners();
      ob.updateNote(id, title, description);

      //notifyListeners();
      //print(_items);
    } else {
      print('something went wrong.....');
    }
  }
  //
  //
  //

  searchNote(String value) {
    _searchedData.clear();
    if (value.isEmpty) {
      notifyListeners();
      return;
    } else {
      for (var element in items) {
        if (element.title!.toLowerCase().contains(
            value.toLowerCase().trim().replaceAll(RegExp(r'\b\s+\b'), ''))) {
          _searchedData.add(element);
        }
      }
      notifyListeners();
    }
  }

  //
  //
  //
  void deleteOneNote(String id) {
    _items.removeWhere((element) => element.id == id);
    notifyListeners();
    ob.deleteNote(id);
  }

  void deleteAllNotes() {
    _items.clear();
    notifyListeners();
    ob.deleteAllNotes();
  }
  //
  //
  //

  Notes findById(String id) {
    return _items.firstWhere((element) => element.id == id);
  }

  //ee
  //
  //

  fetchAndSetNotes() async {
    Future<dynamic> fetchItem = ob.fetchNotes();
    List<Notes> notes = await fetchItem;
    _items = notes;
    notifyListeners();
    //print(_items);
  }
}
