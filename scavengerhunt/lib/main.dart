import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fill-in-the-Blank Quiz',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz App'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => GameScreen()),
            );
          },
          child: Text(
            'Start Quiz',
            style: TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }
}

class GameScreen extends StatefulWidget {
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  // List of quiz questions and correct answers
  final List<Question> questions = [
    Question(
      questionText: 'question?',
      correctAnswer: 'answer',
    ),
    Question(
      questionText: 'question?',
      correctAnswer: 'answer',
    ),
    Question(
      questionText: 'question?',
      correctAnswer: 'answer',
    ),
    Question(
      questionText: 'question?',
      correctAnswer: 'answer',
    ),
    Question(
      questionText: 'question?',
      correctAnswer: 'answer',
    ),
    Question(
      questionText: 'question?',
      correctAnswer: 'answer',
    ),
    Question(
      questionText: 'question?',
      correctAnswer: 'answer',
    ),
    Question(
      questionText: 'question?',
      correctAnswer: 'answer',
    ),
    Question(
      questionText: 'question?',
      correctAnswer: 'answer',
    ),
    Question(
      questionText: 'question?',
      correctAnswer: 'answer',
    ),
  ];

  int currentQuestionIndex = 0;
  int score = 0;
  TextEditingController answerController = TextEditingController();

  // Function to handle the answer submission
  void submitAnswer() {
    if (answerController.text.trim().toLowerCase() ==
        questions[currentQuestionIndex].correctAnswer.toLowerCase()) {
      setState(() {
        score++;
      });
    }

    // Move to the next question or end the quiz
    if (currentQuestionIndex < questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
      });
      answerController.clear();
    } else {
      // End the game
      _showResultDialog();
    }
  }

  // Function to show the result dialog
  void _showResultDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Quiz Over'),
          content: Text('Your score is $score/${questions.length}'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  currentQuestionIndex = 0;
                  score = 0;
                });
                answerController.clear();
              },
              child: Text('Restart'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop(); // Go back to home screen
              },
              child: Text('Home'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion = questions[currentQuestionIndex];
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz Game'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Display the current question
            Text(
              currentQuestion.questionText,
              style: TextStyle(fontSize: 24),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            // Text input for the user to enter their answer
            TextField(
              controller: answerController,
              decoration: InputDecoration(
                hintText: 'Type your answer here',
                border: OutlineInputBorder(),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              ),
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            // Submit button
            ElevatedButton(
              onPressed: submitAnswer,
              child: Text('Submit Answer'),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
              ),
            ),
            SizedBox(height: 20),
            // Display the current score
            Text(
              'Score: $score/${currentQuestionIndex + 1}',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}

// Question class to represent each quiz question
class Question {
  final String questionText;
  final String correctAnswer;

  Question({
    required this.questionText,
    required this.correctAnswer,
  });
}
