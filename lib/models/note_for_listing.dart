class NoteForListing {
  String noteID;
  String noteTitle;
  DateTime creationDateTime;
  DateTime latestEditDateTime;

  NoteForListing({
    required this.noteID,
    required this.noteTitle,
    required this.creationDateTime,
    required this.latestEditDateTime,
  });
}
