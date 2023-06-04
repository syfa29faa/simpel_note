import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../models/note.dart';
import '../pages/home_page.dart';
import '../pages/add_note_page.dart';

class AppRoutes {
  static String home = 'home';
  static String addNote = 'add-Note';
  static String editNote = 'edit-Note';

  static Page _homePageBuilder(
    BuildContext context,
    GoRouterState state,
  ) {
    return const MaterialPage(
      child: HomePage(),
    );
  }

  static Page _addNotePageBuilder(
    BuildContext context,
    GoRouterState state,
  ) {
    return const MaterialPage(
      child: AddNotePage(),
    );
  }

  static Page _editNotePageBuilder(
    BuildContext context,
    GoRouterState state,
  ) {
    return MaterialPage(
      child: AddNotePage(note: state.extra as Note),
    );
  }

  static GoRouter goRouter = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(name: home, path: '/', pageBuilder: _homePageBuilder, routes: [
        GoRoute(
            path: 'add-Note', name: addNote, pageBuilder: _addNotePageBuilder),
        GoRoute(
            path: 'edit-Note',
            name: editNote,
            pageBuilder: _editNotePageBuilder),
      ])
    ],
  );
}
