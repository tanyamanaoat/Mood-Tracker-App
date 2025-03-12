import 'package:flutter/material.dart';
import 'drawer.dart';

class MoodTrackerForm extends StatefulWidget {
  const MoodTrackerForm({super.key});
  static const routename = "/MoodTracker";

  @override
  State<MoodTrackerForm> createState() => _MoodTrackerFormState();
}


List<Map<String, dynamic>> pastSubmissions = [];
class _MoodTrackerFormState extends State<MoodTrackerForm> {
  // Dropdown options
  List<String> dropdownOptions = ["sunny", "rainy", "stormy", "hailing", "snowy", "cloudy", "foggy", "partly cloudy"];

  // Initial values
  bool hasExercised= true;
  double emotionLevel = 5.0;
  String dropdownValue = "sunny";
  String selectedMood = "happy";
  bool result = false;

  // Key and controllers
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController nicknameController = TextEditingController();
  TextEditingController ageController = TextEditingController();

  // Submitted values stored in variables
  late String submittedName;
  late String submittedNickname;
  late String submittedAge;
  late double submittedemotionLevel;
  late bool submittedhasExercised;
  late String submittedDropdownValue;
  late String submittedMood;

  // Regular expressions to match names and nicknames
  final RegExp nameRegex = RegExp(r'^[A-Za-z]+(?: [A-Za-z]+)*$'); // Allows multiple words separated by a space
  final RegExp nicknameRegex = RegExp(r'^[A-Za-z]+(?: [A-Za-z]+)?$'); // Allows one or two words separated by a space

  // Function to validate the name
  bool isValidName(String name) {
    return nameRegex.hasMatch(name);
  }

  // Validate the nickname
  bool isValidNickname(String nickname) {
    return nicknameRegex.hasMatch(nickname);
  }

  // Reset the form
  void resetForm() {
    // Checks if there are values to reset
    if (nameController.text.isEmpty &&
        nicknameController.text.isEmpty &&
        ageController.text.isEmpty &&
        !hasExercised &&
        emotionLevel == 5.0 &&
        dropdownValue == "sunny" &&
        selectedMood == "happy") {
      ScaffoldMessenger.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(
          const SnackBar(content: Text("Nothing to reset.")),
        );
      return;
    }
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(
        const SnackBar(content: Text("Record has been reset.")),
      );
    _formKey.currentState?.reset();
    nameController.clear();
    nicknameController.clear();
    ageController.clear();

    setState(() {
      hasExercised = true;
      emotionLevel = 5.0;
      dropdownValue = "sunny";
      selectedMood = "happy";
      result = false;
    });
    
  }

  // Submits the data to be transferred
  void submitForm() {
    // Check if name is already in past submissions, using lowercase for case-insensitive comparison
    bool nameExists = pastSubmissions.any(
      (submission) => submission['name'].toLowerCase() == nameController.text.toLowerCase(),
    );

    if (nameExists) {
      ScaffoldMessenger.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(
          const SnackBar(content: Text("An error occured. Name already exists.")),
        );
      return;
    }

    // Check if name is valid (e.g. Tanya Marinelle Manaoat)
    if (!isValidName(nameController.text)) {
      ScaffoldMessenger.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(
          const SnackBar(content: Text("An error occured. Name must not contain other characters or numbers.")),
        );
      return;
    }

    // Check if nickname is valid (e.g. Tanya, Marinelle)
    if (nicknameController.text.isNotEmpty && !isValidNickname(nicknameController.text)) {
      ScaffoldMessenger.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(
          const SnackBar(content: Text("An error occured. Nickname must not contain other characters or numbers.")),
        );
      return;
    }

    // Validates the form before submission
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      ScaffoldMessenger.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(
          const SnackBar(content: Text("Record successfully saved.")),
        );
      setState(() {
        // Stores new values in submitted variables
        submittedName = nameController.text;
        submittedNickname = nicknameController.text.trim();
        submittedAge = ageController.text;
        submittedhasExercised = hasExercised;
        submittedemotionLevel = emotionLevel;
        submittedDropdownValue = dropdownValue;
        submittedMood = selectedMood;
        result = true; // To show the summary

        // Appends map to friendlist
        pastSubmissions.add({
          'name': submittedName,
          'nickname': submittedNickname,
          'age': submittedAge,
          'hasExercised': submittedhasExercised,
          'emotionLevel': submittedemotionLevel,
          'weather': submittedDropdownValue,
          'mood': submittedMood,
        });
        // Displays summary
        result = true;
      });
    } else {
      // when invalid
      setState(() {
        result = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerWidget(),
      appBar: AppBar(
        title: const Text("mood tracker"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // Mood Tracker Heading
                Column(
                  children: [
                    const SizedBox(height: 10),
                    Center(
                        child: Image.asset("assets/avatar.png",
                            height: 150, width: 150)),
                    const Center(
                      child: Text(
                        "personal mood tracker",
                        style: TextStyle(
                            color: Color.fromARGB(255, 7, 94, 81),
                            fontSize: 35, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: Center(
                        child: Text(
                          "welcome to mood tracker! track and regulate your emotions today",
                            style: TextStyle(
                              color: Color.fromARGB(255, 7, 94, 81),
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    const Divider(color: Color.fromARGB(255, 129, 197, 167)),
                  ],
                ),

                // Form Fields (Name, Nickname, Age, Exercise Status)
                Column(
                  children: [
                    const SizedBox(height: 20),
                    TextFormField(
                      cursorColor: const Color.fromARGB(255, 158, 217, 193),
                      controller: nameController,
                      decoration: const InputDecoration(
                        labelText: "name",
                            prefixIcon: Icon(
                            Icons.local_florist,
                            color: Color.fromARGB(255, 171, 212, 195),
                          ),
                            floatingLabelStyle: TextStyle(
                              fontSize: 20,
                              color: Color.fromARGB(255, 146, 201, 177),
                              fontWeight: FontWeight.bold,
                            ),
                            labelStyle: TextStyle(
                              color: Colors.grey,
                            ),
                        border: OutlineInputBorder(),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter your name";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      cursorColor: const Color.fromARGB(255, 158, 217, 193),
                      controller: nicknameController,
                      decoration: const InputDecoration(
                        labelText: "nickname (optional)",
                            prefixIcon: Icon(
                            Icons.local_florist,
                            color: Color.fromARGB(255, 171, 212, 195),
                             ),
                              floatingLabelStyle: TextStyle(
                                fontSize: 20,
                                color: Color.fromARGB(255, 146, 201, 177),
                                fontWeight: FontWeight.bold,
                              ),
                              labelStyle: TextStyle(
                                color: Colors.grey,
                              ),
                        border: OutlineInputBorder(),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: TextFormField(
                            cursorColor: const Color.fromARGB(255, 158, 217, 193),
                            controller: ageController,
                            decoration: const InputDecoration(
                              labelText: "age",
                                prefixIcon: Icon(
                                Icons.local_florist,
                                color: Color.fromARGB(255, 171, 212, 195), 
                              ),
                                floatingLabelStyle: TextStyle(
                                  fontSize: 20,
                                  color: Color.fromARGB(255, 146, 201, 177),
                                  fontWeight: FontWeight.bold,
                                ),
                                labelStyle: TextStyle(
                                  color: Colors.grey,
                                ),
                                  border: OutlineInputBorder(),
                              filled: true,
                              fillColor: Colors.white,
                            ),
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter your age";
                              }
                              if (int.tryParse(value) == null) {
                                return "Please enter a number only";
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(width: 20),
                        Row(
                          children: [
                            Text(
                              "exercised today?",
                              style: TextStyle(
                                color: Color.fromARGB(255, 7, 94, 81),
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Switch(
                              focusColor: Colors.white,
                              activeColor: const Color.fromARGB(255, 184, 225, 200),
                              value: hasExercised,
                              onChanged: (value) {
                                setState(() {
                                  hasExercised = value;
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                                
                // Mood (Radio Selection)
                Column(
                  children: <Widget>[
                    Center(
                      child: Icon(Icons.eco_rounded, size: 50, color: const Color.fromARGB(255, 184, 225, 200))
                    ),
                    const Center(
                      child: Text(
                        "how are you feeling today?",
                            style: TextStyle(
                              color: Color.fromARGB(255, 7, 94, 81),
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                    Column(
                      children: <Widget>[
                        RadioListTile(
                          title: const Text(
                            "happy",
                            style: TextStyle(fontSize: 15),
                          ),
                          value: "happy", 
                          groupValue: selectedMood,
                          onChanged: (value) {
                            setState(() {
                              selectedMood = "$value";
                            });
                          },
                          contentPadding: const EdgeInsets.only(left: 10, right: 30),
                        ),
                        RadioListTile(
                          title: const Text(
                            "disgust",
                            style: TextStyle(fontSize: 15),
                          ),
                          value: "disgust", 
                          groupValue: selectedMood,
                          onChanged: (value) {
                            setState(() {
                              selectedMood = "$value";
                            });
                          },
                          contentPadding: const EdgeInsets.only(left: 10, right: 30),
                        ),
                        RadioListTile(
                          title: const Text(
                            "anger",
                            style: TextStyle(fontSize: 15),
                          ),
                          value: "anger", 
                          groupValue: selectedMood,
                          onChanged: (value) {
                            setState(() {
                              selectedMood = "$value";
                            });
                          },
                          contentPadding: const EdgeInsets.only(left: 10, right: 30),
                        ),
                        RadioListTile(
                          title: const Text(
                            "embarrassment",
                            style: TextStyle(fontSize: 15),
                          ),
                          value: "embarrassment", 
                          groupValue: selectedMood,
                          onChanged: (value) {
                            setState(() {
                              selectedMood = "$value";
                            });
                          },
                          contentPadding: const EdgeInsets.only(left: 10, right: 30),
                        ),
                        RadioListTile(
                          title: const Text(
                            "sadness",
                            style: TextStyle(fontSize: 15),
                          ),
                          value: "sadness", 
                          groupValue: selectedMood,
                          onChanged: (value) {
                            setState(() {
                              selectedMood = "$value";
                            });
                          },
                          contentPadding: const EdgeInsets.only(left: 10, right: 30),
                        ),
                        RadioListTile(
                          title: const Text(
                            "fear",
                            style: TextStyle(fontSize: 15),
                          ),
                          value: "fear", 
                          groupValue: selectedMood,
                          onChanged: (value) {
                            setState(() {
                              selectedMood = "$value";
                            });
                          },
                          contentPadding: const EdgeInsets.only(left: 10, right: 30),
                        ),
                        RadioListTile(
                          title: const Text(
                            "anxiety",
                            style: TextStyle(fontSize: 15),
                          ),
                          value: "anxiety", 
                          groupValue: selectedMood,
                          onChanged: (value) {
                            setState(() {
                              selectedMood = "$value";
                            });
                          },
                          contentPadding: const EdgeInsets.only(left: 10, right: 30),
                        ),
                        RadioListTile(
                          title: const Text(
                            "envy",
                            style: TextStyle(fontSize: 15),
                          ),
                          value: "envy",
                          groupValue: selectedMood,
                          onChanged: (value) {
                            setState(() {
                              selectedMood = value!;
                            });
                          },
                        contentPadding: const EdgeInsets.only(left: 10, right: 30),
                      ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                // Emotion Level (0 to 10)
                Column(
                  children: <Widget>[
                    const Divider(color: Color.fromARGB(255, 129, 197, 167)),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.mood_bad_rounded, // For negative emotions (sad)
                          size: 40,
                          color: Color.fromARGB(255, 184, 225, 200),
                        ),
                        Icon(
                          Icons.sentiment_neutral_rounded, // For neutral mood
                          size: 40,
                          color: Color.fromARGB(255, 184, 225, 200), 
                        ),
                        Icon(
                          Icons.mood_rounded, // For positive emotions (happy)
                          size: 40,
                          color: Color.fromARGB(255, 184, 225, 200),
                        ),
                      ],
                    ),
                    const Center(
                      child: Text(
                        "emotion level",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 7, 94, 81),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: Center(
                        child: Text(
                          "how strong do you feel this emotion?",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 7, 94, 81), 
                            ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    Slider(
                        value: emotionLevel,
                        min: 0,
                        max: 10,
                        divisions: 10,
                        label: emotionLevel.round().toString(),
                        activeColor: const Color.fromARGB(255, 122, 204, 186), // The color of the part that shows the selected value
                        inactiveColor: const Color.fromARGB(255, 255, 255, 255), // The color of the part that is unselected
                        onChanged: (double value) {
                          setState(() {
                            emotionLevel = value;
                          });
                        }),
                    const SizedBox(height: 7),
                    const Divider(color: Color.fromARGB(255, 129, 197, 167)),
                  ],
                ),
                const SizedBox(height: 10),
                // Weather (Dropdown Selection)
                Column(
                  children: <Widget>[
                    Center(
                        child: Icon(
                      Icons.cloud_queue_rounded,
                      size: 60,
                      color: const Color.fromARGB(255, 184, 225, 200),
                    )),
                    const Center(
                      child: Text(
                        "weather",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 7, 94, 81), 
                          ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: Center(
                        child: Text(
                          "how is the weather today?",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 7, 94, 81),
                            ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: SizedBox(
                        height: 60,
                        width: 160,
                        child: DropdownButtonFormField(
                        decoration: const InputDecoration(
                          labelText: "options",
                            labelStyle: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold, 
                          ),
                          border: OutlineInputBorder(),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        value: dropdownValue,
                        items: dropdownOptions.map((item) {
                          return DropdownMenuItem(
                            value: item,
                            child: Text(item),
                          );
                        }).toList(),
                        onChanged: (newItem) {
                          setState(() {
                            dropdownValue = newItem!;
                          });
                        }
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Divider(color: Color.fromARGB(255, 129, 197, 167)),
                    const SizedBox(height: 10),
                  ],
                ),
                // Reset and Submit Buttons
                Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      height: 40,
                      margin: const EdgeInsets.symmetric(horizontal: 3),
                      child: FloatingActionButton.extended(
                        backgroundColor: Color(0xFFDFF5E1),
                        foregroundColor: const Color.fromARGB(255, 30, 71, 44),
                        onPressed: resetForm,
                        label: const Text("Reset"),
                        icon: const Icon(Icons.refresh),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 40,
                      margin: const EdgeInsets.symmetric(horizontal: 3),
                      child: FloatingActionButton.extended(
                        backgroundColor: const Color.fromARGB(255, 46, 125, 89),
                        foregroundColor: Colors.white,
                        onPressed: submitForm,
                        label: const Text("Submit"),
                        icon: const Icon(Icons.send),
                      ),
                    ),
                  ),
                ],
              ),
              
              // Summary Upon Submission
              if (result) ...[
                const SizedBox(height: 20),
                Divider(color: Color.fromARGB(255, 129, 197, 167)),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border.all(color: Color.fromARGB(255, 129, 197, 167)),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(child: Icon(Icons.book_rounded, size: 40, color: Color.fromARGB(255, 184, 225, 200))),
                      const Center(
                        child: Text(
                          "today's summary",
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const Divider(color: Color.fromARGB(255, 129, 197, 167)),
                      Table(
                      columnWidths: const {
                        0: FlexColumnWidth(1),
                        1: FlexColumnWidth(2),
                      },
                      children: [
                        TableRow(
                          children: [
                            const Text("name", style: TextStyle(fontWeight: FontWeight.bold)),
                            Text(submittedName.toLowerCase()),
                          ],
                        ),
                        if (submittedNickname.isNotEmpty)
                          TableRow(
                            children: [
                              const Text("nickname", style: TextStyle(fontWeight: FontWeight.bold)),
                              Text(submittedNickname.toLowerCase()),
                            ],
                          ),
                        TableRow(
                          children: [
                            const Text("age", style: TextStyle(fontWeight: FontWeight.bold)),
                            Text(submittedAge.toLowerCase()),
                          ],
                        ),
                        TableRow(
                          children: [
                            const Text("exercise status", style: TextStyle(fontWeight: FontWeight.bold)),
                            Text(submittedhasExercised ? "has exercised" : "has not exercised"),
                          ],
                        ),
                        TableRow(
                          children: [
                            const Text("emotion levels", style: TextStyle(fontWeight: FontWeight.bold)),
                            Text("$submittedemotionLevel"),
                          ],
                        ),
                        TableRow(
                          children: [
                            const Text("weather", style: TextStyle(fontWeight: FontWeight.bold)),
                            Text(submittedDropdownValue),
                          ],
                        ),
                        TableRow(
                          children: [
                            const Text("mood today", style: TextStyle(fontWeight: FontWeight.bold)),
                            Text(submittedMood, textAlign: TextAlign.justify),
                          ],
                        ),
                      ],
                    ),
                    ],
                  ),
                ),
              ],
              if (pastSubmissions.isNotEmpty) ...[
              const SizedBox(height: 30),
              Divider(color: Color.fromARGB(255, 129, 197, 167)),
              const Center(
                child: Text(
                  "mood history",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 10),
              ...pastSubmissions.map((submission) => Container(
                margin: const EdgeInsets.symmetric(vertical: 8),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Color(0xFFDFF5E1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("name: ${submission['name'].toString().toLowerCase()}"),
                    if (submission['nickname'].isNotEmpty) Text("nickname: ${submission['nickname'].toString().toLowerCase()}"),
                    Text("age: ${submission['age']}"),
                    Text("exercise status: ${submission['hasExercised'] ? 'has exercised' : 'has not exercised'}"),
                    Text("emotion level: ${submission['emotionLevel']}"),
                    Text("weather: ${submission['weather']}"),
                    Text("mood: ${submission['mood']}"),
                  ],
                ),
              )),
            ],
              const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}