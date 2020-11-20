

class ListModel {
  String color;
  String title;
  int id;

  ListModel({this.color, this.title, this.id});

  factory ListModel.fromMap(Map<String, dynamic> map) {
    return new ListModel(
      color: map['color'] as String,
      title: map['title'] as String,
      id: map['id'] as int,
    );
  }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_cast
    return {
      'color': this.color,
      'title': this.title,
      'id': this.id,
    } as Map<String, dynamic>;
  }
}