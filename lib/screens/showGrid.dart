import 'package:flutter/material.dart';
import 'package:word_search/commonWidget/Button.dart';
import 'package:word_search/commonWidget/findWord.dart';

class ShowGridview extends StatefulWidget {
  final int m;
  final int n;
  final List<List<String>> word;

  const ShowGridview(
      {super.key, required this.m, required this.n, required this.word});

  @override
  State<ShowGridview> createState() => _ShowGridviewState();
}

class _ShowGridviewState extends State<ShowGridview> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  late final TextEditingController _wordController;

  @override
  void initState() {
    super.initState();
    _wordController = TextEditingController();
  }

  @override
  void dispose() {
    _wordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(title: const Text("Grid View"), backgroundColor: Colors.green),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(
              height: widget.m * 50.0, // Adjust the height as needed
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
                      color: (rowIndex == 1 && colIndex == 2)
                          ? Colors.amber
                          : Colors.yellow,
                    ),
                    child: Center(
                      child: Text(
                        widget.word[rowIndex][colIndex],
                        style: const TextStyle(fontSize: 18.0),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 25),
            SizedBox(
              child: TextFormField(
                keyboardType: TextInputType.multiline,
                maxLength: int.tryParse('5'),
                controller: _wordController,
                decoration: const InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.fromLTRB(10, 12, 0, 12),
                  labelText: "Enter Characters",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  child: Button(
                    onPress: () {},
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
                        FindWord().run();
                      }
                    },
                    btnColor: Colors.orange,
                    textColor: Colors.white,
                    btnText: 'Submit MxN',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
