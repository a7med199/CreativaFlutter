import 'package:flutter/cupertino.dart';
import 'package:untitled1/data/note_model.dart';

@immutable
abstract class GetNoteStates {}

class GetNoteInitialState extends GetNoteStates {}
class GetNoteLoadingState extends GetNoteStates {}

class GetNoteSuccessState extends GetNoteStates {
  final List<NoteModel> notesData;
  GetNoteSuccessState({required this.notesData});
}

class GetNoteErrorState extends GetNoteStates {
  final String message;
  GetNoteErrorState({required this.message});
}