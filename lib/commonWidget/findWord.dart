// ignore: file_names
class FindWord {
  Map<String, dynamic>? searchWord(
      List<List<String>> board, String word, int m, int n) {
    Map<String, dynamic> result = {};
    for (int i = 0; i < m; i++) {
      for (int j = 0; j < n; j++) {
        if (search(board, word, i, j, m, n, (r, c) => [r, c + 1], 'right')) {
          result = {
            'direction': 'Left to Right',
            'result': {
              'row': List<int>.generate(word.length, (k) => i),
              'col': List<int>.generate(word.length, (k) => j + k),
              'index': i
            }
          };
        } else if (search(
            board, word, i, j, m, n, (r, c) => [r + 1, c], 'bottom')) {
          result = {
            'direction': ' Top to Bottom',
            'result': {
              'row': List<int>.generate(word.length, (k) => i + k),
              'col': List<int>.generate(word.length, (k) => j),
              'index': i
            }
          };
        } else if (search(
            board, word, i, j, m, n, (r, c) => [r + 1, c + 1], 'diagonal')) {
          result = {
            'direction': 'Diagonal (South-East)',
            'result': {
              'row': List<int>.generate(word.length, (k) => i + k),
              'col': List<int>.generate(word.length, (k) => j + k),
              'index': i
            }
          };
        }
      }
    }

    List<List<int>> resultMatrix;
    if (result != null && result['result'] != null) {
      resultMatrix = generateMatrix(
        m,
        n,
        result['result']['row'],
        result['result']['col'],
      );
    } else {
      // Handle the case where 'result' or 'resultMatrix' is null
      resultMatrix = generateMatrix(
        m,
        n,
        [],
        [],
      );
    }

    result['singleton'] = resultMatrix;
    print("monu ====> " + result.toString());
    return result;
  }

  bool search(List<List<String>> board, String word, int row, int col, int m,
      int n, List<int> Function(int, int) getNext, String direction) {
    if (row < 0 ||
        col < 0 ||
        row >= m ||
        col >= n ||
        board[row][col] != word[0]) {
      return false;
    }

    String temp = board[row][col];
    board[row][col] = '!';

    for (int i = 1; i < word.length; i++) {
      List<int> next = getNext(row, col);
      int r = next[0];
      int c = next[1];

      if (r < 0 || c < 0 || r >= m || c >= n || board[r][c] != word[i]) {
        board[row][col] = temp; // undo change
        return false;
      }

      row = r;
      col = c;
    }

    board[row][col] = temp; // undo change
    return true;
  }

  List<List<int>> generateMatrix(
      int m, int n, List<int> rowIndices, List<int> colIndices) {
    List<List<int>> matrix = List.generate(m, (i) => List<int>.filled(n, 0));

    for (int i = 0; i < rowIndices.length; i++) {
      int row = rowIndices[i];
      int col = colIndices[i];

      if (row >= 0 && row < m && col >= 0 && col < n) {
        matrix[row][col] = 1;
      }
    }

    return matrix;
  }

  void run() {
    List<List<String>> board = [
      ['S', 'B', 'C', 'E'],
      ['A', 'F', 'C', 'S'],
      ['D', 'C', 'E', 'E']
    ];

    String wordToFind = "CS";
    int rows = board.length;
    int cols = board[0].length;
    Map<String, dynamic>? result = searchWord(board, wordToFind, rows, cols);

    if (result != null) {
      print(
          "Word found by ${result['direction']} at rows: ${result['result']['row']}, columns: ${result['result']['col']}");
    } else {
      print("Word not found");
    }
  }
}
