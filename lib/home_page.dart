import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // call box
  final _myBox = Hive.box('mybox');

  // write
  void writeData() {
    _myBox.put(1, 'Makan');
  }

  // read
  void readData() {
    print(_myBox.get(1));
  }

  // delete
  void deleteData() {
    _myBox.delete(1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            MaterialButton(
              onPressed: writeData,
              child: Text('Write'),
              color: Colors.blue,
            ),
            MaterialButton(
              onPressed: readData,
              child: Text('Read'),
              color: Colors.yellow,
            ),
            MaterialButton(
              onPressed: deleteData,
              child: Text('Delete'),
              color: Colors.red,
            ),
          ],
        ),
      ),
    );
  }
}
