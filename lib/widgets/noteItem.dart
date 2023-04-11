import 'dart:math';

import 'package:flutter/material.dart';
import 'package:notes/models/note.dart';
import 'package:provider/provider.dart';
import '../screens/editNoteScreen.dart';

class NoteItem extends StatefulWidget {
  int? index;
  String? id;
  String? finalTitle;
  String? finalDescription;
  NoteItem(
      {Key? key, this.index, this.id, this.finalTitle, this.finalDescription})
      : super(key: key);

  @override
  State<NoteItem> createState() => _NoteItemState();
}

class _NoteItemState extends State<NoteItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: Colors.pink,
      elevation: 10,
      child: Consumer<NoteKeeper>(
        builder: (context, noteKeeper, _) => ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.deepPurpleAccent,
            child: Text(widget.index.toString()),
          ),
          title: Text(widget.finalTitle.toString()),
          subtitle: Text(
            widget.finalDescription.toString(),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(EditNoteScreen.routeName,
                        arguments: widget.id);
                  },
                  icon: Icon(
                    Icons.edit,
                    color: Colors.blue,
                  )),
              IconButton(
                  onPressed: () {
                    noteKeeper.deleteOneNote(widget.id.toString());
                  },
                  icon: Icon(
                    Icons.delete,
                    color: Colors.red,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
