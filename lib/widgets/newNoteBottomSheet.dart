import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/note.dart';

class NewNoteBottomSheet extends StatefulWidget {
  const NewNoteBottomSheet({super.key});

  @override
  State<NewNoteBottomSheet> createState() => _NewNoteBottomSheetState();
}

class _NewNoteBottomSheetState extends State<NewNoteBottomSheet> {
  final _form = GlobalKey<FormState>();
  String? title;
  String? description;

  void _saveForm() {
    _form.currentState!.save();
    Provider.of<NoteKeeper>(context, listen: false)
        .addProduct(title.toString(), description.toString());
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 20,
          ),
          child: Form(
            key: _form,
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(labelText: 'Title'),
                  onSaved: (newValue) {
                    title = newValue;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Description'),
                  onSaved: (newValue) {
                    description = newValue;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                TextButton(
                    onPressed: () {
                      _saveForm();
                      Navigator.of(context).pop();
                    },
                    child: Text('Add Note'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
