import 'package:flutter/material.dart';
import '../../api/api_service.dart';
import '../../models/Profile.dart';

class ProfilePage extends StatefulWidget {
  final String token;

  ProfilePage({required this.token});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late Future<User> futureUser;

  @override
  void initState() {
    super.initState();
    futureUser = ApiService().fetchUserProfile(widget.token).then((data) {
      return User.fromJson(data);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile'),
      ),
      body: FutureBuilder<User>(
        future: futureUser,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return Center(child: Text('No data available'));
          } else {
            User user = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('ID: ${user.id}', style: TextStyle(fontSize: 16)),
                  SizedBox(height: 8),
                  Text('Nama: ${user.nama}', style: TextStyle(fontSize: 16)),
                  SizedBox(height: 8),
                  Text('Email: ${user.email}', style: TextStyle(fontSize: 16)),
                  SizedBox(height: 8),
                  Text('Role: ${user.role}', style: TextStyle(fontSize: 16)),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
