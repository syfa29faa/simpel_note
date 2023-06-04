import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:simple_note_app/db/database_service.dart';
import '../models/note.dart';

class AddNotePage extends StatefulWidget {
  const AddNotePage({
    super.key,
    this.note,
  });

  final Note? note;

  @override
  State<AddNotePage> createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late TextEditingController _titleController;
  late TextEditingController _descController;

  final DatabaseService dbService = DatabaseService();

  @override
  void initState() {
    _titleController = TextEditingController();
    _descController = TextEditingController();
    super.initState();

    if (widget.note != null) {
      _titleController.text = widget.note!.title;
      _descController.text = widget.note!.decs;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.note != null ? "Edit Note" : "Add Note",
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                validator: (value) {
                  if (value == '') {
                    return "Judul tidak boleh kosong";
                  } else {
                    return null;
                  }
                },
                controller: _titleController,
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: "Masukan Judul",
                    hintStyle:
                        TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                maxLines: null,
              ),
              TextFormField(
                validator: (value) {
                  if (value == '') {
                    return "Deskripsi tidak boleh kosong";
                  } else {
                    return null;
                  }
                },
                controller: _descController,
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: "Masukan Deksripsi",
                    hintStyle: TextStyle(
                      fontSize: 14,
                    )),
                style: const TextStyle(
                  fontSize: 14,
                ),
                maxLines: null,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            Note tempNote = Note(
              title: _titleController.text,
              decs: _descController.text,
              createdAt: DateTime.now(),
            );
            if (widget.note != null) {
              dbService.editNote(widget.note!.key, tempNote).then((_) {
                GoRouter.of(context).pop();
              });
            } else {
              await dbService.addNote(tempNote).then((_) {
                GoRouter.of(context).pop();
              });
            }
          }
        },
        label: const Text('Simpan'),
        icon: const Icon(Icons.save),
      ),
    );
  }
}
