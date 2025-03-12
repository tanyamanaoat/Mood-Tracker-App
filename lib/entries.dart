import 'package:flutter/material.dart';

class EntriesPage extends StatelessWidget {
  final List<Map<String, dynamic>> pastSubmissions;

  const EntriesPage({super.key, required this.pastSubmissions});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mood Entries"),
      ),
      body: pastSubmissions.isEmpty
          ? const Center(
              child: Text(
                "No mood entries available.",
                style: TextStyle(fontSize: 18),
              ),
            )
          : ListView.builder(
              itemCount: pastSubmissions.length,
              itemBuilder: (context, index) {
                final entry = pastSubmissions[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: ListTile(
                    title: Text(entry['name'] ?? 'Unknown'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("nickname: ${entry['nickname'].toString().isEmpty ? 'n/a' : entry['nickname']}"),
                        Text("age: ${entry['age']}"),
                        Text("has exercised: ${entry['hasExercised'] ? 'yes' : 'no'}"),
                        Text("mood: ${entry['mood']}"),
                        Text("emotion level: ${entry['emotionLevel']}"),
                        Text("weather: ${entry['weather']}"),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
