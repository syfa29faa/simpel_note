import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:simple_note_app/db/database_service.dart';
import 'package:simple_note_app/extension/date.dart';
import 'package:simple_note_app/models/note.dart';
import 'package:simple_note_app/utils/app_routes.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Simple Notes',
          style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: ValueListenableBuilder(
          valueListenable: Hive.box(DatabaseService.boxName).listenable(),
          builder: (context, value, _) {
            if (value.isEmpty) {
              return const Center(
                child: Text("Tidak ada catatan"),
              );
            } else {
              return ListView.separated(
                itemBuilder: (context, index) {
                  Note tempNote = value.getAt(index);
                  return Dismissible(
                    key: Key(value.values.toList()[index].key.toString()),
                    child: NoteCard(note: tempNote),
                    onDismissed: (_) async {
                      await DatabaseService().deleteNote(tempNote);
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("Data Telah Dihapus"),
                      ));
                    },
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    height: 8,
                  );
                },
                itemCount: value.length,
              );
            }
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          GoRouter.of(context).pushNamed('add-Note').then((_) {
            setState(() {});
          });
        },
        child: const Icon(Icons.note_add),
      ),
    );
  }
}

class NoteCard extends StatelessWidget {
  const NoteCard({
    super.key,
    required this.note,
  });

  final Note note;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () {
          GoRouter.of(context).pushNamed(AppRoutes.editNote, extra: note);
        },
        title: Text(
          note.title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          note.decs,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: Text(
          "Dibuat pada \n ${note.createdAt.formatDate()}",
          textAlign: TextAlign.start,
        ),
      ),
    );
  }
}
