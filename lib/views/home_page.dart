import 'package:flutter/material.dart';
import '../repositories/user_repository.dart';
import '../models/user.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final UserRepository _userRepository = UserRepository();
  late List<User> users = [];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(64, 75, 96, .9),
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Center(
          child: FutureBuilder(
            future: _userRepository.getAllUsers(),
            builder: (BuildContext context, AsyncSnapshot<List<User>> snapshot){
              if (!snapshot.hasData) {
                return const CircularProgressIndicator(
                color: Color.fromRGBO(64, 75, 96, .9),
                strokeWidth: 2.0,
              );
              }
              users = snapshot.data!;
              return ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: users.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    elevation: 8.0,
                    margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                    child: Container(
                      decoration: const BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
                      child: makeListTile(users[index]),
                    ),
                  );
                },
              );
            },
          )
        ),
      ),
    );
  }

  ListTile makeListTile(User user){
    return ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        leading: Container(
          padding: const EdgeInsets.only(right: 12.0),
          decoration: const BoxDecoration(
              border: Border(
                  right: BorderSide(width: 1.0, color: Colors.white24))),
          child: const Icon(Icons.person, color: Colors.white),
        ),
        title: Text(
          user.name,
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

        subtitle: Column(
          children: [
            Row(
              children: <Widget>[
                const Icon(Icons.email, size: 20.0, color: Colors.yellowAccent),
                Text(user.email, style: const TextStyle(color: Colors.white))
              ],
            ),
            Row(
              children: <Widget>[
                const Icon(Icons.phone, size: 20.0, color: Colors.yellowAccent),
                Text(user.phone, style: const TextStyle(color: Colors.white))
              ],
            ),
          ],
        ),
    );
  }
}