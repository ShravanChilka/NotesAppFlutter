import 'package:flutter/material.dart';
import 'package:notes_flutter/models/notes_model.dart';
import 'package:notes_flutter/utils/my_database.dart';
import 'package:intl/intl.dart';

class AddNotes extends StatefulWidget {
  MyNotes? myNotes;

  AddNotes({this.myNotes});

  @override
  State<StatefulWidget> createState() {
    return AddNotesState(myNotes: myNotes!);
  }
}

class AddNotesState extends State<AddNotes> {
  final GlobalKey<ScaffoldMessengerState> rootScaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();
  final _formKey = GlobalKey<FormState>();
  late MyNotes myNotes;

  AddNotesState({required this.myNotes}) {
    updateData();
  }

  MyDatabase myDatabase = MyDatabase();
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  updateData() {
    titleController.text = myNotes.title;
    contentController.text = myNotes.content;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: rootScaffoldMessengerKey,
      appBar: AppBar(
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 20),
            child: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                //delete pressedd
                //_deleteData(context);
              },
            ),
          )
        ],
        title: const Text("Add Note"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //fab clicked
          insertData();
          //_saveDataToDatabase(context);
        },
        child: const Icon(Icons.check),
      ),
      body: addNotes(),
    );
  }

  Widget addNotes() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
            child: TextFormField(
              validator: (String? text) {
                if (text!.toString().isEmpty) {
                  return "Title cannot be empty";
                }
              },
              controller: titleController,
              style: const TextStyle(
                fontSize: 30,
                fontFamily: 'Mulish',
                fontWeight: FontWeight.w700,
              ),
              decoration: const InputDecoration(hintText: "Title"),
            ),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(left: 20, right: 20, top: 5),
              child: TextField(
                controller: contentController,
                expands: true,
                maxLines: null,
                style: const TextStyle(
                  fontSize: 20,
                  fontFamily: 'Mulish',
                  fontWeight: FontWeight.w700,
                ),
                decoration: const InputDecoration(hintText: "Content"),
              ),
            ),
          )
        ],
      ),
    );
  }

  // void _saveDataToDatabase(BuildContext context) async {
  //   moveToLastScreen();
  //   String formattedDate = DateFormat.yMMMd().format(DateTime.now());
  //   note.time = formattedDate;
  //
  //   int result;
  //   if (note.id != null) {
  //     result = await databaseHelper.updateNote(note);
  //   } else {
  //     result = await databaseHelper.updateNote(note);
  //   }
  //   if (result != 0) {
  //     if (!mounted) return;
  //     _showSnackBar(context, "Note Added");
  //   } else {
  //     if (!mounted) return;
  //     _showSnackBar(context, "Operation Failed");
  //   }
  // }

  // void _deleteData(BuildContext buildContext) async {
  //   moveToLastScreen();
  //   int result;
  //   if (note.id == null) {
  //     _showSnackBar(context, "No note was deleted");
  //     return;
  //   } else {
  //     result = await databaseHelper.deleteNote(note.id);
  //   }
  //   if (result != 0) {
  //     if (!mounted) return;
  //     _showSnackBar(context, "Note Deleted!");
  //   } else {
  //     if (!mounted) return;
  //     _showSnackBar(context, "Operation Failed");
  //   }
  // }

  void _showSnackBar(BuildContext context, String s) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(s)));
  }

  void moveToLastScreen() {
    Navigator.pop(context);
  }

  void insertData() async {
    String formattedDate = DateFormat.yMMMd().format(DateTime.now());
    if (myNotes.id == null) {
      int result = await MyDatabase.insertNote(MyNotes(
            title: titleController.text.toString(),
            content: contentController.text.toString(),
            time: formattedDate,
          )) ??
          0;
      result > 0
          ? _showSnackBar(context, "Note Saved")
          : _showSnackBar(context, "failed insert");
      moveToLastScreen();
    } else {
      debugPrint("id = ${myNotes.id}");
      int result = await MyDatabase.updateNote(MyNotes(
            id: myNotes.id,
            title: titleController.text.toString(),
            content: contentController.text.toString(),
            time: formattedDate,
          )) ??
          0;
      result > 0
          ? _showSnackBar(context, "Note Updated")
          : _showSnackBar(context, "failed update");
      moveToLastScreen();
    }
  }

  void deleteNote(MyNotes notes) async {
    int? result = await MyDatabase.deleteNote(notes) ?? 0;
    result > 0
        ? _showSnackBar(context, "Note Deleted!")
        : _showSnackBar(context, "Failed!");
    moveToLastScreen();
  }
}
