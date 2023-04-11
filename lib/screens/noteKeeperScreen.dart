import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:searchbar_animation/searchbar_animation.dart';
import '../models/note.dart';
import '../widgets/newNoteBottomSheet.dart';
import '../widgets/noteList.dart';

class NoteKeeperScreen extends StatefulWidget {
  const NoteKeeperScreen({super.key});
  static const routeName = '/noteKeeperScreen';

  @override
  State<NoteKeeperScreen> createState() => _NoteKeeperScreenState();
}

class _NoteKeeperScreenState extends State<NoteKeeperScreen> {
  var _isInit = true;
  var _isLoading = false;
  Map fetchDataHive = {};

  @override
  void didChangeDependencies() {
    if (_isInit) {
      _isLoading = true;
      Provider.of<NoteKeeper>(context).fetchAndSetNotes();
      _isLoading = false;
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  void _addNotes(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return NewNoteBottomSheet();
      },
    );
  }

  final textEdctrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Notes',
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                Provider.of<NoteKeeper>(context, listen: false)
                    .deleteAllNotes();
              },
              icon: Icon(Icons.delete_forever))
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(8),
          child: Column(
            children: [
              Consumer<NoteKeeper>(
                builder: (context, noteKeeper, _) {
                  return SearchBarAnimation(
                      enableKeyboardFocus: true,
                      textInputType: TextInputType.name,
                      onSaved: (value) => noteKeeper.searchNote(value),
                      onFieldSubmitted: (value) => noteKeeper.searchNote(value),
                      onChanged: (value) => noteKeeper.searchNote(value),
                      enableBoxBorder: true,
                      buttonShadowColour: Colors.pink,
                      textEditingController: textEdctrl,
                      isOriginalAnimation: false,
                      trailingWidget: const Icon(Icons.mic),
                      secondaryButtonWidget: const Icon(
                        Icons.cancel,
                        color: Colors.pink,
                      ),
                      durationInMilliSeconds: 350,
                      buttonWidget: const Icon(
                        Icons.search,
                        color: Colors.pink,
                      ));
                },
              ),
              SizedBox(
                height: 10,
              ),
              Container(height: 500, child: NoteList()),
            ],
          ),
        ),
      ),
      /*_isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : const NoteList(), */
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addNotes(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
