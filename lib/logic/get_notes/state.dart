import 'package:flutter/cupertino.dart';
import 'package:untitled1/data/note_model.dart';

@immutable
class GetNoteDataStates {}

class GetNoteInitialState extends GetNoteDataStates{}

class GetNoteLoadingState extends GetNoteDataStates{}

class GetNoteSuccessState extends GetNoteDataStates{
  List <NoteModel> notes;
  GetNoteSuccessState ({required this.notes});
}

class GetNoteErrorState extends GetNoteDataStates{
  final String em;
  GetNoteErrorState(this.em);
}