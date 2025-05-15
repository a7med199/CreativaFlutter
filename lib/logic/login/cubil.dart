import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/logic/login/state.dart';


class LoginCubit extends Cubit<LoginStates>{
  LoginCubit() : super(LoginInitialState());

  Future Login (String userEmail, String userPass)async {
    emit(LoginLoadingState());
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: userEmail, password: userPass);
      emit(LoginSuccessState());
    }catch(e){
      emit(LoginErrorState(em: e.toString()));
    }
  }
}