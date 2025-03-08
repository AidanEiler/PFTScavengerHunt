import 'package:flutter/material.dart';
import 'dart:math';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PFT Explorer Quiz',
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
        title: Text('PFT Explorer Quiz'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Explore Patrick F. Taylor Hall',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Text(
              'Answer questions as you explore the building\nand reveal the secret word!',
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GameScreen()),
                );
              },
              child: Text(
                'Start Exploring',
                style: TextStyle(fontSize: 24),
              ),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              ),
            ),
          ],
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
      questionText:
          'Question 6: Now that you have familiarized yourself with the first and second floor, it\'s time to proceed to the third. Whose office is 3209G?',
      correctAnswer: 'Mahmood Jasim',
    ),
    Question(
      questionText: 'Question 7: What room number is the office of Nash Mahmood?',
      correctAnswer: '3209H',
    ),
    Question(
      questionText: 'Question 8: You\'re almost done! In the central lobby of the third floor, how many screens are set up there?',
      correctAnswer: '1',
    ),
  ];

  int currentQuestionIndex = 0;
  TextEditingController answerController = TextEditingController();
  TextEditingController wordGuessController = TextEditingController();
  String feedbackMessage = '';
  
  // Track answered questions
  List<bool> questionAnswered = [];
  
  // Secret word to be revealed
  final String secretWord = "MR DANIEL";
  List<bool> revealedLetters = [];
  
  @override
  void initState() {
    super.initState();
    // Initialize questionAnswered list with all false values
    questionAnswered = List.generate(questions.length, (index) => false);
    // Initialize revealedLetters list with all false values
    revealedLetters = List.generate(secretWord.length, (index) => false);
  }

  // Function to handle the answer submission
  void submitAnswer() {
    String userAnswer = answerController.text.trim().toLowerCase();
    String correctAnswer = questions[currentQuestionIndex].correctAnswer.toLowerCase();
    
    // For the fifth question, allow both "Civil" and "Civil engineering" as valid answers
    if (currentQuestionIndex == 4 && (userAnswer == 'civil' || userAnswer == 'civil engineering')) {
      setState(() {
        if (!questionAnswered[currentQuestionIndex]) {
          questionAnswered[currentQuestionIndex] = true;
          revealRandomLetter();
        }
        feedbackMessage = 'Correct!';
      });
      
      // Automatically move to the next question if possible
      if (currentQuestionIndex < questions.length - 1) {
        // Use Future.delayed to give user a moment to see "Correct!" message
        Future.delayed(Duration(milliseconds: 800), () {
          if (mounted) {
            nextQuestion();
          }
        });
      }
    } else if (userAnswer == correctAnswer) {
      setState(() {
        if (!questionAnswered[currentQuestionIndex]) {
          questionAnswered[currentQuestionIndex] = true;
          revealRandomLetter();
        }
        feedbackMessage = 'Correct!';
      });
      
      // Automatically move to the next question if possible
      if (currentQuestionIndex < questions.length - 1) {
        // Use Future.delayed to give user a moment to see "Correct!" message
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
    
    // Clear the input field after submitting the answer
    answerController.clear();
    
    // Check if all letters have been revealed
    if (revealedLetters.every((revealed) => revealed)) {
      _showCompletionDialog();
    }
  }
  
  // Function to reveal a random letter in the secret word
  void revealRandomLetter() {
    // Count unrevealed letters (skip spaces)
    List<int> unrevealedIndices = [];
    for (int i = 0; i < revealedLetters.length; i++) {
      if (!revealedLetters[i] && secretWord[i] != ' ') {
        unrevealedIndices.add(i);
      }
    }
    
    // If there are still letters to reveal
    if (unrevealedIndices.isNotEmpty) {
      // Select a random unrevealed letter
      final random = Random();
      int randomIndex = unrevealedIndices[random.nextInt(unrevealedIndices.length)];
      
      // Reveal that letter
      setState(() {
        revealedLetters[randomIndex] = true;
      });
    }
  }
  
  // Navigate to the next question
  void nextQuestion() {
    if (currentQuestionIndex < questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
        feedbackMessage = '';
        answerController.clear();
      });
    }
  }
  
  // Navigate to the previous question
  void previousQuestion() {
    if (currentQuestionIndex > 0) {
      setState(() {
        currentQuestionIndex--;
        feedbackMessage = '';
        answerController.clear();
      });
    }
  }

  // Function to show the completion dialog
  void _showCompletionDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Congratulations!'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'You\'ve revealed the entire secret word: $secretWord!',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 20),
              Text(
                'You\'ve completed the PFT Explorer Quiz.',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                resetGame(); // Reset game for replay
              },
              child: Text('Play Again'),
            ),
          ],
        );
      },
    );
  }

  // Function to reset the game
  void resetGame() {
    setState(() {
      // Reset game state
      currentQuestionIndex = 0;
      questionAnswered = List.generate(questions.length, (index) => false);
      revealedLetters = List.generate(secretWord.length, (index) => false);
      feedbackMessage = '';
      wordGuessController.clear();
    });
  }

  // Function to submit the word guess
  void submitWordGuess() {
    String userWordGuess = wordGuessController.text.trim().toLowerCase();

    // Check if the word guess is correct
    if (userWordGuess == secretWord.toLowerCase()) {
      setState(() {
        feedbackMessage = 'Correct! You guessed the word!';
      });

      // Show completion dialog after word is guessed correctly
      _showCompletionDialog();
    } else {
      setState(() {
        feedbackMessage = 'Incorrect! Try again.';
      });
    }

    // Clear the input field after submitting the word
    wordGuessController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion = questions[currentQuestionIndex];
    
    // Count answered questions
    int answeredCount = questionAnswered.where((answered) => answered).length;
    
    return Scaffold(
      appBar: AppBar(
        title: Text('PFT Explorer Quiz'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // Secret word display (hangman-style)
            Container(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Column(
                children: [
                  Text(
                    'Secret Word',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      secretWord.length,
                      (index) => Container(
                        margin: EdgeInsets.symmetric(horizontal: 5),
                        width: 40,
                        height: 50,
                        decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(width: 2, color: secretWord[index] == ' ' ? Colors.transparent : Colors.black)),
                        ),
                        child: Center(
                          child: secretWord[index] == ' ' 
                              ? SizedBox(width: 20) // Show empty space
                              : (revealedLetters[index]
                                  ? Text(
                                      secretWord[index],
                                      style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                                    )
                                  : Text('')),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: 10),
            
            // Progress indicator
            Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Text(
                'Progress: $answeredCount/${questions.length} questions answered',
                style: TextStyle(fontSize: 16),
              ),
            ),
            
            Divider(),
            
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Display the current question
                    Text(
                      currentQuestion.questionText,
                      style: TextStyle(fontSize: 20),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20),
                    
                    // Text input for the user to enter their answer
                    TextField(
                      controller: answerController,
                      decoration: InputDecoration(
                        hintText: 'Type your answer here',
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
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
                    SizedBox(height: 15),
                    
                    // Display feedback message
                    Text(
                      feedbackMessage,
                      style: TextStyle(
                        fontSize: 18,
                        color: feedbackMessage.contains('Correct')
                            ? Colors.green
                            : Colors.red,
                      ),
                    ),
                    
                    SizedBox(height: 15),
                    
                    // Show a checkmark if question is answered correctly
                    if (questionAnswered[currentQuestionIndex])
                      Icon(Icons.check_circle, color: Colors.green, size: 30),
                  ],
                ),
              ),
            ),
            
            // Navigation buttons
            Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: currentQuestionIndex > 0 ? previousQuestion : null,
                    child: Icon(Icons.arrow_back),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueGrey,
                    ),
                  ),
                  Text(
                    'Question ${currentQuestionIndex + 1} of ${questions.length}',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  ElevatedButton(
                    onPressed: currentQuestionIndex < questions.length - 1 ? nextQuestion : null,
                    child: Icon(Icons.arrow_forward),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueGrey,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),

            // Word Guess section
            TextField(
              controller: wordGuessController,
              decoration: InputDecoration(
                hintText: 'Guess the secret word',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              ),
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: submitWordGuess,
              child: Text('Submit Word Guess'),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
              ),
            ),
          ],
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
