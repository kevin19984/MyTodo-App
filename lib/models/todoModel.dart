class Todo {
  int id;
  String work;
  DateTime deadline;

  Todo({ this.id, this.work, this.deadline });

  Map<String, dynamic> toMap() {
    return {
      'id' : id,
      'work': work,
      'deadline': deadline,
    };
  }
}