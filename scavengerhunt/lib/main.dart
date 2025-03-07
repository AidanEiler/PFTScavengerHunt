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
          'Question 3: By now you should have found a set of wide stairs. Going up, how many steps is it?(wooden step)',
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
      questionText: 'Question 6: Now that you have familiarized yourself with the first and second floor, it's time to proceed to the third. Whose office is 3209G?',
      correctAnswer: 'Mahmood Jasim',
    ),
    Question(
      questionText: 'Question 7: What room number is the office of Nash Mahmood?',
      correctAnswer: 'answer',
    ),
    Question(
      questionText: 'You're almost done In the central lobby of the third floor, how many screens are set up there?',
      correctAnswer: 'One',
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
  int totalGuesses =
      6; // Total number of guesses allowed across the entire quiz
  TextEditingController answerController = TextEditingController();
  String feedbackMessage = ''; // To show feedback message for wrong answers

  // Function to handle the answer submission
  void submitAnswer() {
    if (totalGuesses > 0) {
      // For the fifth question, allow both "Civil" and "Civil engineering" as valid answers
      if (currentQuestionIndex == 4) {
        // Fifth question (index 4)
        if (answerController.text.trim().toLowerCase() == 'civil' ||
            answerController.text.trim().toLowerCase() == 'civil engineering') {
          setState(() {
            score++;
            feedbackMessage = 'Correct!'; // Feedback for correct answer
          });
        } else {
          setState(() {
            totalGuesses--;
            feedbackMessage =
                'Incorrect! Please try again.'; // Feedback for incorrect answer
          });
        }
      } else {
        if (answerController.text.trim().toLowerCase() ==
            questions[currentQuestionIndex].correctAnswer.toLowerCase()) {
          setState(() {
            score++;
            feedbackMessage = 'Correct!'; // Feedback for correct answer
          });
        } else {
          setState(() {
            totalGuesses--;
            feedbackMessage =
                'Incorrect! Please try again.'; // Feedback for incorrect answer
          });
        }
      }

      // If we are not at the last question and have guesses left, go to the next question
      if (totalGuesses > 0 && currentQuestionIndex < questions.length - 1) {
        setState(() {
          currentQuestionIndex++; // Move to the next question
        });
      }
    }

    // If the user answers all the questions correctly or runs out of guesses, show the result
    if (score == questions.length || totalGuesses == 0) {
      _showResultDialog();
    }

    // Clear the input field after submitting the answer
    answerController.clear();
  }

  // Function to show the result dialog
  void _showResultDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Quiz Over'),
          content: Text(
              'Your score is $score/${questions.length}. You have $totalGuesses guesses left.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  currentQuestionIndex = 0;
                  score = 0;
                  totalGuesses = 6; // Reset guesses when restarting
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
            // Display the feedback message (for incorrect answers)
            Text(
              feedbackMessage,
              style: TextStyle(
                  fontSize: 18,
                  color: feedbackMessage == 'Correct!'
                      ? Colors.green
                      : Colors.red),
            ),
            SizedBox(height: 20),
            // Display the current score and guesses left
            Text(
              'Score: $score/${currentQuestionIndex + 1}\nGuesses left: $totalGuesses',
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
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
