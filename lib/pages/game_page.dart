import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import './game_page_displayed_verse.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  int guessedCounter = 0;
  List<Widget> gameKeyboard = [];

  //
  // GET THE VERSE AS A STRING && CREATE CURRENT VERSE WITH HIDDEN CHARACTERS && CREATE NEW ALPHABET
  static String verseTitle = 'Daniel 6:25-27';
  static String verseString =
      "25.Then King Darius wrote to all the nations and peoples of every language in all the earth: 'May you prosper greatly! 26.'I issue a decree that in every part of my kingdom people must fear and reverence the God of Daniel. 'For he is the living God and he endures forever; his kingdom will not be destroyed, his dominion will never end. 27.He rescues and he saves; he performs signs and wonders in the heavens and on the earth. He has rescued Daniel from the power of the lions.'";
  String currentVerse = '';
  static String alphabet = 'QWERTYUIOPASDFGHJKLZXCVBNM';

  //
  // MANIPULATE STRING DATA TO GET UNIQUE STRING, ANSWERS
  static Characters verseCharacters = verseString.characters;
  static List? verseList = verseCharacters.toLowerCase().toSet().toList();
  static String answerLetters = '';
  String guessedLetters = '';
  String guessedAnswers = '';
  String remainingLetters = '';

  void createList() => verseList?.forEach(
        (char) {
          if (RegExp('[a-z]').hasMatch(char)) {
            answerLetters += char;
          }
        },
      );
  // static Text answers = Text(
  //   "answers: $answerLetters",
  //   style: const TextStyle(
  //     color: Colors.white70,
  //   ),
  // );

  void handleTap(String char) {
    final String letter = char.toLowerCase();

    // NOT WORKING! WHY? IDK.
    HapticFeedback.heavyImpact();

    if (answerLetters.contains(letter) && !guessedLetters.contains(letter)) {
      guessedLetters += letter;
      if (answerLetters.contains(letter)) {
        answerLetters = answerLetters.replaceAll(RegExp(letter), '');
      }
      String newVerse = '';
      verseString.characters.forEach((char) => {
            if (!RegExp('[a-z]').hasMatch(char.toLowerCase()))
              {newVerse += char}
            else if (guessedLetters.contains(char.toLowerCase()))
              {newVerse += char}
            else
              {newVerse += '_'}
          });

      currentVerse = newVerse;
    } else {}

    setState(() {
      remainingLetters = answerLetters;
      guessedCounter++;
    });
  }

  void handleGuessTap() {}

  //
  // CREATE THE GAME KEYBOARD WITH GESTURE DETECTORS
  List<GestureDetector> keysRowTop = [];
  List<GestureDetector> keysRowMid = [];
  List<GestureDetector> keysRowBot = [];

  static int count = 0;
  void createKeyboard() => alphabet.characters.forEach((char) {
        double widthValue = MediaQuery.of(context).size.width;
        double buttonWidthValue = (widthValue / 11) + (widthValue / 22);
        Widget fullPlaceholder = GestureDetector(
          onTap: () {
            handleGuessTap();
          },
          child: Container(
            height: widthValue / 11,
            width: buttonWidthValue,
            decoration: BoxDecoration(
              // color: Theme.of(context).colorScheme.secondaryContainer,
              // borderRadius: BorderRadius.all(
              //   Radius.elliptical(widthValue / 22, widthValue / 44),
              // ),
              border: Border(
                top: BorderSide(
                  width: 3,
                  color: Theme.of(context).colorScheme.secondaryContainer,
                ),
                bottom: BorderSide(
                  width: 1,
                  color: Theme.of(context).colorScheme.secondaryContainer,
                ),
                left: BorderSide(
                  width: 3,
                  color: Theme.of(context).colorScheme.secondaryContainer,
                ),
                right: BorderSide(
                  width: 1,
                  color: Theme.of(context).colorScheme.secondaryContainer,
                ),
              ),
            ),
            child: Center(
              child: Icon(
                Icons.fact_check_outlined,
                size: widthValue / 14,
                color: Theme.of(context).colorScheme.secondaryContainer,
              ),
            ),
          ),
        );
        Widget placeholder = SizedBox(
          height: widthValue / 22,
          width: widthValue / 22,
        );

        // GestureDetector newKey = GestureDetector(
        //   onTap: () {
        //     handleTap(char);
        //   },
        //   child: Container(
        //     height: widthValue / 11,
        //     width: widthValue / 11,
        //     decoration: BoxDecoration(
        //       color: Theme.of(context).colorScheme.secondaryContainer,
        //       borderRadius: BorderRadius.all(
        //         Radius.elliptical(widthValue / 22, widthValue / 44),
        //       ),
        //     ),
        //     child: Center(
        //       child: Text(
        //         char,
        //         style: TextStyle(
        //           fontSize: widthValue / 14,
        //           fontFamily: GoogleFonts.lekton().fontFamily,
        //         ),
        //       ),
        //     ),
        //   ),
        // );
        GestureDetector newKey = GestureDetector(
          onTap: () {
            handleTap(char);
          },
          child: Container(
            height: widthValue / 11,
            width: widthValue / 11,
            decoration: BoxDecoration(
              // color: Theme.of(context).colorScheme.secondaryContainer,
              border: Border(
                top: BorderSide(
                  width: 3,
                  color: Theme.of(context).colorScheme.secondaryContainer,
                ),
                bottom: BorderSide(
                  width: 1,
                  color: Theme.of(context).colorScheme.secondaryContainer,
                ),
                left: BorderSide(
                  width: 3,
                  color: Theme.of(context).colorScheme.secondaryContainer,
                ),
                right: BorderSide(
                  width: 1,
                  color: Theme.of(context).colorScheme.secondaryContainer,
                ),
              ),
              // borderRadius: BorderRadius.all(
              //   Radius.elliptical(widthValue / 22, widthValue / 44),
              // ),
            ),
            child: Center(
              child: Text(
                char,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondaryContainer,
                  fontSize: widthValue / 14,
                  fontFamily: GoogleFonts.lekton().fontFamily,
                ),
              ),
            ),
          ),
        );

        if (count < 10) {
          keysRowTop.add(newKey);
        } else if (count < 19 && count >= 10) {
          keysRowMid.add(newKey);
        } else if (count == 25) {
          count = 0;
          keysRowBot.add(newKey);
        } else {
          keysRowBot.add(newKey);
        }

        count++;

        SizedBox spacer = SizedBox(
          height: 10,
          width: MediaQuery.of(context).size.width,
        );
        Row topRow = Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.max,
          children: [...keysRowTop],
        );
        Row midRow = Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.max,
          children: [
            placeholder,
            ...keysRowMid,
            placeholder,
          ],
        );
        Row botRow = Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.max,
          children: [
            fullPlaceholder,
            ...keysRowBot,
            fullPlaceholder,
          ],
        );

        setState(() {
          gameKeyboard = [
            topRow,
            spacer,
            midRow,
            spacer,
            botRow,
          ];
        });
      });

  void createVerse() {
    if (guessedLetters.isNotEmpty) {
    } else {
      setState(() {
        currentVerse = verseString.replaceAll(RegExp('[A-Za-z]'), '_');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // SizedBox spacer = SizedBox(
    //   height: 10,
    //   width: MediaQuery.of(context).size.width,
    // );

    if (gameKeyboard.isEmpty) {
      createKeyboard();
    }
    if (answerLetters.isEmpty) {
      createList();
    }
    if (currentVerse.isEmpty) {
      createVerse();
    }

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints viewportConstraints) {
        return ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: viewportConstraints.maxHeight,
          ),
          child: Container(
            color: const Color(0xFF0B1623),
            child: Column(
              children: [
                DisplayedVerse(
                  verseTitle: verseTitle,
                  verse: currentVerse,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 1 / 5,
                  child: Column(
                    children: [
                      Text(
                        "remaining: $remainingLetters",
                        style: const TextStyle(
                          color: Colors.white70,
                        ),
                      ),
                      ...gameKeyboard,
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
