import 'package:flutter/material.dart';

import 'body_view.dart';

class BodyNameEntryScreen extends StatefulWidget {
  const BodyNameEntryScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _BodyNameEntryScreenState createState() => _BodyNameEntryScreenState();
}

class _BodyNameEntryScreenState extends State<BodyNameEntryScreen> {
  TextEditingController body1Controller = TextEditingController();
  TextEditingController body2Controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[900],
        foregroundColor: Colors.white,
        title: const Text(
          'Enter Body Names',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Enter the names of the players:',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: body1Controller,
                  decoration: const InputDecoration(
                    labelText: 'Silver Armor',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: body2Controller,
                  decoration: const InputDecoration(
                    labelText: 'Black Armor',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.blueGrey[900],
                      ),
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BodyView(
                              body1Name: body1Controller.text,
                              body2Name: body2Controller.text,
                            ),
                          ),
                        );
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'START',
                          style: TextStyle(fontSize: 25),
                        ),
                      )),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // @override
  // void dispose() {
  //   body1Controller.dispose();
  //   body2Controller.dispose();
  //   super.dispose();
  // }
}
