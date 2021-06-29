import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:rest_api_demo/models/note_for_listing.dart';
import 'package:rest_api_demo/services/api_service.dart';
import 'package:rest_api_demo/views/delete_note.dart';
import 'package:rest_api_demo/views/note_modify_page.dart';

class NotesListPage extends StatefulWidget {
  @override
  _NotesListPageState createState() => _NotesListPageState();
}

class _NotesListPageState extends State<NotesListPage> {
  bool _isLoading = false;
  List<NoteForListing> notes = [];
  ApiService get apiService => GetIt.I<ApiService>();

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
    notes = await apiService.getNotesList();
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
          ).then((_) {
            _fetchNotes();
          });
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
            itemCount: notes.length,
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
                ),
              ),
              child: ListTile(
                title: Text(
                  notes[index].noteTitle,
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
                subtitle: Text(
                    'Last edited on: ${formatDateTime(notes[index].creationDateTime)}'),
                onTap: () {
                  Navigator.of(context)
                      .push(
                    MaterialPageRoute(
                      builder: (context) => NotesModifyPage(
                        noteID: notes[index].noteID,
                      ),
                    ),
                  )
                      .then((_) {
                    _fetchNotes();
                  });
                },
              ),
            ),
            separatorBuilder: (context, _) => Divider(
              height: 1,
              color: Colors.green,
            ),
          );
        },
      ),
    );
  }
}
