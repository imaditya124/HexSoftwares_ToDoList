import 'package:flutter/material.dart';

void main() {
  runApp(TodoApp());
}

class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To-Do List',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: TodoHomePage(),
    );
  }
}

class TodoHomePage extends StatefulWidget {
  @override
  _TodoHomePageState createState() => _TodoHomePageState();
}

class _TodoHomePageState extends State<TodoHomePage> {
  final List<TodoItem> _tasks = [];  // List to store tasks
  final TextEditingController _controller = TextEditingController();  // Controller for input

  void _addTask(String task) {
    if (task.isNotEmpty) {
      setState(() {
        _tasks.add(TodoItem(task: task));  // Add task to list
      });
      _controller.clear();
    }
  }

  void _deleteTask(int index) {
    setState(() {
      _tasks.removeAt(index);  // Remove task
    });
  }

  void _toggleCompletion(int index) {
    setState(() {
      _tasks[index].isCompleted = !_tasks[index].isCompleted;  // Toggle completion
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('To-Do List'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            // Text field to add tasks
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: TextField(
                controller: _controller,
                onSubmitted: (value) => _addTask(value),  // Add task when hitting "Enter"
                decoration: InputDecoration(
                  hintText: 'Enter a task...',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.add, color: Colors.blue),
                    onPressed: () => _addTask(_controller.text),  // Add task on button press
                  ),
                ),
              ),
            ),
            SizedBox(height: 12),

            // List of tasks
            Expanded(
              child: _tasks.isEmpty
                  ? Center(child: Text('No tasks yet. Add some!'))
                  : ListView.builder(
                itemCount: _tasks.length,
                itemBuilder: (context, index) {
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 4,
                    margin: EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      title: Text(
                        _tasks[index].task,
                        style: TextStyle(
                          fontSize: 18,
                          decoration: _tasks[index].isCompleted
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,  // Strike-through if completed
                        ),
                      ),
                      leading: Checkbox(
                        value: _tasks[index].isCompleted,
                        onChanged: (value) => _toggleCompletion(index),  // Toggle completion
                        activeColor: Colors.green,
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _deleteTask(index),  // Delete task
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TodoItem {
  String task;
  bool isCompleted;

  TodoItem({required this.task, this.isCompleted = false});
}
