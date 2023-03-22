import 'dart:io';

void main() {
  performTasks();
}

void performTasks() async {
  task1();
  print(task2());
  String task2Result = await task2();
  task3(task2Result);
  task4();
}

void task1() {
  Duration oneSeconds = const Duration(seconds: 3);
  sleep(oneSeconds); // synchronous method
  String result = 'task 1 data';
  print('Task 1 complete');
}

Future<String> task2() async {
  Duration threeSeconds = const Duration(seconds: 3);

  late String result;
  await Future.delayed(threeSeconds, () {
    // asynchronous method
    result = 'task 2 data';
    print('Task 2 complete');
  });
  return result;
}

void task3(String task2Data) {
  String result = 'task 3 data';
  print('Task 3 completed with $task2Data');
}

void task4() {
  String result = 'task 4 data';
  print('Task 4 complete');
}
