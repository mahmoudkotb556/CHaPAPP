abstract class loginstate{}
class logininitestate extends loginstate{}
class loginsyccessestate extends loginstate{}
class loginfailuretestate extends loginstate{
  final String messageerror;

  loginfailuretestate( this.messageerror);

}