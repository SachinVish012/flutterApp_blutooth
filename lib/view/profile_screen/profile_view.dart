import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:test_blutooth/res/api_url/api_url.dart';
import 'package:test_blutooth/res/model/profile_details_model.dart';
import 'package:http/http.dart' as http;
import 'package:test_blutooth/view/profile_screen/user_details.dart';
import '../../res/custom_widget/custom_textformfield.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("Profile",style: TextStyle(color: Colors.white),),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: FutureBuilder<UserModel>(
        future: fetchData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return UserDetails(user: snapshot.data!);
          }
        },
      ),
    );
  }
  Future<UserModel> fetchData() async {
    final response = await http.get(Uri.parse(APIURL.profileDetails));
    print(response.body.toString());
    if (response.statusCode == 200) {
      print("---------True--------");
      final jsonData = json.decode(response.body);
      final userJson = jsonData['results'][0];
      return UserModel.fromJson(userJson);
    } else {
      throw Exception('Failed to load data');
    }
  }
}

