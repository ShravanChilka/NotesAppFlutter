import 'package:flutter/material.dart';
import 'package:notes_flutter/screens/add_screen.dart';
import 'package:notes_flutter/utils/my_database.dart';
import 'package:notes_flutter/models/notes_model.dart';

class NotesScreen extends StatefulWidget {
  final GlobalKey<ScaffoldMessengerState> rootScaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  //late Note note ;

  @override
  State<StatefulWidget> createState() {
    return NotesScreenState();
  }
}

class NotesScreenState extends State<NotesScreen> {
  MyDatabase myDatabase = MyDatabase();
  List<MyNotes> noteList = <MyNotes>[];
  int count = 0;

  @override
  Widget build(BuildContext context) {
    updateList();

    return Scaffold(
      appBar: AppBar(
        title: const Text("MyNotes"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          navigateToAddScreen(const MyNotes(title: "", content: ""));
        },
        child: const Icon(Icons.add),
      ),
      body: getNotesList(),
    );
  }

  ListView getNotesList() {
    return ListView.builder(
      itemBuilder: (BuildContext context, int pos) {
        return GestureDetector(
          onTap: () {
            navigateToAddScreen(noteList[pos]);
          },
          child: Card(
            color: Colors.black45,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 5, right: 5, top: 5),
                      padding:
                          const EdgeInsets.only(left: 10, right: 10, top: 5),
                      child: Text(
                        noteList[pos].title,
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w500,
                        ),
                        textDirection: TextDirection.ltr,
                      ),
                    ),
                    const Spacer(),
                    Container(
                      // margin: const EdgeInsets.only(right: 10, top: 10),
                      padding: const EdgeInsets.all(3),
                      child: IconButton(
                        onPressed: () {
                          //delete
                          deleteNote(noteList[pos]);
                          //   _deleteNote(context, noteList[pos]);
                        },
                        icon: const Icon(Icons.delete),
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(left: 5, right: 5, bottom: 5),
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    noteList[pos].content,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w300),
                  ),
                ),
                Container(
                  alignment: AlignmentDirectional.bottomEnd,
                  margin: const EdgeInsets.only(right: 10, bottom: 10),
                  child: Text(
                    noteList[pos].time ?? "",
                    style: const TextStyle(
                      color: Colors.white60,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      itemCount: count,
    );
  }

  void navigateToAddScreen(MyNotes myNotes) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return AddNotes(myNotes: myNotes,);
    }));
  }

  void updateList() {
    getData();
  }

  void getData() async {
    List<MyNotes> notes = await MyDatabase.getAll() ?? [];

    setState(() {
      noteList = notes;
      count = notes.length;
    });
  }

  void deleteNote(MyNotes notes) async {
    int? result = await MyDatabase.deleteNote(notes) ?? 0;
    result > 0
        ? _showSnackBar(context, "Note Deleted!")
        : _showSnackBar(context, "Failed!");
    updateList();
  }

  void _showSnackBar(BuildContext context, String s) {
    ScaffoldMessenger.of(context)..hideCurrentSnackBar()..showSnackBar(SnackBar(content: Text(s)));
  }

}
