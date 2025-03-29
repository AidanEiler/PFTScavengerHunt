import 'package:flutter/material.dart';

const String globalFontFamily = 'ProximaNova';

void main() => runApp(MyApp());

class LSUColors {
  // Primary Colors
  static const Color purple = Color(0xFF461D7C); // Official LSU Purple
  static const Color gold = Color(0xFFFDD023); // Official LSU Gold

  // Tonal Palette
  static const Color corporatePurple = Color(0xFF3C1053); // Corporate Purple
  static const Color lightPurple = Color(0xFFA39AAC); // Light Purple
  static const Color corporateGold = Color(0xFFD29F13); // Corporate Gold
  static const Color lightGold = Color(0xFFF1EED8); // Light Gold

  // Neutral Palette
  static const Color lightGray = Color(0xFFD0D0CE); // Light Gray
  static const Color gray = Color(0xFF999999); // 50% Gray
  static const Color black = Color(0xFF333333);
  static const Color metallicGold = Color(0xFFAA8A3C);
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
      debugShowCheckedModeBanner: false, // Remove debug banner
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
  // The secret word without any spaces
  final String secretWord = "DRSHEPHERD";
  List<bool> revealedLetters = [];
  // Map to track which questions have been answered
  Map<int, bool> questionAnswered = {};
  // Define which letter is unlocked by each question (0-based index)
  final Map<int, int> questionToLetterMap = {
    0: 8, // Question 1 (previously 9) unlocks R
    1: 0, // Question 2 (previously 1) unlocks D
    2: 1, // Question 3 (previously 2) unlocks R
    3: 2, // Question 4 (previously 3) unlocks S
    4: 3, // Question 5 (previously 4) unlocks H
    5: 4, // Question 6 (previously 5) unlocks E
    6: 5, // Question 7 (previously 6) unlocks P
    7: 6, // Question 8 (previously 7) unlocks H
    8: 7, // Question 9 (previously 8) unlocks E
    9: 9, // Question 10 unlocks D
  };

  @override
  void initState() {
    super.initState();
    // Initialize the revealed letters state
    revealedLetters = List.generate(secretWord.length, (index) => false);
    // Initialize all questions as unanswered
    for (int i = 0; i < 10; i++) {
      questionAnswered[i] = false;
    }
  }

  // Method to reveal a letter when a specific question is answered
  void revealLetterForQuestion(int questionIndex) {
    if (questionAnswered[questionIndex] == true) {
      // Question already answered, don't reveal another letter
      return;
    }

    setState(() {
      // Mark this question as answered
      questionAnswered[questionIndex] = true;

      // Reveal the corresponding letter based on the mapping
      int letterIndex = questionToLetterMap[questionIndex] ?? 0;
      revealedLetters[letterIndex] = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Create screens with the current state
    final List<Widget> screens = [
      HomeScreen(),
      GameScreen(
        secretWord: secretWord,
        revealedLetters: revealedLetters,
        revealLetterForQuestion: revealLetterForQuestion,
        questionAnswered: questionAnswered,
      ),
      WordGuessDirectScreen(
        secretWord: secretWord,
        revealedLetters: revealedLetters,
      ),
    ];

    return Scaffold(
      body: screens[_currentIndex],
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
                const SizedBox(height: 24),
                // Title text directly without yellow container box
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
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
                      const SizedBox(height: 16),
                      Text(
                        'Explore what LSU has to offer for prospective engineers!',
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          height: 1.5,
                          fontFamily: globalFontFamily,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () {
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
  final String secretWord;
  final List<bool> revealedLetters;
  final Function(int) revealLetterForQuestion;
  final Map<int, bool> questionAnswered;

  const GameScreen({
    super.key,
    required this.secretWord,
    required this.revealedLetters,
    required this.revealLetterForQuestion,
    required this.questionAnswered,
  });

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final List<Question> questions = [
    Question(
      questionText:
          'Question 1: In section 1100, what is the room number of the auditorium?',
      correctAnswer: '1101',
    ),
    Question(
      questionText:
          'Question 2: Between Zones 1100, 1200, and 1300, in which is the Panera Bread located?',
      correctAnswer: '1300',
    ),
    Question(
      questionText:
          'Question 3: Past this location up ahead, there should be a Bronze statue between two classrooms. What are the first three words on the plaque of the statue?',
      correctAnswer: 'Tau Beta Gamma',
    ),
    Question(
      questionText:
          'Question 4: By now you should have found a set of wide stairs. Going up, how many steps is it? (wooden steps)',
      correctAnswer: '11',
    ),
    Question(
      questionText:
          'Question 5: Now you are on the second floor. To your left are engineering labs, and to your right computer labs. What zone are the computer labs located in?',
      correctAnswer: '2300',
    ),
    Question(
      questionText:
          'Question 6: As soon as you turn left you should see a room with part of a car in it. What branch of engineering does this driving simulator lab belong to?',
      correctAnswer: 'Civil engineering',
    ),
    Question(
      questionText:
          'Question 7: Now that you have familiarized yourself with the first and second floor, it\'s time to proceed to the third. Whose office is 3209G?',
      correctAnswer: 'Mahmood Jasim',
    ),
    Question(
      questionText:
          'Question 8: What room number is the office of Nash Mahmood?',
      correctAnswer: '3209H',
    ),
    Question(
      questionText:
          'Question 9: You\'re almost done! In the central lobby of the third floor, how many screens are set up there?',
      correctAnswer: '1',
    ),
    Question(
      questionText:
          'Question 10: Where is the office of the G.O.A.T David Shepherd?',
      correctAnswer: 'Dr. Shepherd\'s office',
    ),
  ];

  // Build letter tile for secret word display
  Widget buildLetterTile(String letter, bool isRevealed) {
    // Make tiles bigger by 3 pixels
    double tileWidth = 29; // Increased from 26

    return Container(
      width: tileWidth,
      height: tileWidth * 1.3,
      margin: const EdgeInsets.symmetric(horizontal: 1, vertical: 1),
      decoration: BoxDecoration(
        color: isRevealed ? LSUColors.purple : Colors.white,
        border: Border.all(
          color: isRevealed
              ? LSUColors.purple.withOpacity(0.8)
              : LSUColors.purple.withOpacity(0.3),
          width: isRevealed ? 1.5 : 1,
        ),
        borderRadius: BorderRadius.circular(3),
        boxShadow: isRevealed
            ? [
                BoxShadow(
                  color: LSUColors.purple.withOpacity(0.2),
                  blurRadius: 2,
                  offset: Offset(0, 1),
                )
              ]
            : null,
      ),
      child: Center(
        child: isRevealed
            ? Text(
                letter,
                style: const TextStyle(
                  fontSize: 17, // Increased from 14
                  fontWeight: FontWeight.bold,
                  color: LSUColors.gold,
                  fontFamily: 'ProximaNova',
                ),
              )
            : const Text(''),
      ),
    );
  }

  // Add simple spacer for the space between DR and SHEPHERD
  Widget buildSpacerTile() {
    return SizedBox(width: 6);
  }

  @override
  Widget build(BuildContext context) {
    // Force navigation to Guess Secret screen if all letters are revealed
    if (widget.revealedLetters.every((element) => element)) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final mainNav =
            context.findAncestorStateOfType<_MainNavigationScreenState>();
        if (mainNav != null && mainNav._currentIndex != 2) {
          mainNav.setState(() {
            mainNav._currentIndex = 2; // Go to Guess Secret screen
          });
        }
      });
    }

    return Scaffold(
      backgroundColor: LSUColors.purple,
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
                    color: Colors.white,
                    fontFamily: 'ProximaNova',
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              // Secret Word Display
              GestureDetector(
                onTap: () {
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
                          LSUColors.gold,
                          LSUColors.gold,
                        ],
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    height: 140,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 12),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Secret Word',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: LSUColors.purple,
                              fontFamily: globalFontFamily,
                            ),
                          ),
                          const SizedBox(height: 12),

                          // Single row for DR SHEPHERD
                          Center(
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  buildLetterTile(
                                      'D', widget.revealedLetters[0]),
                                  buildLetterTile(
                                      'R', widget.revealedLetters[1]),
                                  buildSpacerTile(),
                                  buildLetterTile(
                                      'S', widget.revealedLetters[2]),
                                  buildLetterTile(
                                      'H', widget.revealedLetters[3]),
                                  buildLetterTile(
                                      'E', widget.revealedLetters[4]),
                                  buildLetterTile(
                                      'P', widget.revealedLetters[5]),
                                  buildLetterTile(
                                      'H', widget.revealedLetters[6]),
                                  buildLetterTile(
                                      'E', widget.revealedLetters[7]),
                                  buildLetterTile(
                                      'R', widget.revealedLetters[8]),
                                  buildLetterTile(
                                      'D', widget.revealedLetters[9]),
                                ],
                              ),
                            ),
                          ),
                          // Purple "Tap to guess the word" button removed
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
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
                        LSUColors.gold,
                        LSUColors.gold,
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
                            bool isAnswered =
                                widget.questionAnswered[index] ?? false;
                            return Theme(
                                data: Theme.of(context)
                                    .copyWith(cardColor: LSUColors.lightGold),
                                child: Card(
                                  margin: const EdgeInsets.only(bottom: 10),
                                  elevation: 2,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  // Changed from green to LSU light grey for answered questions
                                  color: isAnswered
                                      ? LSUColors.lightGray
                                      : LSUColors.lightGold,
                                  child: ListTile(
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 8),
                                    title: Text(
                                      'Question ${index + 1}',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: isAnswered
                                            ? Colors.green.shade700
                                            : LSUColors.purple,
                                        fontSize: 16,
                                        fontFamily: 'ProximaNova',
                                      ),
                                    ),
                                    subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 4, bottom: 4),
                                          child: Text(
                                            questions[index].questionText,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              color: LSUColors.black
                                                  .withOpacity(0.8),
                                            ),
                                          ),
                                        ),
                                        if (isAnswered)
                                          Text(
                                            'Answer: ${questions[index].correctAnswer}',
                                            style: TextStyle(
                                              color: Colors.green.shade700,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                      ],
                                    ),
                                    trailing: isAnswered
                                        ? Container(
                                            padding: EdgeInsets.all(8),
                                            decoration: BoxDecoration(
                                              color:
                                                  Colors.green.withOpacity(0.1),
                                              shape: BoxShape.circle,
                                            ),
                                            child: const Icon(Icons.check,
                                                color: Colors.green, size: 20))
                                        : Container(
                                            padding: EdgeInsets.all(8),
                                            decoration: BoxDecoration(
                                              color: LSUColors.gold
                                                  .withOpacity(0.2),
                                              shape: BoxShape.circle,
                                            ),
                                            child: const Icon(
                                                Icons.arrow_forward_ios,
                                                color: LSUColors.corporateGold,
                                                size: 16)),
                                    onTap: () {
                                      if (!isAnswered) {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                QuestionDetailScreen(
                                              question: questions[index],
                                              questionNumber: index + 1,
                                              onAnswered: (bool isCorrect) {
                                                if (isCorrect && !isAnswered) {
                                                  widget
                                                      .revealLetterForQuestion(
                                                          index);
                                                  setState(() {});
                                                }
                                              },
                                            ),
                                          ),
                                        );
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                                'You\'ve already answered this question!'),
                                            backgroundColor: Colors.green,
                                            duration: Duration(seconds: 2),
                                          ),
                                        );
                                      }
                                    },
                                  ),
                                ));
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
      backgroundColor: LSUColors.purple,
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
                      LSUColors.lightGold,
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
            // Only show input fields if not answered yet
            if (!isAnswered) ...[
              TextField(
                controller: answerController,
                decoration: InputDecoration(
                  hintText: 'Type your answer here!',
                  filled: true,
                  fillColor: LSUColors.lightGold,
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
            // Fixed the feedback message to prevent overflow
            if (feedbackMessage.isNotEmpty && !isAnswered)
              Container(
                margin: const EdgeInsets.only(top: 24),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 2),
                      child: Icon(
                        feedbackMessage.contains('Correct')
                            ? Icons.check_circle
                            : Icons.error,
                        color: feedbackMessage.contains('Correct')
                            ? Colors.green
                            : Colors.red,
                        size: 20,
                      ),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        feedbackMessage,
                        style: TextStyle(
                          color: feedbackMessage.contains('Correct')
                              ? Colors.green
                              : Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                        softWrap: true,
                        overflow: TextOverflow.visible,
                      ),
                    ),
                  ],
                ),
              ),
            // Success message when answered correctly
            if (isAnswered) ...[
              const SizedBox(height: 30),
              Container(
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
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
                      size: 36,
                    ),
                    SizedBox(height: 12),
                    Text(
                      'Congratulations!',
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        fontFamily: 'ProximaNova',
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Correct Answer: ${widget.question.correctAnswer}',
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'ProximaNova',
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 8),
                    Text(
                      'You\'ve unlocked a letter in the secret word!',
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 16,
                        fontFamily: 'ProximaNova',
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
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
  final TextEditingController guessController = TextEditingController();
  String feedbackMessage = '';
  bool isCorrect = false;

  // Build letter tile for secret word display
  Widget buildLetterTile(String letter, bool isRevealed) {
    // Make tiles bigger by 3 pixels
    double tileWidth = 29; // Increased from 26

    return Container(
      width: tileWidth,
      height: tileWidth * 1.3,
      margin: const EdgeInsets.symmetric(horizontal: 1, vertical: 1),
      decoration: BoxDecoration(
        color: isRevealed ? LSUColors.purple : Colors.white,
        border: Border.all(
          color: isRevealed
              ? LSUColors.purple.withOpacity(0.8)
              : LSUColors.purple.withOpacity(0.3),
          width: isRevealed ? 1.5 : 1,
        ),
        borderRadius: BorderRadius.circular(3),
        boxShadow: isRevealed
            ? [
                BoxShadow(
                  color: LSUColors.purple.withOpacity(0.2),
                  blurRadius: 2,
                  offset: Offset(0, 1),
                )
              ]
            : null,
      ),
      child: Center(
        child: isRevealed
            ? Text(
                letter,
                style: const TextStyle(
                  fontSize: 17, // Increased from 14
                  fontWeight: FontWeight.bold,
                  color: LSUColors.gold,
                  fontFamily: 'ProximaNova',
                ),
              )
            : const Text(''),
      ),
    );
  }

  // Add simple spacer for the space between DR and SHEPHERD
  Widget buildSpacerTile() {
    return SizedBox(width: 6);
  }

  void submitGuess() {
    // Remove spaces from the input for comparison
    String guess = guessController.text.trim().toUpperCase();

    if (guess == widget.secretWord || guess == 'DR SHEPHERD') {
      setState(() {
        isCorrect = true;
        feedbackMessage = 'Correct!';
      });

      // Update the parent's state to reveal all letters
      final mainNav =
          context.findAncestorStateOfType<_MainNavigationScreenState>();
      if (mainNav != null) {
        mainNav.setState(() {
          for (int i = 0; i < mainNav.revealedLetters.length; i++) {
            mainNav.revealedLetters[i] = true;
          }
        });
      }
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
      backgroundColor: LSUColors.purple,
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
          // Using the exact same padding as GameScreen
          padding: const EdgeInsets.fromLTRB(16, 30, 16, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (!widget.showAppBar)
                Padding(
                  padding: const EdgeInsets.only(
                      bottom: 20), // Match GameScreen's 20px bottom padding
                  child: Text(
                    'PFT Code Cracker',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontFamily: 'ProximaNova',
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),

              // Secret Word Card with Tiles
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
                        LSUColors.gold,
                        LSUColors.gold,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  height: 140, // Same height as in GameScreen
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 12), // Same padding as in GameScreen
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Secret Word',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: LSUColors.purple,
                            fontFamily: globalFontFamily,
                          ),
                        ),
                        const SizedBox(height: 12),

                        // Single row for DR SHEPHERD
                        Center(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                buildLetterTile('D', widget.revealedLetters[0]),
                                buildLetterTile('R', widget.revealedLetters[1]),
                                buildSpacerTile(),
                                buildLetterTile('S', widget.revealedLetters[2]),
                                buildLetterTile('H', widget.revealedLetters[3]),
                                buildLetterTile('E', widget.revealedLetters[4]),
                                buildLetterTile('P', widget.revealedLetters[5]),
                                buildLetterTile('H', widget.revealedLetters[6]),
                                buildLetterTile('E', widget.revealedLetters[7]),
                                buildLetterTile('R', widget.revealedLetters[8]),
                                buildLetterTile('D', widget.revealedLetters[9]),
                              ],
                            ),
                          ),
                        ),
                        // "Tap to guess the word" button has been removed
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24), // Same spacing as GameScreen

              // Only show the input field and submit button if not all letters are revealed and it's not correct
              if (!isCorrect &&
                  !widget.revealedLetters.every((element) => element)) ...[
                TextField(
                  controller: guessController,
                  decoration: InputDecoration(
                    hintText: 'Type your guess here!',
                    filled: true,
                    fillColor: LSUColors.lightGold,
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

              // Feedback message
              if (feedbackMessage.isNotEmpty &&
                  !isCorrect &&
                  !widget.revealedLetters.every((element) => element))
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

              // All letters revealed message - Yellow background with purple text
              if (widget.revealedLetters.every((element) => element) &&
                  !isCorrect) ...[
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: LSUColors.gold, // Changed to solid gold (yellow)
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
                          color: LSUColors.purple, // Changed to purple
                          fontFamily: 'ProximaNova',
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Continue exploring the building to answer all the questions!',
                        style: TextStyle(
                          fontSize: 16,
                          color: LSUColors.purple, // Changed to purple
                          fontFamily: 'ProximaNova',
                        ),
                        textAlign: TextAlign.center,
                      ),
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
                          'Go to Questions',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'ProximaNova',
                          ),
                        ),
                      ),
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
                            'Go to Questions',
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

class WordGuessDirectScreen extends StatefulWidget {
  final String secretWord;
  final List<bool> revealedLetters;

  const WordGuessDirectScreen({
    super.key,
    required this.secretWord,
    required this.revealedLetters,
  });

  @override
  _WordGuessDirectScreenState createState() => _WordGuessDirectScreenState();
}

class _WordGuessDirectScreenState extends State<WordGuessDirectScreen> {
  @override
  Widget build(BuildContext context) {
    return WordGuessScreen(
      secretWord: widget.secretWord,
      revealedLetters: widget.revealedLetters,
      showAppBar: false,
    );
  }
}
