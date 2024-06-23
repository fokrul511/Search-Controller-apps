import 'package:apps/list.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Map<String, dynamic>> _foundUser = [];

  @override
  void initState() {
    _foundUser = allUsers;
    super.initState();
  }

  void _runFilter(String enterkeyword) {
    List<Map<String, dynamic>> result = [];
    if (enterkeyword.isEmpty) {
      //
      result = allUsers;
    } else {
      result = allUsers
          .where((user) =>
              user['name'].toLowerCase().contains(enterkeyword.toLowerCase()))
          .toList();
    }
    setState(() {
      _foundUser = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("All Member list"),
      ),
      body: Column(
        children: [
          _buildSerachBar(),
          _buildUserListView(),
        ],
      ),
    );
  }

  Widget _buildSerachBar() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SearchBar(
        padding: const MaterialStatePropertyAll(
            EdgeInsets.symmetric(horizontal: 16)),
        hintText: "Search",
        trailing: [const Icon(Icons.search_rounded)],
        onChanged: (value) => _runFilter(value),
      ),
    );
  }

  Widget _buildUserListView() {
    return Expanded(
      child: ListView.builder(
        itemCount: _foundUser.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
            child: Card(
              key: ValueKey(_foundUser[index]['id']),
              child: ListTile(
                title: Text(_foundUser[index]['name']),
                subtitle: Text(_foundUser[index]['age'].toString()),
                leading: const Icon(Icons.person),
                trailing:
                    IconButton(onPressed: () {}, icon: const Icon(Icons.phone)),
              ),
            ),
          );
        },
      ),
    );
  }
}
