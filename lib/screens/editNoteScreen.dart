import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/note.dart';

class EditNoteScreen extends StatefulWidget {
  const EditNoteScreen({super.key});
  static const routeName = '/editNoteScreen';

  @override
  State<EditNoteScreen> createState() => _EditNoteScreenState();
}

class _EditNoteScreenState extends State<EditNoteScreen> {
  final _form = GlobalKey<FormState>();
  String? initialTitle;
  String? initialDescription;
  String? noteId;
  String? saveTitle;
  String? saveDescription;

  var _isInit = true;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      noteId = ModalRoute.of(context)!.settings.arguments.toString();
      final note = Provider.of<NoteKeeper>(context).findById(noteId.toString());
      initialTitle = note.title;
      initialDescription = note.description;
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  void _saveForm() {
    _form.currentState!.save();
    Provider.of<NoteKeeper>(context, listen: false).updateNote(
        noteId.toString(), saveTitle.toString(), saveDescription.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Your Note'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          height: 230,
          child: Card(
            shadowColor: Colors.pink,
            elevation: 10,
            margin: EdgeInsets.all(10),
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Form(
                key: _form,
                child: Column(
                  children: [
                    TextFormField(
                      initialValue: initialTitle,
                      decoration: InputDecoration(labelText: 'Title'),
                      onSaved: (newValue) {
                        saveTitle = newValue;
                      },
                    ),
                    TextFormField(
                      initialValue: initialDescription,
                      decoration: InputDecoration(labelText: 'Description'),
                      onSaved: (newValue) {
                        saveDescription = newValue;
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    // Text(noteId.toString()),
                    TextButton(
                        onPressed: () {
                          _saveForm();
                          Navigator.of(context).pop();
                        },
                        child: Text('Save Note'))
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
