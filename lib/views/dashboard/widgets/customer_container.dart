import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  const CustomContainer({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      width: screenWidth,
      padding: const EdgeInsets.only(
          top: 30 + kToolbarHeight, bottom: 30, left: 30, right: 30),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(60),
        ),
        gradient: LinearGradient(
          begin: Alignment(1.0, -0.5),
          end: Alignment(0.0, 1.0),
          colors: [

            Color(0xFFDE7A72),
            Color.fromRGBO(222, 122, 114, 0.8),
          ],
          stops: [0.0188, 1.0],
        ),
      ),
      child: child,
    );
  }
}
