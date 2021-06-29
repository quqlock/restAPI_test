class NoteDetails {
  final String noteID;
  final String noteTitle;
  final String noteContent;
  final DateTime creationDateTime;
  final DateTime latestEditDateTime;

  NoteDetails({
    required this.noteID,
    required this.noteTitle,
    required this.noteContent,
    required this.creationDateTime,
    required this.latestEditDateTime,
  });

  factory NoteDetails.fromJson(Map<String, dynamic> jsonData) {
    return NoteDetails(
        noteID: jsonData['noteID'],
        noteTitle:
            (jsonData['noteTitle'] == null) ? 'NULL' : jsonData['noteTitle'],
        noteContent: jsonData['noteContent'],
        creationDateTime: DateTime.parse(jsonData['createDateTime']),
        latestEditDateTime: (jsonData['latestEditDateTime']) != null
            ? DateTime.parse(jsonData['latestEditDateTime'])
            : DateTime.parse(jsonData['createDateTime']));
  }

  factory NoteDetails.fromMap(Map<String, dynamic> jsonData) {
    return NoteDetails(
        noteID: jsonData['noteID'],
        noteTitle: jsonData['noteTitle'],
        noteContent: jsonData['noteContent'],
        creationDateTime: DateTime.parse(jsonData['createDateTime']),
        latestEditDateTime: DateTime.parse(jsonData['latestEditDateTime']));
  }
}
