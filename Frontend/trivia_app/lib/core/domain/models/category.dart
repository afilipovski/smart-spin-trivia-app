import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:trivia_app/core/domain/models/choice.dart';

part 'category.g.dart';

// List<Question>? constListOfQuestions = const [
//   Question(
//     categoryId: '3',
//     category: Category(id: '3', name: 'Music'),
//     id: '1',
//     content: 'Who wrote Bohemian Rhapsody?',
//     choices: [
//       Choice(id: '1', content: 'Ozzy Osbourne', isCorrect: false),
//       Choice(id: '1', content: 'John Lennon', isCorrect: false),
//       Choice(id: '1', content: 'Freddie Mercury', isCorrect: true),
//     ],
//   ),
//   Question(
//     categoryId: '1',
//     category: Category(id: '1', name: 'Animals'),
//     id: '2',
//     content: 'Which animal is the smallest mammal?',
//     choices: [
//       Choice(id: '1', content: 'Etruscan shrew', isCorrect: true),
//       Choice(id: '1', content: 'Hamster', isCorrect: false),
//       Choice(id: '1', content: 'Guinea pig', isCorrect: false),
//     ],
//   ),
//   Question(
//     categoryId: '2',
//     category: Category(id: '2', name: 'Movies'),
//     id: '3',
//     content: 'How many Oscars have Johnny Depp won?',
//     choices: [
//       Choice(id: '1', content: 'Zero', isCorrect: true),
//       Choice(id: '1', content: 'One', isCorrect: false),
//       Choice(id: '1', content: 'Three', isCorrect: false),
//     ],
//   ),
// ];

@JsonSerializable()
class Category extends Equatable {
  final String id;
  final String name;
  // final List<Question>? questions;

  const Category({
    required this.id,
    required this.name,
    // this.questions = const [],
  });

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryToJson(this);

  @override
  List<Object?> get props => [id];
}
