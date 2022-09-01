class MyNotes {
  final int? id;
  final String title;
  final String content;
  final String? time;

  const MyNotes({
    this.id,
    required this.title,
    required this.content,
    this.time,
  });

  // Convert a Dog into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'time': time
    };
  }


  static MyNotes fromMap(Map<String, dynamic> map) {
    return MyNotes(
      id: map["id"],
      title: map["title"].toString(),
      content: map["content"].toString(),
      time: map["time"].toString(),
    );
  }
}