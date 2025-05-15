import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/data/note_model.dart';
import 'package:untitled1/logic/create_note/state.dart';


class CreateNoteCubit extends Cubit<CreateNoteStates>{
  CreateNoteCubit() : super(CreateNoteInitialState());

  Future CreateNote (NoteModel x) async {
    emit(CreateNoteLoadingState());
    try{
      await FirebaseFirestore.instance.collection("notesData").add(x.toJson());
      emit(CreateNoteSuccessState());
    }catch(e){
      print(e.toString());
      emit(CreateNoteErrorState(em: e.toString()));
    }
  }
}