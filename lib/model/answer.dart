// ignore_for_file: non_constant_identifier_names

class Answer {
  int? id;
  int question_id;
  String? qnswer_text;
  bool is_correct;

  //! Virtual Propierties
  bool selected;
  Answer({
    this.id = 0,
    this.question_id = 0,
    this.qnswer_text = '',
    this.is_correct = false,

    ///!  Virtual Propierties
    this.selected = false,
  });

  factory Answer.fromJson(Map<String, dynamic> json) => Answer(
        id: json["id"] ?? 0,
        question_id: json["question_id"] ?? 0,
        qnswer_text: json["answer_text"] ?? '',
        is_correct: json["is_correct"] ?? false,
      );
  Map<String, dynamic> toJson() => {
        "id": id,
        "question_id": question_id,
        "answer_text": qnswer_text,
        "is_correct": is_correct,
      };
}
