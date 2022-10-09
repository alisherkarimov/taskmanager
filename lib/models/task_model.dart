class Task {
  int? id;
  String? name;
  String? description;
  String? startTime;
  String? endTime;

  Task({this.description, this.name, this.endTime, this.startTime});

  Task.withId(
      {this.id, this.description, this.name, this.endTime, this.startTime});

  Map<String, Object?> toMap() {
    var map = <String, Object?>{
      "name": name,
      "startTime": startTime,
      "endTime": endTime,
      "description": description,
    };
    if (id != null) {
      map['id'] = id;
    }
    return map;
  }

  Task.fromMap(Map<String, Object?> map) {
    id = map['id'] as int?;
    name = map['name'] as String?;
    startTime = map['startTime'] as String?;
    endTime = map['endTime'] as String?;
    description = map["description"] as String?;
  }
}
