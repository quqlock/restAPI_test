import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:rest_api_demo/models/note_details.dart';
import 'package:rest_api_demo/services/api_service.dart';

class NotesModifyPage extends StatefulWidget {
  final String? noteID;
  NotesModifyPage({this.noteID});

  @override
  _NotesModifyPageState createState() => _NotesModifyPageState();
}

class _NotesModifyPageState extends State<NotesModifyPage> {
  ApiService get apiService => GetIt.I<ApiService>();
  NoteDetails? _noteDetails;
  final _noteTitleController = TextEditingController();
  final _noteContentController = TextEditingController();

  bool _isLoading = false;

  //Check if editing or adding new note
  bool get _isEditing => widget.noteID != null;

  @override
  void initState() {
    super.initState();

    if (_isEditing) {
      setState(() {
        _isLoading = true;
      });
      apiService.getNoteDetails(widget.noteID!).then((resposne) {
        _noteDetails = resposne;
        _noteTitleController.text = _noteDetails!.noteTitle;
        _noteContentController.text = _noteDetails!.noteContent;
        setState(() {
          _isLoading = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isEditing == true) {}

    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditing ? 'Edit note' : 'Create note'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: (_isLoading)
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: [
                  TextField(
                    decoration: InputDecoration(hintText: 'Note title'),
                    controller: _noteTitleController,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    decoration: InputDecoration(hintText: 'Content'),
                    controller: _noteContentController,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    height: 55,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_isEditing) {
                          //update note in API
                        } else {
                          //create note in API
                        }
                        Navigator.of(context).pop();
                      },
                      child: Text('Submit note'),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
