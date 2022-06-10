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
  List<User>? searchResults;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(64, 75, 96, .9),
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              onChanged: (value) {
                if (users.isNotEmpty || value.isNotEmpty){
                  setState(() {
                    searchResults = searchUsers(value);
                  });
                }
              },
              cursorColor: const Color.fromRGBO(64, 75, 96, .1),
              style: const TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.w600,
                color: Color.fromRGBO(64, 75, 96, .9),
              ),
              decoration: InputDecoration(
                hintText: 'Search users by Id or username..',
                filled: true,
                fillColor: const Color.fromRGBO(64, 75, 96, .2),
                contentPadding: const EdgeInsets.fromLTRB(15.0, 0.0, 0.0, 0.0),
                suffixIcon: const Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Icon(Icons.search, color: Color.fromRGBO(64, 75, 96, .9)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Color.fromRGBO(64, 75, 96, .9), width: 1.0),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Color.fromRGBO(64, 75, 96, .9), width: 1.0),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                hintStyle: const TextStyle(color: Color.fromRGBO(64, 75, 96, .9)),
              ),
            ),
          ),
          searchResults == null
              ? Expanded(
                child: FutureBuilder(
                    future: _userRepository.getAllUsers(),
                    builder: (BuildContext context, AsyncSnapshot<List<User>> snapshot){
                      if (!snapshot.hasData) {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: Color.fromRGBO(64, 75, 96, .9),
                            strokeWidth: 2.0,
                          ),
                        );
                      }
                      users.isEmpty? users = snapshot.data! : null;
                      return ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: users.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
                            elevation: 8.0,
                            margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                            child: Container(
                              decoration: BoxDecoration(color: const Color.fromRGBO(64, 75, 96, .9), borderRadius: BorderRadius.circular(5)),
                              child: makeListTile(users[index]),
                            ),
                          );
                        },
                      );
                    },
                  ),
              )
              : resultList(),
        ],
      ),
    );
  }

  Widget resultList (){
    if(searchResults != null && searchResults!.isEmpty){
      return const Text("Sorry! we couldn't find matches for your search query.", style: TextStyle(color: Color.fromRGBO(64, 75, 96, .9), fontSize: 14.0));
    }else {
      return Expanded(
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: searchResults?.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              elevation: 8.0,
              margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
              child: Container(
                decoration: BoxDecoration(color: const Color.fromRGBO(64, 75, 96, .9), borderRadius: BorderRadius.circular(5)),
                child: makeListTile(searchResults![index]),
              ),
            );
          },
        ),
      );
    }
  }

  ListTile makeListTile(User user){
    return ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        leading: Container(
          padding: const EdgeInsets.only(right: 12.0),
          decoration: const BoxDecoration(
              border: Border(
                  right: BorderSide(width: 1.0, color: Colors.white24))),
          child: Text(
            user.id.toString(),
            style: const TextStyle(color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
        ),
        title: Text(
          user.name + " (" + user.username+")",
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

        subtitle: Column(
          children: [
            Row(
              children: <Widget>[
                Icon(Icons.email, size: 20.0, color: Colors.yellowAccent.shade100),
                Text(user.email, style: const TextStyle(color: Colors.white))
              ],
            ),
            Row(
              children: <Widget>[
                Icon(Icons.phone, size: 20.0, color: Colors.yellowAccent.shade100),
                Text(user.phone, style: const TextStyle(color: Colors.white))
              ],
            ),
          ],
        ),
    );
  }

  List<User> searchUsers (String searchQuery){
    List<User> searchResults = [];
    searchResults = users.where((user) => user.username.contains(searchQuery) || user.id == int.tryParse(searchQuery)).toList();
    return searchResults;
  }
}