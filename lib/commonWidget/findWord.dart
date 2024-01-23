// ignore: file_names
class FindWord {
  // Map<String, List<int>>? searchWord(
  //     List<List<String>> board, String word, int m, int n) {
  //   for (int i = 0; i < m; i++) {
  //     for (int j = 0; j < n; j++) {
  //       if (searchNext(board, word, i, j, 0, m, n)) {
  //         Map<String, List<int>> result = {'row': [], 'col': []};
  //         for (int k = 0; k < word.length; k++) {
  //           result['row']?.add(i);
  //           result['col']?.add(j + k);
  //         }
  //         return result;
  //       }
  //     }
  //   }
  //   return null;
  // }

  // Map<String, List<int>>? searchWordToBottom(
  //     List<List<String>> board, String word, int m, int n) {
  //   for (int i = 0; i <= m - word.length; i++) {
  //     for (int j = 0; j < n; j++) {
  //       if (searchNextToBottom(board, word, i, j, 0, m, n)) {
  //         Map<String, List<int>> result = {'row': [], 'col': []};
  //         for (int k = 0; k < word.length; k++) {
  //           result['row']?.add(i + k);
  //           result['col']?.add(j);
  //         }
  //         return result;
  //       }
  //     }
  //   }
  //   return null;
  // }

  // bool searchNextToBottom(List<List<String>> board, String word, int row,
  //     int col, int index, int m, int n) {
  //   if (index == word.length) {
  //     return true;
  //   }

  //   if (row < 0 ||
  //       col < 0 ||
  //       row >= m ||
  //       col >= n ||
  //       board[row][col] != word[index] ||
  //       board[row][col] == '!') {
  //     return false;
  //   }

  //   String c = board[row][col];
  //   board[row][col] = '!';

  //   bool down = searchNextToBottom(board, word, row + 1, col, index + 1, m, n);

  //   board[row][col] = c; // undo change
  //   return down;
  // }

  // Map<String, List<int>>? searchWordDiagonal(
  //     List<List<String>> board, String word, int m, int n) {
  //   for (int i = 0; i <= m - word.length; i++) {
  //     for (int j = 0; j <= n - word.length; j++) {
  //       if (searchNextDiagonal(board, word, i, j, 0, m, n)) {
  //         Map<String, List<int>> result = {'row': [], 'col': []};
  //         for (int k = 0; k < word.length; k++) {
  //           result['row']?.add(i + k);
  //           result['col']?.add(j + k);
  //         }
  //         return result;
  //       }
  //     }
  //   }
  //   return null;
  // }

  // bool searchNextDiagonal(List<List<String>> board, String word, int row,
  //     int col, int index, int m, int n) {
  //   if (index == word.length) {
  //     return true;
  //   }

  //   if (row < 0 ||
  //       col < 0 ||
  //       row >= m ||
  //       col >= n ||
  //       board[row][col] != word[index] ||
  //       board[row][col] == '!') {
  //     return false;
  //   }

  //   if (row < 0 ||
  //       col < 0 ||
  //       row == m ||
  //       col == n ||
  //       board[row][col] != word[index] ||
  //       board[row][col] == '!') {
  //     return false;
  //   }

  //   String c = board[row][col];
  //   board[row][col] = '!';

  //   bool diagonal =
  //       searchNextDiagonal(board, word, row + 1, col + 1, index + 1, m, n);

  //   board[row][col] = c; // undo change
  //   return diagonal;
  // }

  //  bool searchNext(List<List<String>> board, String word, int row, int col,
  //     int index, int m, int n) {
  //   if (index == word.length) {
  //     return true;
  //   }

  //   if (row < 0 ||
  //       col < 0 ||
  //       row == m ||
  //       col == n ||
  //       board[row][col] != word[index] ||
  //       board[row][col] == '!') {
  //     return false;
  //   }

  //   String c = board[row][col];
  //   board[row][col] = '!';

  //   bool right = searchNext(board, word, row, col + 1, index + 1, m, n);

  //   board[row][col] = c; // undo change
  //   return right;
  // }

  // void run() {
  //   List<List<String>> board = [
  //     ['A', 'B', 'C', 'E'],
  //     ['S', 'F', 'C', 'S'],
  //     ['A', 'D', 'E', 'E']
  //   ];

  //   String wordToFind = "BCE";
  //   int rows = board.length;
  //   int cols = board[0].length;
  //   print("monu==" + rows.toString());

  //   Map<String, List<int>>? result =
  //       searchWordDiagonal(board, wordToFind, rows, cols);

  //   if (result != null) {
  //     print(
  //         "monu Word found at rows: ${result['row']}, columns: ${result['col']}");
  //   } else {
  //     print("monu Word not found");
  //   }
  // }

  Map<String, dynamic>? searchWord(
      List<List<String>> board, String word, int m, int n) {
    for (int i = 0; i < m; i++) {
      for (int j = 0; j < n; j++) {
        if (search(board, word, i, j, m, n, (r, c) => [r, c + 1], 'right')) {
          return {
            'direction': 'right',
            'result': {
              'row': List<int>.generate(word.length, (k) => i),
              'col': List<int>.generate(word.length, (k) => j + k)
            }
          };
        } else if (search(
            board, word, i, j, m, n, (r, c) => [r + 1, c], 'bottom')) {
          return {
            'direction': 'bottom',
            'result': {
              'row': List<int>.generate(word.length, (k) => i + k),
              'col': List<int>.generate(word.length, (k) => j)
            }
          };
        } else if (search(
            board, word, i, j, m, n, (r, c) => [r + 1, c + 1], 'diagonal')) {
          return {
            'direction': 'diagonal',
            'result': {
              'row': List<int>.generate(word.length, (k) => i + k),
              'col': List<int>.generate(word.length, (k) => j + k)
            }
          };
        }
      }
    }
    return null;
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

  void run() {
    List<List<String>> board = [
      ['S', 'B', 'C', 'E'],
      ['A', 'F', 'C', 'S'],
      ['D', 'C', 'E', 'E']
    ];

    String wordToFind = "SFE";
    int rows = board.length;
    int cols = board[0].length;

    Map<String, dynamic>? result = searchWord(board, wordToFind, rows, cols);

    if (result != null) {
      print(
          "monu Word found by ${result['direction']} at rows: ${result['result']['row']}, columns: ${result['result']['col']}");
    } else {
      print("monu Word not found");
    }
  }
}
