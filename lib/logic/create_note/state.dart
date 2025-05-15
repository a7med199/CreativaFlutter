class CreateNoteStates {}

class CreateNoteInitialState extends CreateNoteStates{}

class CreateNoteLoadingState extends CreateNoteStates{}

class CreateNoteSuccessState extends CreateNoteStates{}

class CreateNoteErrorState extends CreateNoteStates{
  String em;
  CreateNoteErrorState({required this.em});
}