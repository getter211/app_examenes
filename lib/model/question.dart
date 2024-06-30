// ignore_for_file: non_constant_identifier_names


import 'package:app_examenes/model/answer.dart';

class Questions {
  int id;
  String? question_text;
 List <Answer>? answers;
 
  //! Virtual Propierties
  bool selected;
  Questions({
    this.id = 0,
    this.question_text = '',
    this.answers,
    this.selected = false,
  });

  factory Questions.fromJson(Map<String, dynamic> json) => Questions(
        id: json["id"] ?? 0,
        question_text: json["question_text"] ?? '',
        answers: json['answers'] == null
            ? null
            : List<Answer>.from(
                json['answers'].map(
                  (x) => Answer.fromJson(x),
                ),
              ),
      );
  Map<String, dynamic> toJson() => {
        "id": id,
        "question_text": question_text,
"answers": answers?.map((e) => e.toJson()).toList(),
      };
}