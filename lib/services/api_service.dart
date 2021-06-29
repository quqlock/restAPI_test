import 'dart:convert';
import 'package:rest_api_demo/models/note_details.dart';
import 'package:rest_api_demo/models/note_for_listing.dart';
import 'package:http/http.dart' as http;
import 'package:rest_api_demo/models/note_manipulation.dart';

class ApiService {
  static const API = 'tq-notes-api-jkrgrdggbq-el.a.run.app';
  static const headers = {
    'apiKey': 'd2eea2bf-b70e-407f-8ec2-ccd028d3c513',
    'Content-Type': 'application/json'
  };

  //Lista notatek
  Future<List<NoteForListing>> getNotesList() async {
    final response = await http.get(Uri.https(API, 'notes'), headers: headers);
    if (response.statusCode == 200) {
      List<dynamic> jsonData = jsonDecode(response.body);
      List<NoteForListing> notes = jsonData
          .map((dynamic item) => NoteForListing.fromJson(item))
          .toList();
      return notes;
    } else {
      throw "Failed to load list of notes";
    }
  }

  Future<NoteDetails> getNoteDetails(String noteId) async {
    final response =
        await http.get(Uri.https(API, 'notes/' + noteId), headers: headers);
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);

      return NoteDetails.fromJson(jsonData);
    } else {
      throw "Failed to load list of notes";
    }
  }

  Future<bool> createNote(NoteManipulation newNote) async {
    final response = await http.post(Uri.https(API, 'notes/'),
        headers: headers, body: json.encode(newNote.toJson()));
    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> updateNote(String noteId, NoteManipulation editedNote) async {
    final response = await http.put(Uri.https(API, 'notes/' + noteId),
        headers: headers, body: json.encode(editedNote.toJson()));
    if (response.statusCode == 204) {
      return true;
    } else {
      return false;
    }
  }
}
