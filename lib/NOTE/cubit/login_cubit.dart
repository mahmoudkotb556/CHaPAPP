import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'login_state.dart';

class logincubit extends Cubit<loginstate> {
  logincubit(): super(logininitestate());
  final auth=FirebaseAuth.instance;

  LOGIN({ required String emaiLL
  ,required String pass}) {

    auth.signInWithEmailAndPassword(email: emaiLL, password: pass).then((value){
     emit(loginsyccessestate());

    }).catchError((error){emit(loginfailuretestate(error.toString()));});
  }
}