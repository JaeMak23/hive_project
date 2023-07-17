import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_project/person.dart';
import 'boxes.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(PersonAdapter());
  boxPersons = await Hive.openBox<Person>('PersonBox');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Hive',
      theme: ThemeData(useMaterial3: true, primarySwatch: Colors.blue),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    ageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 20, 2, 40),
      appBar: AppBar(
        title: const Text('Hive Database'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 8,
            ),
            const Icon(
              Icons.logo_dev_rounded,
              color: Colors.red,
              size: 100,
            ),
            // Image.network(
            //   'https://www.google.com/logos/doodles/2023/eunice-newton-footes-204th-birthday-6753651837110059-s.png',
            //   height: 100,
            // ),
            const SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      TextField(
                        controller: nameController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Name',
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      TextField(
                        controller: ageController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'age',
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            boxPersons.put(
                              'key_${nameController.text}',
                              Person(
                                name: nameController.text,
                                age: int.parse(ageController.text),
                              ),
                            );
                          });
                        },
                        child: const Text('Add'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const Text(
              'check',
              style: TextStyle(fontSize: 20, color: Colors.yellow),
            ),
            const SizedBox(
              height: 8,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Expanded(
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: ListView.builder(
                        itemCount: boxPersons.length,
                        itemBuilder: (context, index) {
                          Person person = boxPersons.getAt(index);
                          return ListTile(
                            leading: IconButton(
                              onPressed: () {
                                setState(() {
                                  boxPersons.deleteAt(index);
                                });
                              },
                              icon: const Icon(Icons.remove_circle),
                            ),
                            title: Text(person.name),
                            subtitle: const Text('Name'),
                            trailing: Text('age : ${person.age.toString()}'),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
            TextButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.delete,color: Colors.yellow,),
              label: const Text('Delete All',style: TextStyle(color: Colors.yellow),),
              
            )
          ],
        ),
      ),
    );
  }
}
