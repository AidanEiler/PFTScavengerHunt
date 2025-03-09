import 'package:flutter/material.dart';
import 'dart:math';

void main() => runApp(MyApp());

class LSUColors {
  static const Color purple = Color(0xFF461D7C);
  static const Color gold = Color(0xFFFDD023);
  static const Color lightGold = Color(0xFFFEE99D);
  static const Color darkPurple = Color(0xFF2D1250);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PFT Code Cracker',
      theme: ThemeData(
        primaryColor: LSUColors.purple,
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: LSUColors.purple,
          secondary: LSUColors.gold,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: LSUColors.purple,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: LSUColors.purple,
          ),
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: LSUColors.purple,
          foregroundColor: Colors.white,
        ),
        fontFamily: 'Roboto',
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PFT Code Cracker'),
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.white, LSUColors.lightGold],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 40),
              Text(
                'PFT Code Cracker',
                style: TextStyle(
                  fontSize: 32, 
                  fontWeight: FontWeight.bold,
                  color: LSUColors.purple,
                  letterSpacing: 1.2,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: Text(
                  'Explore what LSU has to offer for prospective engineers!',
                  style: TextStyle(
                    fontSize: 18,
                    color: LSUColors.darkPurple,
                    height: 1.5,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 60),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => GameScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  elevation: 5,
                  shadowColor: Colors.black38,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Start Game',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.0,
                      ),
                    ),
                    SizedBox(width: 10),
                    Icon(Icons.arrow_forward),
                  ],
                ),
              ),
            ],
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
  ];

  int currentQuestionIndex = 0;
  TextEditingController answerController = TextEditingController();
  TextEditingController wordGuessController = TextEditingController();
  String feedbackMessage = '';

  List<bool> questionAnswered = [];

  final String secretWord = "MR DANIEL";
  List<bool> revealedLetters = [];

  @override
  void initState() {
    super.initState();
    questionAnswered = List.generate(questions.length, (index) => false);
    revealedLetters = List.generate(secretWord.length, (index) => false);
  }

  void submitAnswer() {
    String userAnswer = answerController.text.trim().toLowerCase();
    String correctAnswer =
        questions[currentQuestionIndex].correctAnswer.toLowerCase();

    if (userAnswer == correctAnswer) {
      setState(() {
        if (!questionAnswered[currentQuestionIndex]) {
          questionAnswered[currentQuestionIndex] = true;
          revealRandomLetter();
        }
        feedbackMessage = 'Correct!';
      });

      if (currentQuestionIndex < questions.length - 1) {
        Future.delayed(Duration(milliseconds: 800), () {
          if (mounted) {
            nextQuestion();
          }
        });
      }
    } else {
      setState(() {
        feedbackMessage = 'Incorrect! Try again.';
      });
    }

    answerController.clear();
    
    if (questionAnswered.every((answered) => answered == true)) {
      setState(() {
        revealedLetters = List.generate(secretWord.length, (index) => true);
      });
      Future.delayed(Duration(milliseconds: 500), () {
        if (mounted) {
          _showCompletionDialog();
        }
      });
    }
    
    if (revealedLetters.every((revealed) => revealed)) {
      _showCompletionDialog();
    }
  }

  void revealRandomLetter() {
    List<int> unrevealedIndices = [];
    for (int i = 0; i < revealedLetters.length; i++) {
      if (!revealedLetters[i] && secretWord[i] != ' ') {
        unrevealedIndices.add(i);
      }
    }

    if (unrevealedIndices.isNotEmpty) {
      final random = Random();
      int randomIndex =
          unrevealedIndices[random.nextInt(unrevealedIndices.length)];
      setState(() {
        revealedLetters[randomIndex] = true;
      });
    }
  }

  void submitWordGuess() {
    String userWordGuess = wordGuessController.text.trim().toLowerCase();

    if (userWordGuess == secretWord.toLowerCase()) {
      setState(() {
        feedbackMessage = 'Correct! You guessed the word!';
      });

      _showCompletionDialog();
    } else {
      setState(() {
        feedbackMessage = 'Incorrect! Try again.';
      });
    }

    wordGuessController.clear();
  }

  void _showCompletionDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.emoji_events, color: LSUColors.gold, size: 30),
              SizedBox(width: 10),
              Text(
                'Congratulations!',
                style: TextStyle(
                  color: LSUColors.purple,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: LSUColors.lightGold,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  'Secret Word: $secretWord',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: LSUColors.purple,
                    letterSpacing: 1.5,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'You\'ve completed the PFT Code Cracker challenge!',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              Text(
                'Geaux Tigers! 🐯',
                style: TextStyle(
                  fontSize: 18, 
                  fontWeight: FontWeight.bold,
                  color: LSUColors.darkPurple,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                resetGame();
              },
              child: Text(
                'Play Again',
                style: TextStyle(
                  color: LSUColors.purple,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
              child: Text('Review'),
            ),
          ],
        );
      },
    );
  }

  void resetGame() {
    setState(() {
      currentQuestionIndex = 0;
      questionAnswered = List.generate(questions.length, (index) => false);
      revealedLetters = List.generate(secretWord.length, (index) => false);
      feedbackMessage = '';
      wordGuessController.clear();
    });
  }

  void nextQuestion() {
    if (currentQuestionIndex < questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
        feedbackMessage = ''; 
        answerController.clear();
      });
    }
  }

  void previousQuestion() {
    if (currentQuestionIndex > 0) {
      setState(() {
        currentQuestionIndex--;
        feedbackMessage = '';
        answerController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion = questions[currentQuestionIndex];
    int answeredCount = questionAnswered.where((answered) => answered).length;

    return Scaffold(
      appBar: AppBar(
        title: Text('PFT Code Cracker'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Reset Quest?'),
                    content: Text('This will clear all your progress.'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text('Cancel'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          resetGame();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                        ),
                        child: Text('Reset'),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.white, LSUColors.lightGold.withOpacity(0.3)],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 20),
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                  decoration: BoxDecoration(
                    color: LSUColors.purple.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: LSUColors.purple.withOpacity(0.3), width: 1),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.lock_open, color: LSUColors.gold),
                          SizedBox(width: 8),
                          Text(
                            'Secret Word',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: LSUColors.purple,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          secretWord.length,
                          (index) => Container(
                            margin: EdgeInsets.symmetric(horizontal: 4),
                            width: 32,
                            height: 42,
                            decoration: BoxDecoration(
                              color: secretWord[index] != ' ' 
                                  ? (revealedLetters[index] ? LSUColors.lightGold : Colors.white)
                                  : Colors.transparent,
                              border: Border.all(
                                color: secretWord[index] == ' '
                                    ? Colors.transparent
                                    : (revealedLetters[index] ? LSUColors.gold : LSUColors.purple.withOpacity(0.3)),
                                width: revealedLetters[index] ? 2 : 1,
                              ),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Center(
                              child: secretWord[index] == ' '
                                  ? SizedBox(width: 16)
                                  : (revealedLetters[index]
                                      ? Text(
                                          secretWord[index],
                                          style: TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                            color: LSUColors.purple,
                                          ),
                                        )
                                      : Text('')),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                Container(
                  margin: EdgeInsets.only(bottom: 20),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.analytics, color: LSUColors.purple, size: 18),
                          SizedBox(width: 6),
                          Text(
                            'Progress: $answeredCount/${questions.length}',
                            style: TextStyle(
                              fontSize: 16,
                              color: LSUColors.darkPurple,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: LinearProgressIndicator(
                          value: answeredCount / questions.length,
                          minHeight: 10,
                          backgroundColor: Colors.grey.shade200,
                          valueColor: AlwaysStoppedAnimation<Color>(LSUColors.gold),
                        ),
                      ),
                    ],
                  ),
                ),

                Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(
                      color: questionAnswered[currentQuestionIndex]
                          ? LSUColors.gold
                          : Colors.transparent,
                      width: 2,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: LSUColors.purple,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                'Question ${currentQuestionIndex + 1}',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            if (questionAnswered[currentQuestionIndex])
                              Container(
                                padding: EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: LSUColors.lightGold,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.check,
                                  color: LSUColors.gold,
                                  size: 20,
                                ),
                              ),
                          ],
                        ),
                        SizedBox(height: 16),
                        Text(
                          currentQuestion.questionText,
                          style: TextStyle(
                            fontSize: 18,
                            height: 1.4,
                            color: Colors.black87,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 24),

                if (!questionAnswered[currentQuestionIndex])
                  Container(
                    width: 280,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: TextField(
                      controller: answerController,
                      decoration: InputDecoration(
                        hintText: 'Type your answer here',
                        filled: true,
                        fillColor: Colors.white,
                        prefixIcon: Icon(Icons.search, color: LSUColors.purple),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.grey.shade300),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.grey.shade300),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: LSUColors.purple, width: 2),
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                      ),
                      style: TextStyle(fontSize: 16),
                      textCapitalization: TextCapitalization.sentences,
                      textInputAction: TextInputAction.done,
                      onSubmitted: (_) => submitAnswer(),
                    ),
                  ),

                SizedBox(height: 16),

                if (!questionAnswered[currentQuestionIndex])
                  ElevatedButton.icon(
                    onPressed: submitAnswer,
                    icon: Icon(Icons.check_circle_outline),
                    label: Text('Submit Answer'),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      minimumSize: Size(280, 48),
                    ),
                  ),
                
                if (questionAnswered[currentQuestionIndex])
                  Container(
                    margin: EdgeInsets.only(top: 16),
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.green.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: Colors.green,
                        width: 1,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.check_circle,
                          color: Colors.green,
                          size: 20,
                        ),
                        SizedBox(width: 8),
                        Text(
                          'Correct! Question completed',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.green,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),

                if (feedbackMessage.contains('Incorrect'))
                  Container(
                    margin: EdgeInsets.only(top: 16),
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.red.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: Colors.red,
                        width: 1,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.error,
                          color: Colors.red,
                          size: 18,
                        ),
                        SizedBox(width: 8),
                        Text(
                          feedbackMessage,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.red,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),

                SizedBox(height: 24),

                Container(
                  margin: EdgeInsets.only(top: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: currentQuestionIndex > 0 ? previousQuestion : null,
                        icon: Icon(Icons.arrow_back_ios),
                        color: currentQuestionIndex > 0 ? LSUColors.purple : Colors.grey,
                        tooltip: 'Previous',
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: LSUColors.purple.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          '${currentQuestionIndex + 1} / ${questions.length}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: LSUColors.purple,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: currentQuestionIndex < questions.length - 1 ? nextQuestion : null,
                        icon: Icon(Icons.arrow_forward_ios),
                        color: currentQuestionIndex < questions.length - 1 ? LSUColors.purple : Colors.grey,
                        tooltip: 'Next',
                      ),
                    ],
                  ),
                ),

                Divider(height: 40, color: Colors.grey.shade300),

                Container(
                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                  decoration: BoxDecoration(
                    color: LSUColors.purple.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Know the Secret Word?',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: LSUColors.purple,
                        ),
                      ),
                      SizedBox(height: 16),
                      Container(
                        width: 280,
                        child: TextField(
                          controller: wordGuessController,
                          decoration: InputDecoration(
                            hintText: 'Enter the secret word',
                            filled: true,
                            fillColor: Colors.white,
                            prefixIcon: Icon(Icons.vpn_key, color: LSUColors.gold),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(color: LSUColors.gold, width: 2),
                            ),
                          ),
                          textCapitalization: TextCapitalization.characters,
                          textInputAction: TextInputAction.done,
                          onSubmitted: (_) => submitWordGuess(),
                        ),
                      ),
                      SizedBox(height: 16),
                      ElevatedButton.icon(
                        onPressed: submitWordGuess,
                        icon: Icon(Icons.lock_open),
                        label: Text('Submit Word'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: LSUColors.gold,
                          foregroundColor: LSUColors.purple,
                          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                          minimumSize: Size(280, 48),
                        ),
                      ),
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

class Question {
  final String questionText;
  final String correctAnswer;

  Question({
    required this.questionText,
    required this.correctAnswer,
  });
}