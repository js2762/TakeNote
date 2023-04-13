import 'package:floor/floor.dart';
import '../models/note.dart';

@dao
abstract class NoteDAO {
  @Query('SELECT * FROM notes')
  Future<List<Notes>> getAllNotes();

  @Query('DELETE FROM notes')
  Future<void> deleteAllNotes();

  @insert
  Future<void> insertNote(Notes note);

  @Query('SELECT * FROM notes WHERE id = :id')
  Future<Notes?> findNoteById(String id);

  @delete
  Future<void> deleteNote(Notes note);

  @update
  Future<void> updateNote(Notes note);
}
