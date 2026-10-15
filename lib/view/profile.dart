import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const new({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 73, 168, 122),
        foregroundColor: Colors.white,
        title: Text("Profile"),
        
          
          
        
        
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(child: CircleAvatar(child:  Icon(Icons.person),
          radius: 50,)),
          Text("salman faris")
        ],
      ),
      
    );
  }
}