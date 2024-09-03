import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

void main(List<String> arguments) async {
  final todo = await getTodo(1);
  if (todo != null) {
    print(todo.title);
  }
}

Future<Todo?> getTodo(int id) async {
  final uri = Uri.parse('https://jsonplaceholder.typicode.com/todos/$id');
  final response = await http.get(uri);
  if (response.statusCode == HttpStatus.ok) {
    final Map map = jsonDecode(response.body);
    return Todo(
      userId: map['userId'],
      id: map['id'],
      title: map['title'],
      completed: map['completed'],
    );
  } else {
    return null;
  }
}

class Todo {
  final int userId;
  final int id;
  final String title;
  final bool completed;

  Todo({
    required this.userId,
    required this.id,
    required this.title,
    required this.completed,
  });
}
