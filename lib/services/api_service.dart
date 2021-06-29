import 'dart:convert';
import 'package:rest_api_demo/models/note_details.dart';
import 'package:rest_api_demo/models/note_for_listing.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const API = 'tq-notes-api-jkrgrdggbq-el.a.run.app';
  static const headers = {'apiKey': '0873e078-3564-47dd-842c-cb25001b13e3'};

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
}
