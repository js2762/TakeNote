import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../helpers/sql_helper.dart';
//import '../helpers/hive_helper.dart';
import '../helpers/hive_new_helper.dart';

part 'note.g.dart';

@HiveType(typeId: 1)
class Notes extends HiveObject {
  @HiveField(0)
  final String? id;
  @HiveField(1)
  String? title;
  @HiveField(2)
  String? description;
  //final DateTime? date;
  Notes({this.id, this.title, this.description});
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

  //final ob = HiveBox();
  final ob2 = HiveNewBox();

  void addProduct(String title, String description) {
    final newNote = Notes(
      id: DateTime.now().toString(),
      title: title,
      description: description,
    );
    _items.add(newNote);
    //print(_items);
    notifyListeners();
    /* SQLHelper.insert('keep_note', {
      'id': newNote.id.toString(),
      'title': newNote.title.toString(),
      'description': newNote.description.toString()
    }); */

    ob2.writeData(newNote.id.toString(), newNote);

    /* Map<dynamic, dynamic> getDataHive =
        ob.writeData(newNote.id.toString(), newNote);
    print(getDataHive); */
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
      /* SQLHelper.update(
          'keep_note', {'id': id, 'title': title, 'description': description});
      notifyListeners(); */
      ob2.updateData(id, title, description);
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
    /* SQLHelper.deleteSingleNote('keep_note', id);
    notifyListeners(); */
    ob2.deleteData(id);
  }

  void deleteAllNotes() {
    _items.clear();
    notifyListeners();
    /* SQLHelper.deleteTable('keep_note');
    notifyListeners(); */
    ob2.deleteAllData();
  }
  //
  //
  //

  Notes findById(String id) {
    return _items.firstWhere((element) => element.id == id);
  }

  //
  //
  //

  void fetchAndSetNotes() {
    List<Notes> fetchItem = ob2.fetchData();
    _items = fetchItem;
  }

  /* Future<void> fetchAndSetNotes() async {
    final getNoteList = await SQLHelper.getData('keep_note');
    _items = getNoteList
        .map(
          (e) => Notes(
            id: e['id'],
            title: e['title'],
            description: e['description'],
          ),
        )
        .toList();
    //print(_items);
    notifyListeners();

    //print(_items);

    //var dnmc = ob2.fetchData().cast<Notes>();

    /* List<Notes> fetchItems = fetchNoteList
        .map((element) => Notes(
              title: element['title'],
              description: element['description'],
            ))
        .toList(); */
  } */
}
