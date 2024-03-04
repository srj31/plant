import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BorderedText extends StatelessWidget {
  const BorderedText({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Text(
          text,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              foreground: Paint()
                ..color = Colors.white
                ..strokeWidth = 2
                ..style = PaintingStyle.stroke,
              fontFamily: GoogleFonts.play().fontFamily,
              fontSize: 12),
        ),
        Text(
          text,
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontFamily: GoogleFonts.play().fontFamily,
              fontSize: 12),
        ),
      ],
    );
  }
}
