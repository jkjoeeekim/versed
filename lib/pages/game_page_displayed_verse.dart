import 'package:google_fonts/google_fonts.dart';

import 'package:flutter/material.dart';

class DisplayedVerse extends StatefulWidget {
  const DisplayedVerse({
    super.key,
    required this.verseTitle,
    required this.verse,
  });

  final String verseTitle;
  final String verse;

  @override
  State<DisplayedVerse> createState() => _DisplayedVerseState();
}

class _DisplayedVerseState extends State<DisplayedVerse> {
  @override
  Widget build(BuildContext context) {
    double maxWidth = MediaQuery.of(context).size.width;
    double maxHeight = MediaQuery.of(context).size.height;
    String text = widget.verse;
    List<Widget> chars = [];

    double charBoxSize = maxWidth / 26;

    Widget title = Center(
      child: Text(
        widget.verseTitle,
        style: TextStyle(
          fontFamily: GoogleFonts.lekton().fontFamily,
          color: Theme.of(context).colorScheme.onTertiary,
          overflow: TextOverflow.visible,
          fontSize: 28,
        ),
      ),
    );

    text.characters.forEach((char) {
      chars.add(
        Container(
          child: SizedBox(
            width: charBoxSize,
            height: charBoxSize,
            child: Container(
              child: Center(
                child: Text(
                  char,
                  style: TextStyle(
                    fontFamily: GoogleFonts.lekton().fontFamily,
                    color: Theme.of(context).colorScheme.onTertiary,
                    overflow: TextOverflow.visible,
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    });

    return SizedBox(
      width: maxWidth * 0.9,
      height: maxHeight * 3 / 5,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          title,
          Center(
            child: Wrap(
              direction: Axis.horizontal,
              children: [...chars],
            ),
          ),
        ],
      ),
    );
  }
}
