import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/health_bloc.dart';
import 'bloc/health_event.dart';
import 'bloc/health_state.dart';
import '../../data/local/hive_service.dart';
import '../widget/bottom_nav_bar.dart';

class HealthScreen extends StatelessWidget {
  const HealthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HealthBloc(HiveService())..add(LoadHealth()),
      child: Scaffold(
        appBar: AppBar(title: const Text('Health Tracker')),
        bottomNavigationBar: const BottomNavBar(currentIndex: 1),
        body: const _HealthView(),
      ),
    );
  }
}

class _HealthView extends StatefulWidget {
  const _HealthView();

  @override
  State<_HealthView> createState() => _HealthViewState();
}

class _HealthViewState extends State<_HealthView> {
  late final TextEditingController _stepsController;
  late final TextEditingController _waterController;

  @override
  void initState() {
    super.initState();
    _stepsController = TextEditingController();
    _waterController = TextEditingController();
  }

  @override
  void dispose() {
    _stepsController.dispose();
    _waterController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HealthBloc, HealthState>(
      builder: (context, state) {
        _stepsController.text = state.steps.toString();
        _waterController.text = state.water.toString();

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              TextField(
                controller: _stepsController,
                decoration: const InputDecoration(labelText: 'Steps'),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _waterController,
                decoration: const InputDecoration(labelText: 'Water Intake (ml)'),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  context.read<HealthBloc>().add(UpdateHealth(
                    steps: int.tryParse(_stepsController.text) ?? 0,
                    water: int.tryParse(_waterController.text) ?? 0,
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
