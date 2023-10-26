// ignore_for_file: non_constant_identifier_names

class Assignment {
  int? id;
  String? title;
  String? description;
  String? deadline;

  Assignment({
    this.id,
    this.title,
    this.description,
    this.deadline,
  });

  factory Assignment.fromJson(Map<String, dynamic> obj) {
    return Assignment(
      id: obj['id'],
      title: obj['title'],
      description: obj['description'],
      deadline: obj['deadline'],
    );
  }
}
