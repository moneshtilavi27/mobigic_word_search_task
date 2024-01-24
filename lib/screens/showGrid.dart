import 'package:flutter/material.dart';
import 'package:word_search/commonWidget/Button.dart';
import 'package:word_search/commonWidget/findWord.dart';
import 'package:word_search/screens/homepage.dart';

class ShowGridview extends StatefulWidget {
  final int m;
  final int n;
  final List<List<String>> girdData;

  const ShowGridview(
      {super.key, required this.m, required this.n, required this.girdData});

  @override
  State<ShowGridview> createState() => _ShowGridviewState();
}

class _ShowGridviewState extends State<ShowGridview> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  late final TextEditingController _wordController;
  late List<List<String>> data = [];
  bool showOutput = false;
  Map<String, dynamic>? result = {
    'singleton': '',
    'direction': '',
    'result': {'row': '', 'col': ''}
  };

  @override
  void initState() {
    super.initState();
    resetData();
    _wordController = TextEditingController();
  }

  resetData() {
    setState(() {
      data = List.generate(widget.girdData.length,
          (index) => List<String>.from(widget.girdData[index]));
    });
  }

  String? _validateInputs(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a value.';
    }
    return null;
  }

  @override
  void dispose() {
    _wordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Grid View $widget.m X $widget.n"),
        backgroundColor: Colors.green,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: 460.0, // Adjust the height as needed
                  width: widget.n * 50.0, // Adjust the width as needed

                  child: GridView.builder(
                    // physics: NeverScrollableScrollPhysics(), // Disable scrolling
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: widget.n,
                      crossAxisSpacing: 8.0,
                      mainAxisSpacing: 8.0,
                    ),
                    itemCount: widget.m * widget.n,
                    itemBuilder: (context, index) {
                      int rowIndex = index ~/ widget.n;
                      int colIndex = index % widget.n;

                      return Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          color: (showOutput &&
                                  result?['singleton'][rowIndex][colIndex] == 1)
                              ? Colors.amber
                              : Colors.yellow,
                        ),
                        child: Center(
                          child: Text(
                            widget.girdData[rowIndex][colIndex],
                            // rowIndex.toString() + "," + colIndex.toString(),
                            style: const TextStyle(fontSize: 18.0),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const Divider(height: 5),
                if (!showOutput) ...[
                  const SizedBox(height: 25),
                  SizedBox(
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      validator: _validateInputs,
                      controller: _wordController,
                      decoration: const InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.fromLTRB(10, 12, 0, 12),
                        labelText: "Enter Characters",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  SizedBox(
                    child: Button(
                      onPress: () {
                        // Handle MxN characters submission
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            result = FindWord().searchWord(
                                data, _wordController.text, widget.m, widget.n);
                            showOutput = true;
                          });
                        }
                      },
                      btnColor: Colors.blue,
                      textColor: Colors.white,
                      btnText: 'Search',
                    ),
                  )
                ] else ...[
                  const Text(
                    'Output:-',
                    style: TextStyle(
                      fontSize: 17,
                      color: Color.fromARGB(255, 100, 110, 248),
                      letterSpacing: 0.084,
                      fontWeight: FontWeight.w500,
                      height: 2,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  Text(
                    'Searched Word : ${_wordController.text}',
                    style: const TextStyle(
                      fontSize: 17,
                      color: Color.fromARGB(255, 100, 110, 248),
                      letterSpacing: 0.084,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  if (result?['direction'] != null) ...[
                    Text(
                      'Search Type : ${result != null ? result!['direction'] : 'N/A'}',
                      style: const TextStyle(
                        fontSize: 17,
                        color: Color.fromARGB(255, 100, 110, 248),
                        letterSpacing: 0.084,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      'Row Position : ${result?['result']?['row'] ?? 'N/A'}',
                      style: const TextStyle(
                        fontSize: 17,
                        color: Color.fromARGB(255, 100, 110, 248),
                        letterSpacing: 0.084,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      'Column Position : ${result?['result']?['col']}',
                      style: const TextStyle(
                        fontSize: 17,
                        color: Color.fromARGB(255, 100, 110, 248),
                        letterSpacing: 0.084,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ] else ...[
                    const Text(
                      'Search Type : Word not found',
                      style: TextStyle(
                        fontSize: 17,
                        color: Colors.red,
                        letterSpacing: 0.084,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                  const Divider(height: 5),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        child: Button(
                          onPress: () {
                            setState(() {
                              showOutput = false;
                            });
                            resetData();
                          },
                          btnColor: Colors.blue,
                          textColor: Colors.white,
                          btnText: 'Search',
                        ),
                      ),
                      SizedBox(
                        child: Button(
                          onPress: () {
                            // Handle MxN characters submission
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const HameScreen(
                                        title: 'Flutter Demo Home Page')));
                          },
                          btnColor: Colors.red,
                          textColor: Colors.white,
                          btnText: 'Reset',
                        ),
                      ),
                    ],
                  ),
                ]
              ],
            ),
          ),
        ),
      ),
    );
  }
}
