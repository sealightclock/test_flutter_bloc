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
        body: const _MoodView(),
      ),
    );
  }
}

class _MoodView extends StatefulWidget {
  const _MoodView();

  @override
  State<_MoodView> createState() => _MoodViewState();
}

class _MoodViewState extends State<_MoodView> {
  late final TextEditingController _moodController;
  late final TextEditingController _noteController;

  @override
  void initState() {
    super.initState();
    _moodController = TextEditingController();
    _noteController = TextEditingController();
  }

  @override
  void dispose() {
    _moodController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MoodBloc, MoodState>(
      builder: (context, state) {
        _moodController.text = state.mood;
        _noteController.text = state.note;

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              TextField(controller: _moodController, decoration: const InputDecoration(labelText: 'Mood')),
              const SizedBox(height: 10),
              TextField(controller: _noteController, decoration: const InputDecoration(labelText: 'Note')),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  context.read<MoodBloc>().add(UpdateMood(
                    mood: _moodController.text,
                    note: _noteController.text,
                  ));
                },
                child: const Text('Save'),
              ),
            ],
          ),
        );
      },
    );
  }
}
