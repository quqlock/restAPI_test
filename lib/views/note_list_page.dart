import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:rest_api_demo/models/note_for_listing.dart';
import 'package:http/http.dart' as http;
import 'package:rest_api_demo/services/notes_service.dart';
import 'package:rest_api_demo/views/delete_note.dart';
import 'package:rest_api_demo/views/note_modify_page.dart';

class NotesListPage extends StatefulWidget {
  @override
  _NotesListPageState createState() => _NotesListPageState();
}

class _NotesListPageState extends State<NotesListPage> {
  bool _isLoading = false;
  List<NoteForListing> notes = [];
  NotesService service = NotesService();

  String formatDateTime(DateTime dateTime) {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
  }

  @override
  void initState() {
    _fetchNotes();

    super.initState();
  }

  _fetchNotes() async {
    setState(() {
      _isLoading = true;
    });
    notes = await service.getNotesList();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notes List Page'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NotesModifyPage(),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
      body: Builder(
        builder: (context) {
          if (_isLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.separated(
            itemBuilder: (context, index) => Dismissible(
              key: ValueKey(notes[index].noteID),
              direction: DismissDirection.startToEnd,
              onDismissed: (direction) {},
              confirmDismiss: (direction) async {
                final result = await showDialog(
                  context: context,
                  builder: (context) => DeleteNote(),
                );

                return result;
              },
              background: Container(
                  padding: EdgeInsets.only(left: 15),
                  color: Colors.red,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                  )),
              child: ListTile(
                title: Text(
                  notes[index].noteTitle,
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
                subtitle: Text(
                    'Last edited on: ${formatDateTime(notes[index].creationDateTime)}'),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => NotesModifyPage(
                        noteID: notes[index].noteID,
                      ),
                    ),
                  );
                },
              ),
            ),
            separatorBuilder: (context, _) => Divider(
              height: 1,
              color: Colors.green,
            ),
            itemCount: notes.length,
          );
        },
      ),
    );
  }
}