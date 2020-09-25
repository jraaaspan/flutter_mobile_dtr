import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mobile OJT DTR',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: PrimaryScreen(),
    );
  }
}

class PrimaryScreen extends StatefulWidget {
  @override
  logState createState() => logState();
}

class logState extends State<PrimaryScreen> {
  List<String> logs = [];
  DateTime now = new DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("USLS Mobile DTR")),
      body: createWorkLogList(),
      floatingActionButton: FloatingActionButton(
          onPressed: navigateToLogScreen,
          tooltip: 'Go to Log',
          child: Icon(Icons.calendar_today)),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  void navigateToLogScreen() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return Scaffold(
        appBar: AppBar(title: Text('Add worklog')),
        body: TextField(
          autofocus: true,
          onSubmitted: (val) {
            addLog(val);
            Navigator.pop(context);
          },
          decoration: InputDecoration(
              hintText: 'Enter Student ID',
              contentPadding: const EdgeInsets.all(14)),
        ),
      );
    }));
  }

  void addLog(String val) {
    if (val.length > 0) {
      setState(() {
        logs.add(val);
      });
    }
  }

  Widget createWorkLogList() {
    return ListView.builder(
        itemCount: logs.length,
        itemBuilder: (context, index) {
          return createTodoItem(logs[index], index);
        });
  }

  Widget createTodoItem(String todoText, int index) {
    return ListTile(
      title: Text(todoText),
      onTap: () => showAlertToRemove(index),
    );
  }

  void showAlertToRemove(int index) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text("Are you want to delete this log?"),
              actions: <Widget>[
                FlatButton(
                    child: Text('Cancel'),
                    onPressed: () => Navigator.of(context).pop()),
                FlatButton(
                  child: Text('Delete'),
                  onPressed: () {
                    deletelog(index);
                    Navigator.of(context).pop();
                  },
                )
              ]);
        });
  }

  void deletelog(int index) {
    setState(() {
      logs.removeAt(index);
    });
  }
}
