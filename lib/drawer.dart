import 'package:flutter/material.dart';
import 'moodtracker.dart';
import 'entries.dart';

class DrawerWidget extends StatelessWidget {
  final List<Map<String, dynamic>> pastSubmissions;

  const DrawerWidget({super.key, required this.pastSubmissions});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const SizedBox(
            height: 130,
            child: DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 1, 77, 46),
              ),
              child: Text(
                "Records",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.book),
            title: const Text("Mood Tracker"),
            onTap: () {
              Navigator.pushNamed(context, MoodTrackerForm.routename);
            },
          ),
          ListTile(
            leading: const Icon(Icons.history),
            title: const Text("Mood Entries"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EntriesPage(pastSubmissions: pastSubmissions),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
