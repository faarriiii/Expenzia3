import 'package:exenzia/view/bottomnavibar.dart';
import 'package:flutter/material.dart';

class Splash2 extends StatefulWidget {
  const new({super.key});

  @override
  State<Splash2> createState() => _Splash2State();
}

class _Splash2State extends State<Splash2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.greenAccent.shade100,
      
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(height: 400,
            width: double.infinity,
              child: Image.asset('assets/image1.png')),
            
            Center(
              child: Text(" Spend Smarter",
              style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,color: Colors.green)),
            ),
            Center(
              child: Text("Save More ",
              style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,color: Colors.green)),
            ),
            SizedBox(height: 30,),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: SizedBox(
                height: 40,
                width: double.infinity,
                child: ElevatedButton(onPressed: (){
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) =>BottomnaviBar()),
                  (route) => false,);
                }, child: Text("Get started",),)),
            )
          ],
        ),
      ),

    );
  }
}