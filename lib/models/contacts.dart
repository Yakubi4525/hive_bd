import 'package:hive/hive.dart';

part 'contacts.g.dart';
// Каманада для генерациия моделки:
//flutter packages pub run build_runner build
//или это:
//flutter packages pub run build_runner build --delete-conflicting-outputs


@HiveType(typeId: 1)
class Contact {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final int age;

  Contact(this.name, this.age);
}
