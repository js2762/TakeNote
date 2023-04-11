import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
//import 'package:hive/hive.dart';
import './models/note.dart';
import './screens/noteKeeperScreen.dart';
import './screens/editNoteScreen.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(NotesAdapter());

  await Hive.openBox<Notes>('myBox'); // to open the box

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: NoteKeeper(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.purple,
        ),
        home: NoteKeeperScreen(),
        routes: {
          NoteKeeperScreen.routeName: (context) => NoteKeeperScreen(),
          EditNoteScreen.routeName: (context) => EditNoteScreen(),
        },
      ),
    );
  }
}
