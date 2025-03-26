import 'package:flutter/material.dart';
import 'dart:math';

void main() => runApp(MyApp());

class LSUColors {
  static const Color purple = Color(0xFF461D7C);
  static const Color gold = Color(0xFFFDD023);
  static const Color lightGold = Color(0xFFD29F13);
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
            colors: [LSUColors.lightGold, LSUColors.lightGold],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 40),
              Image.asset(
                'Assets/LSU.png',
                width: 300,
                height: 300,
              ),
              SizedBox(height: 20),
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
                    MaterialPageRoute(builder: (context) => GameSelectionScreen()),
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

class GameSelectionScreen extends StatelessWidget {
  const GameSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Game'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [LSUColors.lightGold, LSUColors.lightGold],
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Choose Your Challenge',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: LSUColors.purple,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 30),
                // Hangman Preview Card
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HangmanScreen()),
                    );
                  },
                  child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            LSUColors.gold.withOpacity(0.1),
                            LSUColors.gold.withOpacity(0.05),
                          ],
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: Column(
                          children: [
                            Icon(
                              Icons.games,
                              size: 60,
                              color: LSUColors.gold,
                            ),
                            SizedBox(height: 20),
                            Text(
                              'Hangman',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: LSUColors.gold,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              'Guess the secret word to unlock the mystery!',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: LSUColors.darkPurple,
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(height: 20),
                            // Hangman Preview
                            Container(
                              padding: EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: LSUColors.gold.withOpacity(0.3),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List.generate(
                                  8,
                                  (index) => Container(
                                    margin: EdgeInsets.symmetric(horizontal: 4),
                                    width: 30,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                        color: LSUColors.gold.withOpacity(0.3),
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Center(
                                      child: Text(
                                        index == 0 ? 'M' : '',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: LSUColors.gold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                // Questions Preview Card
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => QuestionsListScreen()),
                    );
                  },
                  child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            LSUColors.purple.withOpacity(0.1),
                            LSUColors.purple.withOpacity(0.05),
                          ],
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: Column(
                          children: [
                            Icon(
                              Icons.question_answer,
                              size: 60,
                              color: LSUColors.purple,
                            ),
                            SizedBox(height: 20),
                            Text(
                              'Questions',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: LSUColors.purple,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              'Test your knowledge about LSU engineering!',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: LSUColors.darkPurple,
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(height: 20),
                            // Questions Preview
                            Container(
                              padding: EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: LSUColors.purple.withOpacity(0.3),
                                ),
                              ),
                              child: Column(
                                children: [
                                  ListTile(
                                    title: Text(
                                      'Question 1',
                                      style: TextStyle(
                                        color: LSUColors.purple,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    subtitle: Text(
                                      'Between Zones 1100, 1200, and 1300...',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    trailing: Icon(
                                      Icons.arrow_forward_ios,
                                      color: LSUColors.purple,
                                      size: 16,
                                    ),
                                  ),
                                  Divider(color: LSUColors.purple.withOpacity(0.2)),
                                  ListTile(
                                    title: Text(
                                      'Question 2',
                                      style: TextStyle(
                                        color: LSUColors.purple,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    subtitle: Text(
                                      'Past this location up ahead...',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    trailing: Icon(
                                      Icons.arrow_forward_ios,
                                      color: LSUColors.purple,
                                      size: 16,
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class QuestionsListScreen extends StatelessWidget {
  const QuestionsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Question> questions = [
      Question(
        questionText: 'Between Zones 1100, 1200, and 1300, in which is the Panera Bread located?',
        correctAnswer: '1300',
      ),
      Question(
        questionText: 'Past this location up ahead, there should be a Bronze statue between two classrooms. What are the first three words on the plaque of the statue?',
        correctAnswer: 'Tau Beta Gamma',
      ),
      Question(
        questionText: 'By now you should have found a set of wide stairs. Going up, how many steps is it? (wooden steps)',
        correctAnswer: '11',
      ),
      Question(
        questionText: 'Now you are on the second floor. To your left are engineering labs, and to your right computer labs. What zone are the computer labs located in?',
        correctAnswer: '2300',
      ),
      Question(
        questionText: 'As soon as you turn left you should see a room with part of a car in it. What branch of engineering does this driving simulator lab belong to?',
        correctAnswer: 'Civil engineering',
      ),
      Question(
        questionText: 'Now that you have familiarized yourself with the first and second floor, it\'s time to proceed to the third. Whose office is 3209G?',
        correctAnswer: 'Mahmood Jasim',
      ),
      Question(
        questionText: 'What room number is the office of Nash Mahmood?',
        correctAnswer: '3209H',
      ),
      Question(
        questionText: 'You\'re almost done! In the central lobby of the third floor, how many screens are set up there?',
        correctAnswer: '1',
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Questions'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: questions.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.only(bottom: 16),
            child: ListTile(
              title: Text(
                'Question ${index + 1}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: LSUColors.purple,
                ),
              ),
              subtitle: Text(
                questions[index].questionText,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              trailing: Icon(Icons.arrow_forward_ios, color: LSUColors.purple),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => QuestionDetailScreen(
                      question: questions[index],
                      questionNumber: index + 1,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class QuestionDetailScreen extends StatefulWidget {
  final Question question;
  final int questionNumber;

  const QuestionDetailScreen({
    super.key,
    required this.question,
    required this.questionNumber,
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
      appBar: AppBar(
        title: Text('Question ${widget.questionNumber}'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  widget.question.questionText,
                  style: TextStyle(
                    fontSize: 18,
                    height: 1.4,
                    color: Colors.black87,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            if (!isAnswered) ...[
              TextField(
                controller: answerController,
                decoration: InputDecoration(
                  hintText: 'Type your answer here',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: LSUColors.purple, width: 2),
                  ),
                ),
                onSubmitted: (_) => submitAnswer(),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: submitAnswer,
                child: Text('Submit Answer'),
              ),
            ],
            if (feedbackMessage.isNotEmpty)
              Container(
                margin: EdgeInsets.only(top: 16),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: feedbackMessage.contains('Correct')
                      ? Colors.green.withOpacity(0.1)
                      : Colors.red.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: feedbackMessage.contains('Correct')
                        ? Colors.green
                        : Colors.red,
                    width: 1,
                  ),
                ),
                child: Text(
                  feedbackMessage,
                  style: TextStyle(
                    color: feedbackMessage.contains('Correct')
                        ? Colors.green
                        : Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class HangmanScreen extends StatefulWidget {
  const HangmanScreen({super.key});

  @override
  _HangmanScreenState createState() => _HangmanScreenState();
}

class _HangmanScreenState extends State<HangmanScreen> {
  final String secretWord = "MR DANIEL";
  List<bool> revealedLetters = [];
  List<String> guessedLetters = [];
  int remainingGuesses = 6;
  bool gameOver = false;
  bool gameWon = false;
  final TextEditingController guessController = TextEditingController();

  @override
  void initState() {
    super.initState();
    revealedLetters = List.generate(secretWord.length, (index) => false);
  }

  void submitGuess() {
    String guess = guessController.text.trim().toUpperCase();
    if (guess.isEmpty || guessedLetters.contains(guess)) return;

    setState(() {
      guessedLetters.add(guess);
    });

    if (secretWord.contains(guess)) {
      for (int i = 0; i < secretWord.length; i++) {
        if (secretWord[i] == guess) {
          revealedLetters[i] = true;
        }
      }
      if (revealedLetters.every((revealed) => revealed)) {
        gameWon = true;
        gameOver = true;
      }
    } else {
      remainingGuesses--;
      if (remainingGuesses <= 0) {
        gameOver = true;
      }
    }

    guessController.clear();
  }

  void resetGame() {
    setState(() {
      revealedLetters = List.generate(secretWord.length, (index) => false);
      guessedLetters = [];
      remainingGuesses = 6;
      gameOver = false;
      gameWon = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hangman'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.white, LSUColors.lightGold.withOpacity(0.3)],
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Remaining Guesses: $remainingGuesses',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: LSUColors.purple,
                ),
              ),
              SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  secretWord.length,
                  (index) => Container(
                    margin: EdgeInsets.symmetric(horizontal: 4),
                    width: 40,
                    height: 50,
                    decoration: BoxDecoration(
                      color: secretWord[index] != ' '
                          ? (revealedLetters[index]
                              ? LSUColors.lightGold
                              : Colors.white)
                          : Colors.transparent,
                      border: Border.all(
                        color: secretWord[index] == ' '
                            ? Colors.transparent
                            : (revealedLetters[index]
                                ? LSUColors.gold
                                : LSUColors.purple.withOpacity(0.3)),
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
              SizedBox(height: 40),
              if (!gameOver) ...[
                TextField(
                  controller: guessController,
                  decoration: InputDecoration(
                    hintText: 'Enter a letter',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: LSUColors.purple, width: 2),
                    ),
                  ),
                  maxLength: 1,
                  textCapitalization: TextCapitalization.characters,
                  onSubmitted: (_) => submitGuess(),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: submitGuess,
                  child: Text('Guess'),
                ),
              ],
              if (gameOver) ...[
                Text(
                  gameWon ? 'Congratulations! You won!' : 'Game Over!',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: gameWon ? Colors.green : Colors.red,
                  ),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: resetGame,
                  child: Text('Play Again'),
                ),
              ],
            ],
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
