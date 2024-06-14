import 'package:flutter/material.dart';
import 'package:gaskeun_mobile/layouts/pageOnBG.dart';
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

  void _logout() {
    // Implementasi fungsi logout
    // Misalnya, navigasi ke halaman login dan hapus token dari penyimpanan
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageOnBG(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 25,
              vertical: 40,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: [
                    const SizedBox(width: 16),
                    const Text(
                      'Profil\nPengguna',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
                color: Colors.white,
              ),
              padding: const EdgeInsets.all(25), // Mengatur padding
              width: double.infinity,
              child: FutureBuilder<User>(
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
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Center(
                          child: CircleAvatar(
                            radius: 50,
                            backgroundImage:
                                AssetImage("assets/img/profile-pic.png"),
                            backgroundColor: Colors.white,
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  width: 2,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Center(
                          child: Text(
                            user.nama,
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        ListTile(
                          leading: Icon(Icons.email, color: Color(0xFF081cff)),
                          title: Text(
                            'Email',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            user.email,
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Divider(),
                        ListTile(
                          leading: Icon(Icons.person, color: Color(0xFF081cff)),
                          title: Text(
                            'Role',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            user.role,
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Divider(),
                        // Spacer(),
                        SizedBox(height: 100),
                        Center(
                          child: ElevatedButton(
                            onPressed: _logout,
                            child: Text(
                              'Logout',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 15),
                              textStyle: TextStyle(fontSize: 15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
