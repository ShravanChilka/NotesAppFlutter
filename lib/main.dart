import 'package:flutter/material.dart';
import 'package:notes_flutter/screens/notes_screen.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      colorScheme: const ColorScheme.dark().copyWith(
        primary: const Color.fromARGB(255, 242, 245, 234),
        secondary: const Color.fromARGB(255, 231, 90, 124),
        background: const Color.fromARGB(255, 44, 54, 63),
      ),
    ),
    title: "My Notes",
    home: NotesScreen(),
  ));
}
