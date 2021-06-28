import 'package:flutter/material.dart';

class NotesModifyPage extends StatelessWidget {
  final String? noteID;
  bool get isEditing => noteID != null;

  NotesModifyPage({this.noteID});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Edit note' : 'Create note'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(hintText: 'Note title'),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              decoration: InputDecoration(hintText: 'Content'),
            ),
            SizedBox(
              height: 15,
            ),
            SizedBox(
              height: 55,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (isEditing) {
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
