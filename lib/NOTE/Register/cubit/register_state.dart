abstract class RegisterState{}
class RegisterInitState extends RegisterState{}
class RegisterSuccesState extends RegisterState{}
class RegisterFailState extends RegisterState{
  final String errormessage;

  RegisterFailState({ required this.errormessage});
}