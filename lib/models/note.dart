import 'package:hive/hive.dart';

part 'note.g.dart';

@HiveType(typeId: 0)
class Note extends HiveObject {
  @HiveField(0)
  late final String title;
  @HiveField(1)
  late final String decs;
  @HiveField(2)
  late final DateTime createdAt;

  Note({
    required this.title,
    required this.decs,
    required this.createdAt,
  });
}



// class Note {
//   int id;
//   final String title;
//   String description;
//   DateTime createdAt;

//   Note(
//     this.id,
//     this.title,
//     this.description,
//     this.createdAt,
//   );

//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'title': title,
//       'description': description,
//       'createdAt': createdAt.toIso8601String(),
//     };
//   }
// }
