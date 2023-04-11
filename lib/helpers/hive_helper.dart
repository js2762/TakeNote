import 'package:hive/hive.dart';
import '../models/note.dart';

class HiveBox {
  final _myBox = Hive.box('myBox');
  Map result = {};
  //
  writeData(String id, Notes notes) {
    _myBox.put(id, [notes.title, notes.description]);
    return getData(id);
  }

  getData(String id) {
    final getData = _myBox.get(id);
    result['$id'] = getData as List;
    return result;
  }

  fetchData() {
    return _myBox.get(1);
  }
}
