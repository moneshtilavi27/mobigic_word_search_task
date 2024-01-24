import 'package:flutter/material.dart';
import 'package:word_search/commonWidget/Button.dart';
import 'package:word_search/commonWidget/TextBox.dart';
import 'package:word_search/commonWidget/findWord.dart';
import 'package:word_search/screens/showGrid.dart';

class HameScreen extends StatefulWidget {
  const HameScreen({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<HameScreen> createState() => HameScreenState();
}

class HameScreenState extends State<HameScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  late final TextEditingController _rowsController;
  late final TextEditingController _columnsController;
  late final TextEditingController _mxnController;
  bool showMxnInput = false;
  late String mxnValue = '';

  List<List<String>> wordTo2DArray(String word, int m, int n) {
    if (word.length != m * n) {
      throw ArgumentError('The length of the word must be equal to m * n');
    }

    List<List<String>> result =
        List.generate(m, (i) => List.generate(n, (j) => word[i * n + j]));

    return result;
  }

  String? _validateInputs(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a value.';
    }
    return null;
  }

  @override
  void initState() {
    super.initState();
    _rowsController = TextEditingController();
    _columnsController = TextEditingController();
    _mxnController = TextEditingController();
  }

  @override
  void dispose() {
    _rowsController.dispose();
    _columnsController.dispose();
    _mxnController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromARGB(162, 252, 252, 253),
              Color.fromARGB(200, 251, 255, 211),
            ],
          ),
        ),
        padding: const EdgeInsets.fromLTRB(20, 60, 20, 15),
        child: Center(
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  const SizedBox(
                    child: Text("Create",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 85,
                            color: Color.fromARGB(255, 100, 110, 248),
                            letterSpacing: 2,
                            fontWeight: FontWeight.bold,
                            height: 0)),
                  ),
                  const Text("Grid",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 85,
                          color: Colors.yellow,
                          letterSpacing: 5,
                          fontWeight: FontWeight.bold,
                          height: 0)),
                  const SizedBox(height: 25),
                  if (!showMxnInput) ...[
                    const Text(
                      'Enter The Number of Rows And Columns',
                      style: TextStyle(
                        fontSize: 17,
                        color: Color.fromARGB(255, 100, 110, 248),
                        letterSpacing: 0.084,
                        fontWeight: FontWeight.w500,
                        height: 2,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    const SizedBox(height: 25),
                    SizedBox(
                      child: TextFormField(
                        controller: _rowsController,
                        keyboardType: TextInputType.number,
                        validator: _validateInputs,
                        decoration: const InputDecoration(
                          isDense: true,
                          contentPadding: EdgeInsets.fromLTRB(10, 12, 0, 12),
                          labelText: "Enter Rows",
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        validator: _validateInputs,
                        controller: _columnsController,
                        decoration: const InputDecoration(
                          isDense: true,
                          contentPadding: EdgeInsets.fromLTRB(10, 12, 0, 12),
                          labelText: "Enter Columns",
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      child: Button(
                        onPress: () {
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              showMxnInput = true;
                              mxnValue = (int.parse(_rowsController.text) *
                                      int.parse(_columnsController.text))
                                  .toString();
                            });
                            print(mxnValue);
                          }
                        },
                        btnColor: Colors.orange,
                        textColor: Colors.white,
                        btnText: 'Submit',
                      ),
                    ),
                  ] else ...[
                    const Text(
                      'Each Charecter should get placed in each box',
                      style: TextStyle(
                        fontSize: 17,
                        color: Color.fromARGB(255, 100, 110, 248),
                        letterSpacing: 0.084,
                        fontWeight: FontWeight.w500,
                        height: 2,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    const SizedBox(height: 25),
                    SizedBox(
                      child: TextFormField(
                        keyboardType: TextInputType.multiline,
                        maxLength: int.tryParse(mxnValue),
                        controller: _mxnController,
                        decoration: InputDecoration(
                          isDense: true,
                          contentPadding:
                              const EdgeInsets.fromLTRB(10, 12, 0, 12),
                          labelText: "Enter $mxnValue Characters",
                          border: const OutlineInputBorder(),
                        ),
                        validator: (value) {
                          int length = value?.length ?? 0;
                          int maxLength = int.tryParse(mxnValue) ?? 0;

                          if (length != maxLength) {
                            return "Length should be $maxLength characters.";
                          }
                          if (value == null || value.isEmpty) {
                            return 'Please enter a value.';
                          }
                          return null; // Return null if the validation passes
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          child: Button(
                            onPress: () {
                              setState(() {
                                showMxnInput = false;
                                _mxnController.clear();
                              });
                            },
                            btnColor: Colors.blue,
                            textColor: Colors.white,
                            btnText: 'Change M/N',
                          ),
                        ),
                        SizedBox(
                          child: Button(
                            onPress: () {
                              // Handle MxN characters submission
                              if (_formKey.currentState!.validate()) {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ShowGridview(
                                        m: int.parse(_rowsController.text),
                                        n: int.parse(_columnsController.text),
                                        girdData: wordTo2DArray(
                                            _mxnController.text,
                                            int.parse(_rowsController.text),
                                            int.parse(
                                                _columnsController.text))),
                                  ),
                                );
                              }
                              //   FindWord().run();
                            },
                            btnColor: Colors.orange,
                            textColor: Colors.white,
                            btnText: 'Submit MxN',
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
