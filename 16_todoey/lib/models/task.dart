class Task {
  Task({required this.title, this.isDone = false, this.isPrioritized = false});

  String title;
  bool isDone;
  bool isPrioritized;

  void toggleDone() {
    isDone = !isDone;
  }

  void togglePriority() {
    isPrioritized = !isPrioritized;
  }
}
