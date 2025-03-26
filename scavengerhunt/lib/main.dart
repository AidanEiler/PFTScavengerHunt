import 'package:flutter/material.dart';

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
              // Add LSU logo
              Image.asset(
                'Assets/LSU.png',
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.width * 0.8,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: MediaQuery.of(context).size.width * 0.8,
                    color: Colors.grey[200],
                    child: Center(
                      child: Text(
                        'LSU Logo',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 20,
                        ),
                      ),
                    ),
                  );
                },
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PFT Code Cracker'),
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
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Secret Word Display
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => WordGuessScreen(
                        secretWord: secretWord,
                        revealedLetters: revealedLetters,
                      ),
                    ),
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
                          Text(
                            'Secret Word',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: LSUColors.gold,
                            ),
                          ),
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(
                              secretWord.length,
                              (index) => Container(
                                margin: EdgeInsets.symmetric(horizontal: 4),
                                width: 30,
                                height: 40,
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
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                color: LSUColors.purple,
                                              ),
                                            )
                                          : Text('')),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Tap to guess the word',
                            style: TextStyle(
                              color: LSUColors.darkPurple,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              // Questions List
              Card(
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Questions',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: LSUColors.purple,
                          ),
                        ),
                        SizedBox(height: 20),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: questions.length,
                          itemBuilder: (context, index) {
                            return Card(
                              margin: EdgeInsets.only(bottom: 10),
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
                                trailing: questionAnswered[index]
                                    ? Icon(Icons.check_circle, color: Colors.green)
                                    : Icon(Icons.arrow_forward_ios, color: LSUColors.purple),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => QuestionDetailScreen(
                                        question: questions[index],
                                        questionNumber: index + 1,
                                        onAnswered: (bool isCorrect) {
                                          if (isCorrect && !questionAnswered[index]) {
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

class Question {
  final String questionText;
  final String correctAnswer;

  Question({
    required this.questionText,
    required this.correctAnswer,
  });
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
      appBar: AppBar(
        title: Text('Question ${widget.questionNumber}'),
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
      ),
    );
  }
}

class WordGuessScreen extends StatefulWidget {
  final String secretWord;
  final List<bool> revealedLetters;

  const WordGuessScreen({
    super.key,
    required this.secretWord,
    required this.revealedLetters,
  });

  @override
  _WordGuessScreenState createState() => _WordGuessScreenState();
}

class _WordGuessScreenState extends State<WordGuessScreen> {
  final TextEditingController guessController = TextEditingController();
  String feedbackMessage = '';
  bool isCorrect = false;

  void submitGuess() {
    String guess = guessController.text.trim().toUpperCase();
    if (guess == widget.secretWord) {
      setState(() {
        isCorrect = true;
        feedbackMessage = 'Congratulations! You got it right!';
      });
    } else {
      setState(() {
        feedbackMessage = 'Try again!';
      });
    }
    guessController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Guess the Word'),
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
                'Current Progress',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: LSUColors.purple,
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  widget.secretWord.length,
                  (index) => Container(
                    margin: EdgeInsets.symmetric(horizontal: 4),
                    width: 40,
                    height: 50,
                    decoration: BoxDecoration(
                      color: widget.secretWord[index] != ' '
                          ? (widget.revealedLetters[index]
                              ? LSUColors.lightGold
                              : Colors.white)
                          : Colors.transparent,
                      border: Border.all(
                        color: widget.secretWord[index] == ' '
                            ? Colors.transparent
                            : (widget.revealedLetters[index]
                                ? LSUColors.gold
                                : LSUColors.purple.withOpacity(0.3)),
                        width: widget.revealedLetters[index] ? 2 : 1,
                      ),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Center(
                      child: widget.secretWord[index] == ' '
                          ? SizedBox(width: 16)
                          : (widget.revealedLetters[index]
                              ? Text(
                                  widget.secretWord[index],
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
              if (!isCorrect) ...[
                TextField(
                  controller: guessController,
                  decoration: InputDecoration(
                    hintText: 'Enter your guess',
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
                  textCapitalization: TextCapitalization.characters,
                  onSubmitted: (_) => submitGuess(),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: submitGuess,
                  child: Text('Submit Guess'),
                ),
              ],
              if (feedbackMessage.isNotEmpty)
                Container(
                  margin: EdgeInsets.only(top: 16),
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: feedbackMessage.contains('Congratulations')
                        ? Colors.green.withOpacity(0.1)
                        : Colors.red.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: feedbackMessage.contains('Congratulations')
                          ? Colors.green
                          : Colors.red,
                      width: 1,
                    ),
                  ),
                  child: Text(
                    feedbackMessage,
                    style: TextStyle(
                      color: feedbackMessage.contains('Congratulations')
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
      ),
    );
  }
}
