import 'package:flutkart/utils/my_navigator.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: new ThemeData(primarySwatch: Colors.blue),
      home: new LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  State createState() => new LoginPageState();
}

enum FormType {
  login,
  register
}

class LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  Animation<double> _iconAnimation;
  AnimationController _iconAnimationController;
  @override
  void initState() {
    super.initState();
    _iconAnimationController = new AnimationController(
        vsync: this, duration: new Duration(milliseconds: 500));
    _iconAnimation = new CurvedAnimation(
      parent: _iconAnimationController,
      curve: Curves.bounceOut,
    );
    _iconAnimation.addListener(() => this.setState(() {}));
    _iconAnimationController.forward();
  }


  final formkey = new GlobalKey<FormState>();

  String _email;
  String _password;
  FormType _formType = FormType.login;


  bool validateandsave(){
    final form = formkey.currentState;
    if(form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  void validateAndSubmit() async{
    if(validateandsave()){
      try {
        if(_formType == FormType.login) {
          FirebaseUser user = await FirebaseAuth.instance
              .signInWithEmailAndPassword(email: _email, password: _password);
          (user.uid).isEmpty? null: MyNavigator.goToHome(context);
          print("Signed in : ${user.uid}");
        }else{
          FirebaseUser user = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email, password: _password);
          moveToLogin();
        }
      }
      catch(e){
        print("Error : $e");
      }
    }
  }

  void moveToRegister(){
    setState(() {
      formkey.currentState.reset();
      _formType = FormType.register;
    });
}

void moveToLogin(){
  setState(() {
    formkey.currentState.reset();
    _formType = FormType.login;
  });

}
  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      backgroundColor: Colors.white,
      body: new Stack(fit: StackFit.expand, children: <Widget>[
        new Image(
          image: new AssetImage("assets/girl.jpeg"),
          fit: BoxFit.cover,
          colorBlendMode: BlendMode.darken,
          color: Colors.black87,
        ),
        new Theme(
          data: new ThemeData(
              brightness: Brightness.dark,
              inputDecorationTheme: new InputDecorationTheme(
                // hintStyle: new TextStyle(color: Colors.blue, fontSize: 20.0),
                labelStyle:
                new TextStyle(color: Colors.redAccent, fontSize: 25.0),
              )),
          isMaterialAppTheme: true,
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new FlutterLogo(
                size: _iconAnimation.value * 140.0,
              ),
              new Container(
                padding: const EdgeInsets.all(40.0),
                child: new Form(
                  key: formkey,
                  autovalidate: true,
                  child: new Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: buildInputs() + buildSubmitButtons(),
                  ),
                ),
              )
            ],
          ),
        ),
      ]),
    );
  }

  List<Widget> buildInputs(){
    return [
      new TextFormField(
        decoration: new InputDecoration(
            labelText: "Enter Email", fillColor: Colors.white),
        validator: (value) => value.isEmpty ? 'Email can\'t be empty' : null,
        onSaved: (value) => _email = value,
        keyboardType: TextInputType.emailAddress,
      ),
      new TextFormField(
        decoration: new InputDecoration(
          labelText: "Enter Password",
        ),
        validator: (value) => value.isEmpty ? 'Password can\'t be empty' : null,
        onSaved: (value) => _password = value,
        obscureText: true,
        keyboardType: TextInputType.text,
      ),
      new Padding(
        padding: const EdgeInsets.only(top: 60.0),
      ),
    ];
  }

  List<Widget> buildSubmitButtons(){
    if(_formType == FormType.login){
      return [
        new MaterialButton(
          height: 50.0,
          minWidth: 150.0,
          color: Colors.redAccent,
          splashColor: Colors.teal,
          textColor: Colors.white,
          child: new Text("Login"),
          onPressed: validateAndSubmit,
          //MyNavigator.goToHome(context);
        ),
        new FlatButton(
            onPressed: moveToRegister,
            child: new Text("Create an Account")
        )
      ];
    }else{
      return [
        new MaterialButton(
          height: 50.0,
          minWidth: 150.0,
          color: Colors.redAccent,
          splashColor: Colors.teal,
          textColor: Colors.white,
          child: new Text(" Create an Account"),
          onPressed: validateAndSubmit,
          //MyNavigator.goToHome(context);
        ),
        new FlatButton(
            onPressed: moveToLogin,
            child: new Text("Have an account? Login")
        )
      ];

    }
  }
}