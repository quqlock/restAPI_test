import 'dart:convert';
import 'package:rest_api_demo/models/note_for_listing.dart';
import 'package:http/http.dart' as http;

class NotesService {
  static const API = 'tq-notes-api-jkrgrdggbq-el.a.run.app';
  static const headers = {'apiKey': '0873e078-3564-47dd-842c-cb25001b13e3'};

  Future getNotesList() async {
    var response = await http.get(Uri.https(API, 'notes'), headers: headers);
    var jsonData = jsonDecode(response.body);
    List<NoteForListing> notes = [];
    for (var item in jsonData) {
      NoteForListing note = NoteForListing(
        noteID: item['noteID'],
        noteTitle: item['noteTitle'],
        creationDateTime: DateTime.parse(item['createDateTime']),
        latestEditDateTime: (item['latestEditDateTime'] != null)
            ? DateTime.parse(item['latestEditDateTime'])
            : DateTime.parse(item['createDateTime']),
      );
      notes.add(note);
    }

    print('Dlugosc listy: ${notes.length}');
    return notes;
  }
}
