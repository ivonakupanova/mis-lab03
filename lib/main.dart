import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'Exam.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'My exams schedule'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Exam> examsList = [
    Exam(course: "Mobile information systems", date: DateTime.now().toLocal()),
    Exam(course: "Operating systems", date: DateTime.utc(2022, 12, 20, 12, 30)),
    Exam(
        course: "Management information systems",
        date: DateTime.utc(2022, 12, 29, 9, 0)),
    Exam(course: "Calculus", date: DateTime.utc(2022, 12, 30, 14, 30)),
    Exam(course: "Dicrete math", date: DateTime.utc(2023, 1, 20, 14, 40))
  ];

  Future<void> _showAddExamDialog(BuildContext context) async {
    String examTitle = '';
    DateTime selectedDate = DateTime.now();
    TimeOfDay selectedTime = TimeOfDay.now();

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add Exam'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                onChanged: (value) {
                  examTitle = value;
                },
                decoration: const InputDecoration(labelText: 'Exam Title'),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () async {
                  selectedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2023, 6, 1, 8, 0, 0),
                      lastDate: DateTime(2023, 12, 31, 6, 0, 0)) as DateTime;
                },
                child: const Text('Pick Exam Date'),
              ),
              TextButton(
                onPressed: () async {
                  selectedTime = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now()) as TimeOfDay;
                },
                child: const Text('Pick Time'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                _addNewItemToList(Exam(
                    course: examTitle,
                    date: DateTime(
                        selectedDate.year,
                        selectedDate.month,
                        selectedDate.day,
                        selectedTime.hour,
                        selectedTime.minute)));
                Navigator.pop(context);
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void _addNewItemToList(Exam item) {
    setState(() {
      examsList.add(item);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.add_box),
              onPressed: () => _showAddExamDialog(context),
            )
          ],
        ),
        body: Center(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            const Text("Schedule:",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                textAlign: TextAlign.center),
            ...(examsList.map((exam) {
              return Card(
                  margin: const EdgeInsets.all(10),
                  child: SizedBox(
                      width: 400,
                      height: null,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(exam.course,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                              textAlign: TextAlign.center),
                          Text(
                              DateFormat('yyyy-MM-dd – kk:mm')
                                  .format(exam.date),
                              style: const TextStyle(
                                  fontSize: 16, color: Colors.grey),
                              textAlign: TextAlign.center)
                        ],
                      )));
            }))
          ]),
          // floatingActionButton: FloatingActionButton(
          //   onPressed: _incrementCounter,
          //   tooltip: 'Increment',
          //   child: const Icon(Icons.add),
          // ), // This trailing comma makes auto-formatting nicer for build methods.
        ));
  }
}
