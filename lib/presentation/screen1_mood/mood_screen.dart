import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/mood_bloc.dart';
import 'bloc/mood_event.dart';
import 'bloc/mood_state.dart';
import '../../data/local/hive_service.dart';
import '../widget/bottom_nav_bar.dart';

class MoodScreen extends StatelessWidget {
  const MoodScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MoodBloc(HiveService())..add(LoadMood()),
      child: Scaffold(
        appBar: AppBar(title: const Text('Mood Tracker')),
        bottomNavigationBar: const BottomNavBar(currentIndex: 0),
        body: BlocBuilder<MoodBloc, MoodState>(
          builder: (context, state) {
            final moodController = TextEditingController(text: state.mood);
            final noteController = TextEditingController(text: state.note);

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  TextField(controller: moodController, decoration: const InputDecoration(labelText: 'Mood')),
                  const SizedBox(height: 10),
                  TextField(controller: noteController, decoration: const InputDecoration(labelText: 'Note')),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      context.read<MoodBloc>().add(UpdateMood(
                        mood: moodController.text,
                        note: noteController.text,
                      ));
                    },
                    child: const Text('Save'),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
