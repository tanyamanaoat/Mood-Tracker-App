import 'moodtracker.dart';
import 'package:flutter/material.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

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
        ],
      ),
    );
  }
}
