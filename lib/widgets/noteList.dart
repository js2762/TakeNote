import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/note.dart';
import '../widgets/noteItem.dart';

class NoteList extends StatelessWidget {
  //Map fetchDataHive = {};
  @override
  Widget build(BuildContext context) {
    List<Notes> notes = Provider.of<NoteKeeper>(context).items;
    List<Notes> searchedNotes = Provider.of<NoteKeeper>(context).searchItems;
    //fetchDataHive = Provider.of<NoteKeeper>(context).getDataHive;

    return ListView.builder(
      itemCount: searchedNotes.isEmpty ? notes.length : searchedNotes.length,
      itemBuilder: (context, index) {
        return Column(
          children: [
            searchedNotes.isEmpty
                ? NoteItem(
                    key: ValueKey(notes[index].id),
                    index: (index + 1),
                    id: notes[index].id,
                    finalTitle: notes[index].title.toString(),
                    finalDescription: notes[index].description.toString(),
                  )
                : NoteItem(
                    key: ValueKey(searchedNotes[index].id),
                    index: (index + 1),
                    id: searchedNotes[index].id,
                    finalTitle: searchedNotes[index].title.toString(),
                    finalDescription:
                        searchedNotes[index].description.toString(),
                  ),
            SizedBox(
              height: 10,
            )
          ],
        );
      },
    );
  }
}
