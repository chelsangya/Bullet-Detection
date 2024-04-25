import 'dart:async';
import 'dart:convert';

import 'package:armor_display/result_screen.dart';
import 'package:body_part_selector/body_part_selector.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class BodyView extends StatefulWidget {
  final String body1Name;
  final String body2Name;

  const BodyView({
    Key? key,
    required this.body1Name,
    required this.body2Name,
  }) : super(key: key);

  @override
  State<BodyView> createState() => _BodyViewState();
}

class _BodyViewState extends State<BodyView> {
  bool showResultsButton = false;
  Color color1 = Colors.grey;
  Color color2 = Colors.black;
  Color bcolor1 = Colors.white;
  Color bcolor2 = Colors.white;
  BodyParts _selectedBodyParts = const BodyParts();
  BodyParts _selectedBodyParts2 = const BodyParts();
  int count = 0;
  int score1 = 0;
  int score2 = 0;
  int silverscore0 = 0, silverscore1 = 0, silverscore2 = 0, silverscore3 = 0;
  int blackscore0 = 0, blackscore1 = 0, blackscore2 = 0, blackscore3 = 0;
  int _strikeNumber = 1;
  int? prevEntry1, prevEntry2, prevEntry3, prevEntry4;
  String? prevbf1, prevbf2, prevsf1, prevsf2;
  String? bfield1, bfield2, sfield1, sfield2;
  String? hitBodyPart, hitBodyPart2;

  @override
  void initState() {
    super.initState();
    _selectedBodyParts = _updateSelectedBodyParts('head');
    _selectedBodyParts2 = _updateSelectedBodyParts('head');
    _fetchInit();
  }

  Future<void> _fetchInit() async {
    const String url1 =
        'https://api.thingspeak.com/channels/2518657/feeds.json?api_key=LGVSLDJ1SJNWIN0N&results=1';
    const String url2 =
        'https://api.thingspeak.com/channels/2522339/feeds.json?api_key=AA67TIB6J9RNFZHB&results=1';
    const String url3 =
        'https://api.thingspeak.com/channels/2492212/feeds.json?api_key=E8TU4HKXSLJ6PXBJ&results=1';
    const String url4 =
        'https://api.thingspeak.com/channels/2522325/feeds.json?api_key=16RKEXPGEHRK3QQR&results=1';
    final response1 = await http.get(Uri.parse(url1));
    final response2 = await http.get(Uri.parse(url2));
    final response3 = await http.get(Uri.parse(url3));
    final response4 = await http.get(Uri.parse(url4));
    color1 = Colors.grey;
    color2 = Colors.black;
    bcolor1 = Colors.white;
    bcolor2 = Colors.white;
    if (response1.statusCode == 200) {
      final decodedData1 = jsonDecode(response1.body);
      final feeds1 = decodedData1['feeds'] as List?;
      print('silver Feeds 1: $feeds1');
      final data1 = feeds1?.first['field1'] as String?;

      sfield1 = feeds1?.first['field1'] as String?;
      print('Data 1 : $sfield1');
      sfield2 = feeds1?.first['field2'] as String?;
      print('Data 3 : $sfield2');
      prevsf1 = sfield1;
      prevsf2 = sfield2;
      if (feeds1 != null && feeds1.isNotEmpty) {
        prevEntry1 = feeds1.first['entry_id'] as int;
        print('Prev Entry1: $prevEntry1');
        print('Data 1 : $data1');
      }
    }
    if (response2.statusCode == 200) {
      final decodedData1 = jsonDecode(response1.body);
      final feeds2 = decodedData1['feeds'] as List?;
      print('silver Feeds 2: $feeds2');
      final data2 = feeds2?.first['field1'] as String?;

      sfield2 = feeds2?.first['field1'] as String?;
      print('Data 1 : $sfield2');
      prevsf1 = sfield1;
      prevsf2 = sfield2;
      if (feeds2 != null && feeds2.isNotEmpty) {
        prevEntry2 = feeds2.first['entry_id'] as int;
        print('Prev Entry2: $prevEntry2');
        print('Data 2 : $data2');
      }
    }

    if (response3.statusCode == 200) {
      final decodedData3 = jsonDecode(response3.body);
      final feeds3 = decodedData3['feeds'] as List?;
      print('Feeds 3: $feeds3');
      final data3 = feeds3?.first['field1'] as String?;
      bfield1 = feeds3?.first['field1'] as String?;
      print('Black Data 3 : $bfield1');
      prevbf1 = bfield1;
      prevbf2 = bfield2;
      if (feeds3 != null && feeds3.isNotEmpty) {
        prevEntry3 = feeds3.first['entry_id'] as int;
        print('Prev Entry3: $prevEntry3');
        print('Data 3 : $data3');
      }
    }
    if (response4.statusCode == 200) {
      final decodedData4 = jsonDecode(response3.body);
      final feeds4 = decodedData4['feeds'] as List?;
      print('Feeds 4: $feeds4');
      final data4 = feeds4?.first['field1'] as String?;
      bfield2 = feeds4?.first['field1'] as String?;
      print('Black Data 4 : $bfield2');
      prevbf1 = bfield1;
      prevbf2 = bfield2;
      if (feeds4 != null && feeds4.isNotEmpty) {
        prevEntry4 = feeds4.first['entry_id'] as int;
        print('Prev Entry4: $prevEntry4');
        print('Data 4 : $data4');
      }
    }
  }

  Future<void> _fetchSelectedBodyPartsFromThingSpeak() async {
    const String url1 =
        'https://api.thingspeak.com/channels/2518657/feeds.json?api_key=LGVSLDJ1SJNWIN0N&results=1';
    const String url2 =
        'https://api.thingspeak.com/channels/2522339/feeds.json?api_key=AA67TIB6J9RNFZHB&results=1';
    const String url3 =
        'https://api.thingspeak.com/channels/2492212/feeds.json?api_key=E8TU4HKXSLJ6PXBJ&results=1';
    const String url4 =
        'https://api.thingspeak.com/channels/2522325/feeds.json?api_key=16RKEXPGEHRK3QQR&results=1';

    final response1 = await http.get(Uri.parse(url1));
    final response2 = await http.get(Uri.parse(url2));
    final response3 = await http.get(Uri.parse(url3));
    final response4 = await http.get(Uri.parse(url4));

    color1 = Colors.grey;

    color2 = Colors.black;
    if (response1.statusCode == 200) {
      final decodedData1 = jsonDecode(response1.body);
      final feeds1 = decodedData1['feeds'] as List?;
      print('silver Feeds 1: $feeds1');
      final entry1 = feeds1?.first['entry_id'] as int;
      prevEntry1 ??= feeds1?.first['entry_id'] as int;
      if (prevEntry1 != entry1) {
        prevEntry1 = entry1;
        print('Upper body hit for silver');
        hitBodyPart = 'Upper Body';
        setState(() {
          _selectedBodyParts = _updateSelectedBodyParts('Upper Body');
        });
        switch (count) {
          case 0:
            silverscore0 = 6;
            color1 = Colors.grey;
            bcolor1 = Colors.white;
            break;
          case 1:
            score1 = 6;
            silverscore1 = 6;
            color1 = Colors.red;
            bcolor1 = Colors.red;
            break;
          case 2:
            score1 = 6;
            silverscore2 = 6;
            color1 = Colors.red;
            bcolor1 = Colors.red;

            break;
          case 3:
            score1 = 6;
            silverscore3 = 6;
            color1 = Colors.red;
            bcolor1 = Colors.red;
            break;
        }
        print(
            'Silver score: $silverscore0 + $silverscore1 + $silverscore2 + $silverscore3');
      } else {
        print('Silver Upper intact');
        hitBodyPart = 'None';
        print(
            'Silver score: $silverscore0 + $silverscore1 + $silverscore2 + $silverscore3');
      }
    }
    if (response2.statusCode == 200) {
      final decodedData2 = jsonDecode(response2.body);
      final feeds2 = decodedData2['feeds'] as List?;
      print('silver Feeds 2: $feeds2');
      final entry2 = feeds2?.first['entry_id'] as int;
      prevEntry2 ??= feeds2?.first['entry_id'] as int;
      if (prevEntry2 != entry2) {
        prevEntry2 = entry2;
        print('Abdomen hit for silver');
        hitBodyPart = 'Abdomen';
        setState(() {
          _selectedBodyParts = _updateSelectedBodyParts('Abdomen');
        });
        switch (count) {
          case 0:
            silverscore0 = 4;
            color1 = Colors.grey;
            bcolor1 = Colors.white;
            break;
          case 1:
            score1 = 4;

            silverscore1 = 4;
            color1 = Colors.blue;
            bcolor1 = Colors.blue;
            break;
          case 2:
            score1 = 4;

            silverscore2 = 4;
            color1 = Colors.blue;
            bcolor1 = Colors.blue;

            break;
          case 3:
            score1 = 4;

            silverscore3 = 4;
            color1 = Colors.blue;
            bcolor1 = Colors.blue;

            break;
        }
        print(
            'Silver score: $silverscore0 + $silverscore1 + $silverscore2 + $silverscore3');
      } else {
        print('Silver abdomen intact');
        hitBodyPart = 'None';
        print(
            'Silver score: $silverscore0 + $silverscore1 + $silverscore2 + $silverscore3');
      }
    }
    if (response3.statusCode == 200) {
      final decodedData3 = jsonDecode(response3.body);
      final feeds3 = decodedData3['feeds'] as List?;
      final entry3 = feeds3?.first['entry_id'] as int;
      prevEntry3 ??= feeds3?.first['entry_id'] as int;
      if (prevEntry3 != entry3) {
        prevEntry3 = entry3;
        print('Upper body hit for black');
        hitBodyPart2 = 'Upper Body';
        setState(() {
          _selectedBodyParts2 = _updateSelectedBodyParts('Upper Body');
        });
        switch (count) {
          case 0:
            blackscore0 = 6;
            color2 = Colors.black;
            bcolor2 = Colors.white;
            break;
          case 1:
            score2 = 6;
            blackscore1 = 6;
            color2 = Colors.red;
            bcolor2 = Colors.red;
            break;
          case 2:
            score2 = 6;
            blackscore2 = 6;
            color2 = Colors.red;
            bcolor2 = Colors.red;

            break;
          case 3:
            score2 = 6;
            blackscore3 = 6;
            color2 = Colors.red;
            bcolor2 = Colors.red;
            break;
        }
        print(
            'Black Score: $blackscore0 + $blackscore1 + $blackscore2 + $blackscore3');
      } else {
        print('Black Upper intact');
        hitBodyPart = 'None';
        print(
            'Black Score: $blackscore0 + $blackscore1 + $blackscore2 + $blackscore3');
      }
    }
    if (response4.statusCode == 200) {
      final decodedData4 = jsonDecode(response4.body);
      final feeds4 = decodedData4['feeds'] as List?;
      final entry4 = feeds4?.first['entry_id'] as int;
      prevEntry4 ??= feeds4?.first['entry_id'] as int;
      if (prevEntry4 != entry4) {
        prevEntry4 = entry4;
        print('Abdomen hit for black');
        hitBodyPart = 'Abdomen';
        setState(() {
          _selectedBodyParts2 = _updateSelectedBodyParts('Abdomen');
        });
        switch (count) {
          case 0:
            blackscore0 = 4;
            color2 = Colors.black;
            bcolor2 = Colors.white;
            break;
          case 1:
            score2 = 4;
            blackscore1 = 4;
            color2 = Colors.blue;
            bcolor2 = Colors.blue;
            break;
          case 2:
            score2 = 4;

            blackscore2 = 4;
            color2 = Colors.blue;
            bcolor2 = Colors.blue;

            break;
          case 3:
            score2 = 4;

            blackscore3 = 4;
            color2 = Colors.blue;
            bcolor2 = Colors.blue;

            break;
        }
      } else {
        print('Black abdomen intact');
        hitBodyPart = 'None';
        print(
            'Black Score: $blackscore0 + $blackscore1 + $blackscore2 + $blackscore3');
      }
    }
  }

  BodyParts _updateSelectedBodyParts(String hitBodyPart) {
    BodyParts updatedBodyParts = const BodyParts();
    switch (hitBodyPart.trim()) {
      case 'Head':
        updatedBodyParts = updatedBodyParts.copyWith(head: true);
        break;
      case 'Right Lower Leg':
        updatedBodyParts = updatedBodyParts.copyWith(
          rightLowerLeg: true,
        );
        break;
      case 'Left Lower Leg':
        updatedBodyParts = updatedBodyParts.copyWith(leftLowerLeg: true);
        break;
      case 'Abdomen':
        updatedBodyParts = updatedBodyParts.copyWith(abdomen: true);
        break;
      case 'Upper Body':
        updatedBodyParts = updatedBodyParts.copyWith(upperBody: true);
        break;
      case '1':
        updatedBodyParts = updatedBodyParts.copyWith(upperBody: true);
        break;
      case '2':
        updatedBodyParts = updatedBodyParts.copyWith(abdomen: true);
        break;
    }
    return updatedBodyParts;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[900],
        foregroundColor: Colors.white,
        title: const Text(
          'Target Game',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20.0, color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(
                left: 16.0, right: 16.0, top: 20.0, bottom: 16.0),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          widget.body1Name.toUpperCase(),
                          style: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.4,
                          height: MediaQuery.of(context).size.height * 0.6,
                          child: BodyPartSelector(
                            unselectedColor: Colors.grey,
                            bodyParts: _selectedBodyParts,
                            onSelectionUpdated: (p) => setState(
                                () => _selectedBodyParts = _selectedBodyParts),
                            side: BodySide.front,
                            selectedColor: color1,
                            selectedOutlineColor: color1,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          widget.body2Name.toUpperCase(),
                          style: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.4,
                          height: MediaQuery.of(context).size.height * 0.6,
                          child: BodyPartSelector(
                            bodyParts: _selectedBodyParts2,
                            onSelectionUpdated: (p) => setState(() =>
                                _selectedBodyParts2 = _selectedBodyParts2),
                            side: BodySide.front,
                            unselectedColor: Colors.black,
                            selectedColor: color2,
                            selectedOutlineColor: color2,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Score: $score1",
                        style: TextStyle(
                          color: color1,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Total Score: ${silverscore0 + silverscore1 + silverscore2 + silverscore3}",
                        style: TextStyle(
                          color: color1,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Score: $score2",
                        style: TextStyle(
                          color: color2,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Total Score: ${blackscore0 + blackscore1 + blackscore2 + blackscore3}",
                        style: TextStyle(
                          color: color2,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              if (!showResultsButton) ...{
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.blueGrey[900],
                    ),
                    onPressed: () {
                      _recordStrikeNumber();
                      _fetchSelectedBodyPartsFromThingSpeak();
                      if (count == 3) {
                        showResultsButton = true;
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'STRIKE $_strikeNumber',
                        style: const TextStyle(fontSize: 35),
                      ),
                    )),
              },
              if (showResultsButton) ...{
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.blueGrey[900],
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ResultScreen(
                                  silverScore: silverscore0 +
                                      silverscore1 +
                                      silverscore2 +
                                      silverscore3,
                                  blackScore: blackscore0 +
                                      blackscore1 +
                                      blackscore2 +
                                      blackscore3,
                                  silverscore1: silverscore1,
                                  silverscore2: silverscore2,
                                  silverscore3: silverscore3,
                                  blackscore1: blackscore1,
                                  blackscore2: blackscore2,
                                  blackscore3: blackscore3,
                                  player1: widget.body1Name,
                                  player2: widget.body2Name,
                                )));
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'SHOW RESULTS',
                      style: TextStyle(fontSize: 35),
                    ),
                  ),
                )
              }
            ]),
          ),
        ),
      ),
    );
  }

  void _recordStrikeNumber() {
    setState(() {
      _strikeNumber++;
      count++;
    });
  }
}
