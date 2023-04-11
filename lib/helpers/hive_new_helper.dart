import 'package:hive/hive.dart';
import '../models/note.dart';

class HiveNewBox {
  final _myBox = Hive.box<Notes>('myBox');

  void writeData(String id, Notes notes) {
    _myBox.put(id, notes);
  }

  fetchData() {
    List<Notes> fetchValues = _myBox.values.toList().cast<Notes>();
    return fetchValues;
  }

  void deleteData(String id) {
    _myBox.delete(id);
  }

  void deleteAllData() {
    _myBox.clear();
  }

  void updateData(String id, String title, String description) {
    Notes? item = _myBox.get(id);
    item!.title = title;
    item.description = description;
    _myBox.put(id, item);
  }
}
