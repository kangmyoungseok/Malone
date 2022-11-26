import 'package:flutter/material.dart';
import 'package:term_proj2/src/styles.dart';


class IntroScreen extends StatelessWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurpleAccent,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Image.asset('lib/assets/img/logo.png',width: 160,height: 160,),
            const SizedBox(height: 200,),
            const Text("Mobile App Term Project",style: TextStyle(fontSize: 14,color: Colors.white),),
            const Text("Team 10",style: TextStyle(fontSize: 14,color: Colors.white),),
          ],
        ),
      ),
    );
  }
}