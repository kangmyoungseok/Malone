import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:term_proj2/src/styles.dart';
import '../../firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key:key);

  @override
  _LoginPageState createState() => _LoginPageState();

}

class _LoginPageState extends State<LoginPage> {
  bool showSpinner = false;
  final _authentication = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  Color iconColor1 = Colors.grey;
  Color iconColor2 = Colors.grey;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(211, 215, 246, 10),
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Form(
          key: _formKey,
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('logotext.png', width: 100, height: 100, ),
                  //SizedBox(height: 100,),
                  Padding(padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                    child: Container(
                        padding: EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 10.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Focus(
                          onFocusChange: (hasFocus) {
                            if(hasFocus){iconColor1=Color.fromRGBO(109, 119, 233, 10);}
                            else{iconColor1=Colors.grey;}
                            setState(() {
                            });
                          },
                          child: TextFormField(
                            autofocus: true,
                            cursorColor: Color.fromRGBO(109, 119, 233, 10),
                            decoration: InputDecoration(
                                labelText: 'Email',
                                labelStyle: TextStyle(color: Colors.grey),
                                floatingLabelStyle: TextStyle(color: Color.fromRGBO(109, 119, 233, 10)),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Color.fromRGBO(109, 119, 233, 10), width: 1.9,)
                                ),
                                icon: Icon(Icons.mail_outline, color: iconColor1)
                            ),
                            onChanged: (value) {
                              email = value;
                            },
                          ),
                        )
                    ),
                  ),
                  Padding(padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                    child: Container(
                        padding: EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 10.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Focus(
                          onFocusChange: (hasFocus) {
                            if(hasFocus){iconColor2=Color.fromRGBO(109, 119, 233, 10);}
                            else{iconColor2=Colors.grey;}
                            setState(() {
                            });
                          },
                          child: TextFormField(
                            obscureText: true,
                            cursorColor: Color.fromRGBO(109, 119, 233, 10),
                            decoration: InputDecoration(
                              labelText: 'Password',
                              labelStyle: TextStyle(color: Colors.grey),
                              floatingLabelStyle: TextStyle(color: Color.fromRGBO(109, 119, 233, 10)),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Color.fromRGBO(109, 119, 233, 10), width: 1.9,)
                              ),
                              icon: Icon(Icons.lock_outline, color: iconColor2),
                            ),
                            onChanged: (value) {
                              password = value;
                            },
                          ),
                        )
                    ),
                  ),
                  Padding(padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                    child: Container(
                        padding: EdgeInsets.all(0.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Row(
                          children: [
                            Flexible(
                                fit: FlexFit.tight,
                                child: SizedBox(
                                  height: 60,
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all<Color>(Color.fromRGBO(109, 119, 233, 10)),
                                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(50),
                                            //side: BorderSide(color: Color.fromRGBO(235, 237, 251, 10),)
                                          )
                                      ),
                                    ),
                                    onPressed: () async {
                                      try {
                                        setState(() {
                                          showSpinner = true;
                                        });
                                        final currentUser =
                                        await _authentication.signInWithEmailAndPassword(
                                            email: email, password: password);
                                        if (currentUser.user != null) {
                                          _formKey.currentState!.reset();
                                          if (!mounted) return;
                                          setState(() {
                                            showSpinner = false;
                                          });
                                        }
                                      } catch (e) {
                                        print(e);
                                      }
                                    },
                                    child: const Text('Login', style: TextStyle(fontSize: 20),),
                                  ),
                                )
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Flexible(
                              fit: FlexFit.tight,
                              child: SizedBox(
                                height: 60,
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all<Color>(Color.fromRGBO(109, 119, 233, 10)),
                                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(50),
                                          //side: BorderSide(color: Color.fromRGBO(109, 119, 233, 10),)
                                        )
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => const RegisterPage()));
                                  },
                                  child: const Text('Join Us!', style: TextStyle(fontSize: 20),),
                                ),
                              ),
                            ),
                          ],
                        )
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const RegisterForm(),
    );
  }
}

class RegisterForm extends StatefulWidget {
  const RegisterForm({Key? key}) : super(key: key);

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _authentication = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  String userName = '';
  Color iconColor1 = Colors.grey;
  Color iconColor2 = Colors.grey;
  Color iconColor3 = Colors.grey;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(211, 215, 246, 10),
      body: Form(
        key: _formKey,
        child: ListView(
//          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 100,),
            Image.asset('logotext.png', width: 100, height: 100, ),
            //SizedBox(height: 100,),
            Padding(padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
              child: Container(
                  padding: EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 10.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Focus(
                    onFocusChange: (hasFocus) {
                      if(hasFocus){iconColor1=Color.fromRGBO(109, 119, 233, 10);}
                      else{iconColor1=Colors.grey;}
                      setState(() {
                      });
                    },
                    child: TextFormField(
                      autofocus: true,
                      cursorColor: Color.fromRGBO(109, 119, 233, 10),
                      decoration: InputDecoration(
                        labelText: 'User',
                        labelStyle: TextStyle(color: Colors.grey),
                        floatingLabelStyle: TextStyle(color: Color.fromRGBO(109, 119, 233, 10)),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color.fromRGBO(109, 119, 233, 10), width: 1.9,)
                        ),
                        icon: Icon(Icons.person_outline, color: iconColor1),
                      ),
                      onChanged: (value) {
                        userName = value;
                      },
                    ),
                  )
              ),
            ),
            Padding(padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
              child: Container(
                  padding: EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 10.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Focus(
                    onFocusChange: (hasFocus) {
                      if(hasFocus){iconColor2=Color.fromRGBO(109, 119, 233, 10);}
                      else{iconColor2=Colors.grey;}
                      setState(() {
                      });
                    },
                    child: TextFormField(
                      cursorColor: Color.fromRGBO(109, 119, 233, 10),
                      decoration: InputDecoration(
                        labelText: 'Email',
                        labelStyle: TextStyle(color: Colors.grey),
                        floatingLabelStyle: TextStyle(color: Color.fromRGBO(109, 119, 233, 10)),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color.fromRGBO(109, 119, 233, 10), width: 1.9,)
                        ),
                        icon: Icon(Icons.mail_outline, color: iconColor2),
                      ),
                      onChanged: (value) {
                        email = value;
                      },
                    ),
                  )
              ),
            ),
            Padding(padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
              child: Container(
                  padding: EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 10.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child:  Focus(
                    onFocusChange: (hasFocus) {
                      if(hasFocus){iconColor3=Color.fromRGBO(109, 119, 233, 10);}
                      else{iconColor3=Colors.grey;}
                      setState(() {
                      });
                    },
                    child: TextFormField(
                      obscureText: true,
                      cursorColor: Color.fromRGBO(109, 119, 233, 10),
                      decoration: InputDecoration(
                        labelText: 'Password',
                        labelStyle: TextStyle(color: Colors.grey),
                        floatingLabelStyle: TextStyle(color: Color.fromRGBO(109, 119, 233, 10)),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color.fromRGBO(109, 119, 233, 10), width: 1.9,)
                        ),
                        icon: Icon(Icons.lock_outline, color: iconColor3),
                      ),
                      onChanged: (value) {
                        password = value;
                      },
                    ),
                  )
              ),
            ),
            Padding(padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
              child: Container(
                padding: EdgeInsets.all(0.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Row(
                  children: [
                    Flexible(
                      fit: FlexFit.tight,
                      child: SizedBox(
                        height: 60,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(Color.fromRGBO(109, 119, 233, 10)),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                  //side: BorderSide(color: Color.fromRGBO(109, 119, 233, 10),)
                                )
                            ),
                          ),
                          onPressed: () async {
                            try {
                              final newUser =
                              await _authentication.createUserWithEmailAndPassword(
                                  email: email, password: password);
                              await FirebaseFirestore.instance
                                  .collection('user')
                                  .doc(newUser.user!.uid)
                                  .set({
                                'userName': userName,
                                'email': email,
                              });
                              if (newUser.user != null) {
                                _formKey.currentState!.reset();
                                if (!mounted) return;
                                showModalBottomSheet<void>(context: context, builder: (context)
                                {
                                  return Container(
                                    color: Color.fromRGBO(235, 237, 251, 10),
                                    height: 200,
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          const Text('Welcome to Malone!', style: TextStyle(fontSize: 20,
                                              fontWeight: FontWeight.bold, color: Colors.blueGrey),),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          TextButton.icon(
                                              onPressed: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) => Container() // <-AppPage
                                                    )
                                                );
                                              },
                                              icon: const Icon(Icons.login_outlined, color: Color.fromRGBO(109, 119, 233, 10),),
                                              label: Text('Login as ${userName}',
                                                style: TextStyle(color: Color.fromRGBO(109, 119, 233, 10)),))
                                        ],
                                      ),
                                    ),
                                  );
                                });

                                /*
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                      const SuccessRegisterPage()));*/
                              }
                            } catch (e) {
                              print(e);
                            }
                          },
                          child: const Text('Register', style: TextStyle(fontWeight: FontWeight.bold,
                              fontSize: 20),),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Text("If you already registered, "),
                  TextButton(
                    onPressed: (){
                      Navigator.pop(context);
                    },
                    style: TextButton.styleFrom(
                        foregroundColor: AppColor.onPrimaryColor
                    )
                    ,child: const Text("please login."),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}