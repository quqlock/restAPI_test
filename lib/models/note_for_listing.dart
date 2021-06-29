class NoteForListing {
  final String noteID;
  final String noteTitle;
  final DateTime creationDateTime;
  final DateTime latestEditDateTime;

  NoteForListing({
    required this.noteID,
    required this.noteTitle,
    required this.creationDateTime,
    required this.latestEditDateTime,
  });

  factory NoteForListing.fromJson(Map<String, dynamic> json) {
    return NoteForListing(
        noteID: json['noteID'],
        noteTitle: (json['noteTitle'] == null) ? 'NULL' : json['noteTitle'],
        creationDateTime: DateTime.parse(json['createDateTime']),
        latestEditDateTime: (json['latestEditDateTime']) != null
            ? DateTime.parse(json['latestEditDateTime'])
            : DateTime.parse(json['createDateTime']));
  }

  factory NoteForListing.fromMap(Map<String, dynamic> json) {
    return NoteForListing(
        noteID: json['noteID'],
        noteTitle: json['noteTitle'],
        creationDateTime: DateTime.parse(json['createDateTime']),
        latestEditDateTime: DateTime.parse(json['latestEditDateTime']));
  }
}
