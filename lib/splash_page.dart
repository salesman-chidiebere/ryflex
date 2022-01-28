import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          AvatarGlow(
            glowColor: Colors.red,
            endRadius: 90.0,
            duration: Duration(milliseconds: 2000),
            repeat: true,
            showTwoGlows: true,
            repeatPauseDuration: Duration(milliseconds: 100),
            child: Material(     // Replace this child with your own
              elevation: 8.0,
              shape: CircleBorder(),
              child: CircleAvatar(
                backgroundColor: Colors.grey[100],
                child: Image.asset(
                  'assets/images/car_ios.png',
                  height: 100,
                ),
                radius: 60.0,
              ),
            ),
          ),

          SizedBox(
            width: 250.0,
            child: TextLiquidFill(
              text: 'Ryflex',
              waveColor: Colors.red,
              boxBackgroundColor: Colors.white,
              textStyle: TextStyle(
                fontSize: 40.0,
                fontWeight: FontWeight.w900,
                fontStyle: FontStyle.italic
              ),
              boxHeight: 80.0,
            ),
          ),

        ],
      ),
    );
  }
}
