import 'dart:async';
import 'package:flutter/material.dart';
import 'package:nthu_tracker/Timer%20Page/timer-button.dart';
import 'package:nthu_tracker/Provider/course_provider.dart';
import 'package:provider/provider.dart';

class TimerPage extends StatefulWidget {
  @override
  _TimerPageState createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  static const maxSeconds = 3600;
  int seconds = maxSeconds;
  Timer? timer;
  bool isPaused = false;
  String? selectedCourse;

  void startTimer() {
    timer = Timer.periodic(Duration(milliseconds: 50), (_) {
      if (!isPaused) {
        if (seconds > 0) {
          setState(() {
            seconds--;
          });
        } else {
          stopTimer(reset: false);
        }
      }
    });
  }

  void stopTimer({bool reset = true}) {
    if (reset) {
      resetTimer();
    }
    timer?.cancel();
  }

  void pauseTimer() {
    setState(() {
      isPaused = true;
    });
  }

  void continueTimer() {
    setState(() {
      isPaused = false;
    });
  }

  void resetTimer() {
    setState(() {
      seconds = maxSeconds;
      isPaused = false;
    });
  }

  @override
  void dispose() {
    if (timer != null && timer!.isActive) {
      timer!.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CourseProvider>(
      builder: (context, courseProvider, _) {
        List<String> courses = courseProvider.coursename;
        selectedCourse ??= courses.isNotEmpty ? courses[0] : null;
        bool coursesAvailable = courses.isNotEmpty;
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildTime(),
              const SizedBox(
                height: 20,
              ),
              buildDropdownMenu(courses),
              const SizedBox(
                height: 20,
              ),
              buildButton(coursesAvailable),
            ],
          ),
        );
      },
    );
  }

  Widget buildButton(bool coursesAvailable) {
    final isRunning = timer == null ? false : timer!.isActive;
    final bool isFinished = seconds == 0;

    if (!coursesAvailable || isFinished) {
      return ButtonWidget(
        text: 'Start',
        color: Colors.grey,
        background: Colors.grey[300]!,
        onClicked: () {
          if (coursesAvailable) {
            startTimer();
          }
        },
      );
    }

    if (isRunning) {
      if (isPaused) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ButtonWidget(
              text: 'Resume',
              color: Colors.white,
              background: Colors.black,
              onClicked: () {
                continueTimer();
              },
            ),
            const SizedBox(
              width: 10,
            ),
            ButtonWidget(
              text: 'Cancel',
              color: Colors.white,
              background: Colors.black,
              onClicked: () {
                stopTimer();
              },
            ),
          ],
        );
      } else {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ButtonWidget(
              text: 'Pause',
              color: Colors.white,
              background: Colors.black,
              onClicked: () {
                pauseTimer();
              },
            ),
            const SizedBox(
              width: 10,
            ),
            ButtonWidget(
              text: 'Cancel',
              color: Colors.white,
              background: Colors.black,
              onClicked: () {
                stopTimer();
              },
            ),
          ],
        );
      }
    } else {
      return ButtonWidget(
        text: 'Start',
        color: Colors.white,
        background: Colors.black,
        onClicked: () {
          startTimer();
        },
      );
    }
  }

  Widget buildDropdownMenu(List<String> courses) {
    // Change the parameter type
    if (courses.isEmpty) {
      return const Text(
        'No courses available',
        style: TextStyle(color: Colors.red), // Customize the style as needed
      );
    } else {
      return DropdownButton<String>(
        value: selectedCourse,
        items: courses.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (newValue) {
          setState(() {
            selectedCourse = newValue;
          });
        },
      );
    }
  }

  Widget buildTime() {
    int hours = seconds ~/ 3600;
    int minutes = (seconds ~/ 60) % 60;
    int remainingSeconds = seconds % 60;

    return Stack(
      alignment: Alignment.center,
      children: [
        Text(
          '$hours:${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 60,
          ),
        ),
        SizedBox(
          width: 300, // Adjust the width as needed
          height: 300, // Adjust the height as needed
          child: CircularProgressIndicator(
            value: seconds / maxSeconds,
            backgroundColor: Colors.grey,
            valueColor: const AlwaysStoppedAnimation<Color>(Colors.black),
            strokeWidth: 10,
          ),
        ),
      ],
    );
  }
}
