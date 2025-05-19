class CreateNoteStates {}

class CreateNoteInitialState extends CreateNoteStates{}

class CreateNoteLoadingState extends CreateNoteStates{}

class CreateNoteSuccessState extends CreateNoteStates{}

class CreateNoteErrorState extends CreateNoteStates{
  final String em;
  CreateNoteErrorState(this.em);
}