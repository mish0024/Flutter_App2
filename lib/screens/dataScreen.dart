import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class DataPage extends StatefulWidget {
  const DataPage({super.key});

  @override
  State<DataPage> createState() => _DataPageState();
}

class _DataPageState extends State<DataPage> {
  late Future<List<User>> userData;

  @override
  void initState() {
    super.initState();
    userData = fetchUserData();
  }

  Future<List<User>> fetchUserData() async {
    final Uri uri = Uri.https('randomuser.me', '/api/', {'results': '10'});
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final Map<String, dynamic> json = jsonDecode(response.body);
      final List<dynamic> results = json['results'];
      return results.map((data) => User.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load user data');
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: FutureBuilder<List<User>>(
        future: userData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error: ${snapshot.error}',
                style: textTheme.bodySmall,
              ),
            );
          } else if (snapshot.hasData) {
            final users = snapshot.data!;
            return ListView.builder(
              padding: const EdgeInsets.all(12.0),
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];
                return Card(
                  elevation: 2.0,
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(user.pictureUrl),
                    ),
                    title: Text(
                      '${user.firstName} ${user.lastName}',
                      style: textTheme.bodySmall,
                    ),
                    subtitle: Text(
                      user.email,
                      style: textTheme.bodySmall,
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(
              child: Text(
                'No user data available.',
                style: textTheme.bodySmall,
              ),
            );
          }
        },
      ),
    );
  }
}

class User {
  final String firstName;
  final String lastName;
  final String email;
  final String pictureUrl;

  User({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.pictureUrl,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      firstName: json['name']['first'],
      lastName: json['name']['last'],
      email: json['email'],
      pictureUrl: json['picture']['thumbnail'],
    );
  }
}