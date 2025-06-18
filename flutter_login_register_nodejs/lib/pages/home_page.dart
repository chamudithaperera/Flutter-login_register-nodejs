import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../services/shared_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF3ED),
      appBar: AppBar(
        title: const Text(
          'Home',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFFFF5C00),
        elevation: 0,
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: () {
              SharedService.logout(context);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Profile Information',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF242424),
                ),
              ),
              const SizedBox(height: 24),
              userProfile(),
            ],
          ),
        ),
      ),
    );
  }

  Widget userProfile() {
    return FutureBuilder(
      future: APIService.getUserProfile(),
      builder: (BuildContext context, AsyncSnapshot<String> model) {
        if (model.hasData) {
          return Text(
            model.data!,
            style: const TextStyle(fontSize: 16, color: Color(0xFF666666)),
          );
        }
        return const Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFFF5C00)),
          ),
        );
      },
    );
  }
}
