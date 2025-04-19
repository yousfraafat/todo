class Task {
  String? title;
  String? description;
  String? id;
  int? date;
  int? time;
  bool? isDone;

  Task(
      {this.description, this.title, this.time, this.date, this.id, this.isDone = false});

  Task.fromFireStore(Map<String, dynamic>? data)
    : this(
      description: data?['description'],
      title: data?['title'],
      time: data?['time'],
      date: data?['date'],
      id: data?['id'],
      isDone: data?['isDone']
      );

  Map<String, dynamic> toFireStore() {
    return {
      'description': description,
      'title': title,
      'time': time,
      'date': date,
      'id': id,
      'isDone': isDone
    };
  }
}
