import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/NOTE/Register/cubit/register_state.dart';

class RegisterCubit extends Cubit<RegisterState>{
  RegisterCubit():super(RegisterInitState());
  final auth = FirebaseAuth.instance;
  register({ required String email, required String passwordd} ) async {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: email,
        password: passwordd,
      )
          .then((value) {
        emit(RegisterSuccesState());
      }).catchError((error)=>emit(RegisterFailState(errormessage: error.toString())));
    } 
  }

