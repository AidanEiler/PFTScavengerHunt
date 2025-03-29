import 'package:flutter/material.dart';

// Global font choice - change this to switch between fonts
const String globalFontFamily =
    'ProximaNova'; // Change to 'ProximaNova' to switch

void main() => runApp(MyApp());

class LSUColors {
  // Primary Colors
  static const Color purple =
      Color(0xFF461D7C); // Official LSU Purple - Pantone 268c/268u
  static const Color gold =
      Color(0xFFFDD023); // Official LSU Gold - Pantone 123c/115u

  // Tonal Palette
  static const Color corporatePurple =
      Color(0xFF3C1053); // Corporate Purple - Pantone 2627c/269u
  static const Color lightPurple =
      Color(0xFFA39AAC); // Light Purple - Pantone 7660c/7660u
  static const Color corporateGold =
      Color(0xFFD29F13); // Corporate Gold - Pantone 7555c/7555u
  static const Color lightGold =
      Color(0xFFF1EED8); // Light Gold - No solid version

  // Neutral Palette
  static const Color lightGray =
      Color(0xFFD0D0CE); // Light Gray - Pantone Cool Gray 2c/2u
  static const Color gray =
      Color(0xFF999999); // 50% Gray - Pantone Cool Gray 8c/8u
  static const Color black = Color(0xFF333333); // Process Black
  static const Color metallicGold =
      Color(0xFFAA8A3C); // Approximation of Pantone 872 (Metallic)
}

class Question {
  final String questionText;
  final String correctAnswer;

  Question({
    required this.questionText,
    required this.correctAnswer,
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PFT Code Cracker',
      theme: ThemeData(
        primaryColor: LSUColors.purple,
        scaffoldBackgroundColor: LSUColors.purple,
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: LSUColors.purple,
          secondary: LSUColors.gold,
          tertiary: LSUColors.corporatePurple,
          surface: LSUColors.lightGray,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: LSUColors.gold,
            foregroundColor: LSUColors.purple,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: LSUColors.gold,
          ),
        ),
        cardTheme: CardTheme(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
        ),
        fontFamily: globalFontFamily,
      ),
      home: MainNavigationScreen(),
    );
  }
}

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  _MainNavigationScreenState createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;
  final List<Widget> _screens = [
    HomeScreen(),
    GameScreen(),
    WordGuessDirectScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: LSUColors.purple,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 8,
              offset: Offset(0, -2),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          backgroundColor: LSUColors.purple,
          selectedItemColor: LSUColors.gold,
          unselectedItemColor: Colors.white.withOpacity(0.6),
          selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.screen_search_desktop_rounded),
              label: 'Title Screen',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.lock_outline),
              label: 'Guess Secret',
            ),
          ],
        ),
      ),
    );
  }
}

class WordGuessDirectScreen extends StatefulWidget {
  const WordGuessDirectScreen({super.key});

  @override
  _WordGuessDirectScreenState createState() => _WordGuessDirectScreenState();
}

class _WordGuessDirectScreenState extends State<WordGuessDirectScreen> {
  final String secretWord = "DR SHEPHERD";
  List<bool> revealedLetters = [];

  @override
  void initState() {
    super.initState();
    // Initialize all letters as hidden initially
    revealedLetters = List.generate(secretWord.length, (index) => false);
  }

  @override
  Widget build(BuildContext context) {
    return WordGuessScreen(
      secretWord: secretWord,
      revealedLetters: revealedLetters,
      showAppBar: false,
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LSUColors.purple,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 40, 16, 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // LSU logo without white circle
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: Image.asset(
                      'Assets/LSU.png',
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: LSUColors.purple,
                          child: Center(
                            child: Text(
                              'LSU Logo',
                              style: TextStyle(
                                color: LSUColors.gold,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Text(
                    'PFT Code Cracker',
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: LSUColors.gold,
                      letterSpacing: 1.2,
                      fontFamily: globalFontFamily,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Text(
                    'Explore what LSU has to offer for prospective engineers!',
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      height: 1.5,
                      fontFamily: globalFontFamily,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 60),
                ElevatedButton(
                  onPressed: () {
                    // Navigate to Game tab
                    (context.findAncestorStateOfType<
                            _MainNavigationScreenState>())
                        ?.setState(() {
                      (context.findAncestorStateOfType<
                              _MainNavigationScreenState>())
                          ?._currentIndex = 1;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 16),
                    elevation: 5,
                    minimumSize: const Size(220, 56),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    shadowColor: Colors.black.withOpacity(0.5),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Text(
                        'START GAME',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.0,
                          fontFamily: globalFontFamily,
                        ),
                      ),
                      SizedBox(width: 12),
                      Icon(Icons.play_arrow, size: 24),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final List<Question> questions = [
    Question(
      questionText:
          'Question 1: Between Zones 1100, 1200, and 1300, in which is the Panera Bread located?',
      correctAnswer: '1300',
    ),
    Question(
      questionText:
          'Question 2: Past this location up ahead, there should be a Bronze statue between two classrooms. What are the first three words on the plaque of the statue?',
      correctAnswer: 'Tau Beta Gamma',
    ),
    Question(
      questionText:
          'Question 3: By now you should have found a set of wide stairs. Going up, how many steps is it? (wooden steps)',
      correctAnswer: '11',
    ),
    Question(
      questionText:
          'Question 4: Now you are on the second floor. To your left are engineering labs, and to your right computer labs. What zone are the computer labs located in?',
      correctAnswer: '2300',
    ),
    Question(
      questionText:
          'Question 5: As soon as you turn left you should see a room with part of a car in it. What branch of engineering does this driving simulator lab belong to?',
      correctAnswer: 'Civil engineering',
    ),
    Question(
      questionText:
          'Question 6: Now that you have familiarized yourself with the first and second floor, it\'s time to proceed to the third. Whose office is 3209G?',
      correctAnswer: 'Mahmood Jasim',
    ),
    Question(
      questionText:
          'Question 7: What room number is the office of Nash Mahmood?',
      correctAnswer: '3209H',
    ),
    Question(
      questionText:
          'Question 8: You\'re almost done! In the central lobby of the third floor, how many screens are set up there?',
      correctAnswer: '1',
    ),
    Question(
      questionText:
          'Question 9: In section 1100, what is the room number of the auditorium?',
      correctAnswer: '1101',
    ),
    Question(
      questionText:
          'Question 10: Where is the office of the G.O.A.T David Shepherd?',
      correctAnswer: 'Dr. Shepherd\'s office',
    ),
  ];

  final String secretWord = "DR SHEPHERD";
  List<bool> revealedLetters = [];
  List<bool> questionAnswered = [];
  int currentLetterIndex = 0;

  @override
  void initState() {
    super.initState();
    revealedLetters = List.generate(secretWord.length, (index) => false);
    questionAnswered = List.generate(questions.length, (index) => false);
  }

  void revealNextLetter() {
    if (currentLetterIndex < secretWord.length) {
      setState(() {
        revealedLetters[currentLetterIndex] = true;
        currentLetterIndex++;
      });
    }
  }

  // Build consistent letter tile for secret word display
  Widget buildLetterTile(String letter, bool isRevealed, double tileWidth) {
    return Container(
      width: tileWidth,
      height: tileWidth * 1.5,
      decoration: BoxDecoration(
        color: letter != ' '
            ? (isRevealed ? LSUColors.gold : Colors.white)
            : Colors.transparent,
        border: Border.all(
          color: letter == ' '
              ? Colors.transparent
              : (isRevealed
                  ? LSUColors.corporateGold
                  : LSUColors.purple.withOpacity(0.3)),
          width: isRevealed ? 2 : 1,
        ),
        borderRadius: BorderRadius.circular(6),
        boxShadow: isRevealed
            ? [
                BoxShadow(
                  color: LSUColors.corporateGold.withOpacity(0.3),
                  blurRadius: 4,
                  offset: Offset(0, 2),
                )
              ]
            : null,
      ),
      child: Center(
        child: letter == ' '
            ? const SizedBox(width: 16)
            : (isRevealed
                ? Text(
                    letter,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: LSUColors.purple,
                      fontFamily: 'ProximaNova',
                    ),
                  )
                : const Text('')),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 30, 16, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Page Title
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Text(
                  'PFT Code Cracker',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: LSUColors.purple,
                    fontFamily: 'ProximaNova',
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              // Secret Word Display
              GestureDetector(
                onTap: () {
                  // Navigate directly to the Answer tab
                  (context.findAncestorStateOfType<
                          _MainNavigationScreenState>())
                      ?.setState(() {
                    (context.findAncestorStateOfType<
                            _MainNavigationScreenState>())
                        ?._currentIndex = 2;
                  });
                },
                child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          LSUColors.gold.withOpacity(0.1),
                          LSUColors.gold.withOpacity(0.3),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 20),
                      child: Column(
                        children: [
                          const Text(
                            'Secret Word',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: LSUColors.purple,
                              fontFamily: globalFontFamily,
                            ),
                          ),
                          const SizedBox(height: 24),
                          LayoutBuilder(
                            builder: (context, constraints) {
                              double tileWidth = (constraints.maxWidth -
                                      (secretWord.length * 8)) /
                                  secretWord.length;
                              // Ensure minimum width
                              tileWidth = tileWidth < 20 ? 20 : tileWidth;
                              return Wrap(
                                alignment: WrapAlignment.center,
                                spacing: 4,
                                runSpacing: 8,
                                children: List.generate(
                                  secretWord.length,
                                  (index) => buildLetterTile(
                                    secretWord[index],
                                    revealedLetters[index],
                                    tileWidth,
                                  ),
                                ),
                              );
                            },
                          ),
                          const SizedBox(height: 16),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              color: LSUColors.lightPurple.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Text(
                              'Tap to guess the word!',
                              style: TextStyle(
                                color: LSUColors.corporatePurple,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'ProximaNova',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              // Questions List
              Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        LSUColors.purple.withOpacity(0.05),
                        LSUColors.purple.withOpacity(0.15),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Questions',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: LSUColors.purple,
                            fontFamily: 'ProximaNova',
                          ),
                        ),
                        const SizedBox(height: 20),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: questions.length,
                          itemBuilder: (context, index) {
                            return Card(
                              margin: const EdgeInsets.only(bottom: 10),
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: ListTile(
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 8),
                                title: Text(
                                  'Question ${index + 1}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: LSUColors.purple,
                                    fontSize: 16,
                                    fontFamily: 'ProximaNova',
                                  ),
                                ),
                                subtitle: Padding(
                                  padding: const EdgeInsets.only(top: 4),
                                  child: Text(
                                    questions[index].questionText,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: LSUColors.black.withOpacity(0.8),
                                    ),
                                  ),
                                ),
                                trailing: questionAnswered[index]
                                    ? Container(
                                        padding: EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          color: Colors.green.withOpacity(0.1),
                                          shape: BoxShape.circle,
                                        ),
                                        child: const Icon(Icons.check,
                                            color: Colors.green, size: 20))
                                    : Container(
                                        padding: EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          color:
                                              LSUColors.gold.withOpacity(0.2),
                                          shape: BoxShape.circle,
                                        ),
                                        child: const Icon(
                                            Icons.arrow_forward_ios,
                                            color: LSUColors.corporateGold,
                                            size: 16)),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          QuestionDetailScreen(
                                        question: questions[index],
                                        questionNumber: index + 1,
                                        onAnswered: (bool isCorrect) {
                                          if (isCorrect &&
                                              !questionAnswered[index]) {
                                            setState(() {
                                              questionAnswered[index] = true;
                                              revealNextLetter();
                                            });
                                          }
                                        },
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class QuestionDetailScreen extends StatefulWidget {
  final Question question;
  final int questionNumber;
  final Function(bool) onAnswered;

  const QuestionDetailScreen({
    super.key,
    required this.question,
    required this.questionNumber,
    required this.onAnswered,
  });

  @override
  _QuestionDetailScreenState createState() => _QuestionDetailScreenState();
}

class _QuestionDetailScreenState extends State<QuestionDetailScreen> {
  final TextEditingController answerController = TextEditingController();
  String feedbackMessage = '';
  bool isAnswered = false;

  void submitAnswer() {
    String userAnswer = answerController.text.trim().toLowerCase();
    String correctAnswer = widget.question.correctAnswer.toLowerCase();

    if (userAnswer == correctAnswer) {
      setState(() {
        isAnswered = true;
        feedbackMessage = 'Correct!';
      });
      widget.onAnswered(true);
    } else {
      setState(() {
        feedbackMessage = 'Incorrect! Try again.';
      });
    }

    answerController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: LSUColors.purple,
        title: Text(
          'Question ${widget.questionNumber}',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: LSUColors.gold,
            fontFamily: 'ProximaNova',
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: LSUColors.gold),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.white,
                      LSUColors.lightPurple.withOpacity(0.1),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text(
                    widget.question.questionText,
                    style: const TextStyle(
                      fontSize: 18,
                      height: 1.5,
                      color: LSUColors.black,
                      fontFamily: 'ProximaNova',
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            if (!isAnswered) ...[
              TextField(
                controller: answerController,
                decoration: InputDecoration(
                  hintText: 'Type your answer here',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: LSUColors.lightGray),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: LSUColors.lightGray),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                        color: LSUColors.corporateGold, width: 2),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                ),
                style: TextStyle(fontSize: 16, fontFamily: globalFontFamily),
                onSubmitted: (_) => submitAnswer(),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: submitAnswer,
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 3,
                ),
                child: const Text(
                  'Submit Answer',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'ProximaNova',
                  ),
                ),
              ),
            ],
            if (feedbackMessage.isNotEmpty)
              Container(
                margin: const EdgeInsets.only(top: 24),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                decoration: BoxDecoration(
                  color: feedbackMessage.contains('Correct')
                      ? Colors.green.withOpacity(0.1)
                      : Colors.red.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: feedbackMessage.contains('Correct')
                        ? Colors.green
                        : Colors.red,
                    width: 1,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      feedbackMessage.contains('Correct')
                          ? Icons.check_circle
                          : Icons.error,
                      color: feedbackMessage.contains('Correct')
                          ? Colors.green
                          : Colors.red,
                      size: 24,
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        feedbackMessage,
                        style: TextStyle(
                          color: feedbackMessage.contains('Correct')
                              ? Colors.green
                              : Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            if (isAnswered) ...[
              const SizedBox(height: 40),
              OutlinedButton(
                onPressed: () => Navigator.pop(context),
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: LSUColors.purple, width: 1.5),
                  padding: EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Return to Questions',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: LSUColors.purple,
                    fontFamily: 'ProximaNova',
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class WordGuessScreen extends StatefulWidget {
  final String secretWord;
  final List<bool> revealedLetters;
  final bool showAppBar;

  const WordGuessScreen({
    super.key,
    required this.secretWord,
    required this.revealedLetters,
    this.showAppBar = true,
  });

  @override
  _WordGuessScreenState createState() => _WordGuessScreenState();
}

class _WordGuessScreenState extends State<WordGuessScreen> {
  late List<bool> _revealedLetters;
  final TextEditingController guessController = TextEditingController();
  String feedbackMessage = '';
  bool isCorrect = false;

  @override
  void initState() {
    super.initState();
    // Initialize revealed letters based on what was passed in
    _revealedLetters = List.from(widget.revealedLetters);
  }

  // Build consistent letter tile for secret word display (matching GameScreen)
  Widget buildLetterTile(String letter, bool isRevealed, double tileWidth) {
    return Container(
      width: tileWidth,
      height: tileWidth * 1.5,
      margin: const EdgeInsets.symmetric(horizontal: 2),
      decoration: BoxDecoration(
        color: letter != ' '
            ? (isRevealed ? LSUColors.gold : Colors.white)
            : Colors.transparent,
        border: Border.all(
          color: letter == ' '
              ? Colors.transparent
              : (isRevealed
                  ? LSUColors.corporateGold
                  : LSUColors.purple.withOpacity(0.3)),
          width: isRevealed ? 2 : 1,
        ),
        borderRadius: BorderRadius.circular(6),
        boxShadow: isRevealed
            ? [
                BoxShadow(
                  color: LSUColors.corporateGold.withOpacity(0.3),
                  blurRadius: 4,
                  offset: Offset(0, 2),
                )
              ]
            : null,
      ),
      child: Center(
        child: letter == ' '
            ? const SizedBox(width: 16)
            : (isRevealed
                ? Text(
                    letter,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: LSUColors.purple,
                      fontFamily: 'ProximaNova',
                    ),
                  )
                : const Text('')),
      ),
    );
  }

  void submitGuess() {
    String guess = guessController.text.trim().toUpperCase();
    if (guess == widget.secretWord) {
      setState(() {
        isCorrect = true;
        feedbackMessage = 'Correct!';
        // Reveal all letters when guessed correctly
        _revealedLetters =
            List.generate(widget.secretWord.length, (index) => true);
      });
    } else {
      setState(() {
        feedbackMessage = 'Incorrect! Try again.';
      });
    }

    guessController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: widget.showAppBar
          ? AppBar(
              backgroundColor: LSUColors.purple,
              title: const Text(
                'Secret Word',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: LSUColors.gold,
                  fontFamily: 'ProximaNova',
                ),
              ),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: LSUColors.gold),
                onPressed: () => Navigator.pop(context),
              ),
            )
          : null,
      body: SafeArea(
        child: SingleChildScrollView(
          // Adjust top padding to raise content
          padding: const EdgeInsets.fromLTRB(16, 30, 16, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Title - with less padding to further raise content
              if (!widget.showAppBar)
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Text(
                    'PFT Code Cracker',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: LSUColors.purple,
                      fontFamily: 'ProximaNova',
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),

              // Secret Word Card with Tiles - reduced top padding
              Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        LSUColors.gold.withOpacity(0.1),
                        LSUColors.gold.withOpacity(0.3),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 16),
                    child: Column(
                      children: [
                        const Text(
                          'Secret Word',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: LSUColors.purple,
                            fontFamily: globalFontFamily,
                          ),
                        ),
                        const SizedBox(height: 20), // Reduced from 24
                        LayoutBuilder(
                          builder: (context, constraints) {
                            double availableWidth = constraints.maxWidth - 24;
                            double tileWidth =
                                (availableWidth / widget.secretWord.length) - 4;
                            tileWidth = tileWidth > 30 ? 30 : tileWidth;

                            return SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List.generate(
                                  widget.secretWord.length,
                                  (index) => buildLetterTile(
                                    widget.secretWord[index],
                                    _revealedLetters[index],
                                    tileWidth,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24), // Reduced from 30

              // TextField like QuestionDetailScreen
              if (!isCorrect &&
                  !_revealedLetters.every((element) => element)) ...[
                TextField(
                  controller: guessController,
                  decoration: InputDecoration(
                    hintText: 'Type your guess here',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: LSUColors.lightGray),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: LSUColors.lightGray),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                          color: LSUColors.corporateGold, width: 2),
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  ),
                  style: TextStyle(fontSize: 16, fontFamily: globalFontFamily),
                  textCapitalization: TextCapitalization.characters,
                  textAlign: TextAlign.center,
                  onSubmitted: (_) => submitGuess(),
                ),
                const SizedBox(height: 20),
                // Button styled like QuestionDetailScreen
                ElevatedButton(
                  onPressed: submitGuess,
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 3,
                  ),
                  child: const Text(
                    'Submit Guess',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'ProximaNova',
                    ),
                  ),
                ),
              ],

              // Feedback message - styled like QuestionDetailScreen
              if (feedbackMessage.isNotEmpty &&
                  !isCorrect &&
                  !_revealedLetters.every((element) => element))
                Container(
                  margin: const EdgeInsets.only(top: 24),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  decoration: BoxDecoration(
                    color: feedbackMessage.contains('Correct')
                        ? Colors.green.withOpacity(0.1)
                        : Colors.red.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: feedbackMessage.contains('Correct')
                          ? Colors.green
                          : Colors.red,
                      width: 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        feedbackMessage.contains('Correct')
                            ? Icons.check_circle
                            : Icons.error,
                        color: feedbackMessage.contains('Correct')
                            ? Colors.green
                            : Colors.red,
                        size: 24,
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          feedbackMessage,
                          style: TextStyle(
                            color: feedbackMessage.contains('Correct')
                                ? Colors.green
                                : Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

              // All letters revealed message
              if (_revealedLetters.every((element) => element) &&
                  !isCorrect) ...[
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: LSUColors.gold.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(12),
                    border:
                        Border.all(color: LSUColors.corporateGold, width: 1.5),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'All letters revealed!',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: LSUColors.corporatePurple,
                          fontFamily: 'ProximaNova',
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Continue exploring the building to answer all the questions!',
                        style: TextStyle(
                          fontSize: 16,
                          color: LSUColors.corporatePurple,
                          fontFamily: 'ProximaNova',
                        ),
                        textAlign: TextAlign.center,
                      ),
                      if (!widget.showAppBar) ...[
                        SizedBox(height: 24),
                        ElevatedButton(
                          onPressed: () {
                            // Navigate to Game tab
                            (context.findAncestorStateOfType<
                                    _MainNavigationScreenState>())
                                ?.setState(() {
                              (context.findAncestorStateOfType<
                                      _MainNavigationScreenState>())
                                  ?._currentIndex = 1;
                            });
                          },
                          child: Text(
                            'Play again!',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'ProximaNova',
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],

              // Success message
              if (isCorrect) ...[
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.green, width: 1.5),
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.check_circle,
                        color: Colors.green,
                        size: 48,
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Congratulations!',
                        style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                          fontFamily: 'ProximaNova',
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'You guessed the secret word correctly!',
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: 16,
                          fontFamily: 'ProximaNova',
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 24),
                      if (widget.showAppBar) ...[
                        OutlinedButton(
                          onPressed: () => Navigator.pop(context),
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(color: Colors.green, width: 1.5),
                            padding: EdgeInsets.symmetric(
                              horizontal: 32,
                              vertical: 12,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text(
                            'Return to Game',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.green,
                              fontFamily: 'ProximaNova',
                            ),
                          ),
                        ),
                      ] else ...[
                        ElevatedButton(
                          onPressed: () {
                            // Navigate to Game tab
                            (context.findAncestorStateOfType<
                                    _MainNavigationScreenState>())
                                ?.setState(() {
                              (context.findAncestorStateOfType<
                                      _MainNavigationScreenState>())
                                  ?._currentIndex = 1;
                            });
                          },
                          child: Text(
                            'Play again!',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'ProximaNova',
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
