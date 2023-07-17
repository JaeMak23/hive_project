// how to create generated person.g.dart? 
// 1. create model then add part '<modal_name.g.dart' after import
// 3. Save the file
// 2. then run command 'flutter packages pub run build_runner build'

import 'package:hive/hive.dart';

part 'person.g.dart';

@HiveType(typeId: 1)
class Person {
  Person({required this.name, required this.age});
 
  @HiveField(0)
  String name;

  @HiveField(1)
  int age;
}
