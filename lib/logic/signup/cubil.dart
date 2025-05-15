import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/logic/signup/state.dart';

class SignUpCubit extends Cubit<SignUpStates>{
  SignUpCubit() : super(SignUpInitialState());

  Future signUp (String userEmail, String userPass)async {
    emit(SignUpLoadingState());
    try{
      await FirebaseAuth.instance.createUserWithEmailAndPassword(email: userEmail, password: userPass);
      emit(SignUpSuccessState());
    }catch(e){
      emit(SignUpErrorState(em: e.toString()));
    }
  }
}