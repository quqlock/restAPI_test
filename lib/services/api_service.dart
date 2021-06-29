import 'dart:convert';
import 'package:rest_api_demo/models/note_for_listing.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const API = 'tq-notes-api-jkrgrdggbq-el.a.run.app';
  static const headers = {'apiKey': '0873e078-3564-47dd-842c-cb25001b13e3'};

  Future<List<NoteForListing>> getNotesList() async {
    var response = await http.get(Uri.https(API, 'notes'), headers: headers);
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      List<NoteForListing> notes =
          body.map((dynamic item) => NoteForListing.fromJson(item)).toList();
      return notes;
    } else {
      throw "Failed to load list of notes";
    }
  }
}
