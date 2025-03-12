# Personal Mood Tracker App

**Name:** Tanya Marinelle G. Manaoat <br/>
**Affiliation:** University of the Philippines Los Baños

## Description

In this activity, I created a mood tracker application in Flutter that allows users to input their name, nickname, and age, select whether they exercised, choose their current mood through radio buttons, set the intensity of their emotion with a slider, and pick the weather through a dropdown menu. After submitting, a summary of the inputs is shown, along with a mood history of previous submissions. I also implemented functionality to reset the form while ensuring that the "exercised today?" switch stays on as the default. Additionally, I added a feature to display all user inputs in lowercase in both the summary and mood history, no matter how they were originally typed.

## Challenges encountered

One challenge I faced was making sure that the reset button would not unnecessarily reset the form when no changes were made, while also making sure that the exercise switch stays turned on by default even after resetting. Another challenge was ensuring that the inputs display in lowercase in the summary and history without affecting the actual data stored in the controllers or the logic of the form.

## Solutions

To handle the reset button, I added a condition that checks if the fields are already empty or set to their default values before allowing the reset. If no changes are detected, a snackbar message appears to inform the user that there is nothing to reset. To keep the exercise switch on, I modified the reset method to avoid resetting hasExercised to false and instead kept its value as true. For displaying the inputs in lowercase, I applied the .toLowerCase() method directly when displaying the values in the summary and history, making sure the output is consistent regardless of how the user typed their inputs.

## References

- [reference](https://api.flutter.dev/flutter/dart-core/RegExp-class.html)
