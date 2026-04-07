import 'package:flutter/material.dart';

class SplashScreenUi extends StatefulWidget {
  const SplashScreenUi({super.key});

  @override
  State<SplashScreenUi> createState() => _SplashScreenUiState();
}

class _SplashScreenUiState extends State<SplashScreenUi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Image.asset(
            'assets/images/food_img.png',
            width: 200,
            height: 200,
          ),
          SizedBox(height: 20),
          Text(
            'กินกัน LOG',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.yellow
            ),
          ),
          
          SizedBox(height: 20),
          CircularProgressIndicator(
            color: Colors.yellow,
          ),
        ],
        ),
          
      ),
    );
  }
}