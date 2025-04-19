class Task {
  String? title;
  String? description;
  String? id;
  int? date;
  int? time;

  Task({this.description, this.title, this.time, this.date, this.id});

  Task.fromFireStore(Map<String, dynamic>? data)
    : this(
        description: data?['description'],
        title: data?['title'],
        time: data?['time'],
        date: data?['date'],
        id: data?['id'],
      );

  Map<String, dynamic> toFireStore() {
    return {
      'description': description,
      'title': title,
      'time': time,
      'date': date,
      'id': id,
    };
  }
}
