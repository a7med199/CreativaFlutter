import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/data/note_model.dart';
import 'package:untitled1/logic/create_note/state.dart';
import 'package:untitled1/logic/get_notes/state.dart';


class GetNoteDataCubit extends Cubit<GetNoteDataStates> {
  GetNoteDataCubit() : super(GetNoteInitialState());

  ///
  Future getNotesData() async {
    emit(GetNoteLoadingState());
    try {
      // get
      final getData = await FirebaseFirestore.instance.collection("note").get();
      print(getData);
      //save in model => convert to list
      final noteList =
      getData.docs.map((doc) => NoteModel.fromJson(doc.data())).toList();
      emit(GetNoteSuccessState(notes: noteList));
    } catch (e) {
      emit(GetNoteErrorState(e.toString()));
    }
  }
}