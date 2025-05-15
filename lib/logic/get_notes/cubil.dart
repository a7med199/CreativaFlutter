import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/data/note_model.dart';
import 'package:untitled1/logic/create_note/state.dart';
import 'package:untitled1/logic/get_notes/state.dart';


class GetNoteCubit extends Cubit<GetNoteStates>{
  GetNoteCubit() : super(GetNoteInitialState());

  Future GetNote (NoteModel x) async {
    emit(GetNoteLoadingState());
    try{
      final date = await FirebaseFirestore.instance.collection("notesData").get();
      final notes = date.docs.map((e) => NoteModel.fromJson(e.data())).toList();
      emit(GetNoteSuccessState(notesData: notes));
    }
    catch(e){
      emit(GetNoteErrorState(message: e.toString()));
    }
  }
}