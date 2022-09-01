//
// class Note {
//   int? _id = 0;
//   String _title;
//   String? _content;
//   String _time;
//
//   Note.withId(this._id, this._title, this._time, [this._content]);
//
//   Note(this._title, this._time, this._content);
//
//   get id => _id; //Function to convert Model into Map
//   Map<String, dynamic> toMap() {
//     var map = <String, dynamic>{};
//     if(id != null){
//       map["id"] = _id;
//     }
//     map["title"] = _title;
//     map["content"] = _content;
//     map["time"] = _time;
//
//     return map;
//   }
//
//   Note.fromMapObject(Map<String,dynamic> map){
//     _id = map["id"];
//     _title = map["title"];
//     _content = map["content"];
//     _time = map["time"];
//   }
//
//   get title => _title;
//
//   get content => _content;
//
//   get time => _time;
//
//   set time(value) {
//     _time = value;
//   }
//
//   set content(value) {
//     _content = value;
//   }
//
//   set title(value) {
//     _title = value;
//   }
//
// }
