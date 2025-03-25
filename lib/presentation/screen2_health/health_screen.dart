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
        body: BlocBuilder<HealthBloc, HealthState>(
          builder: (context, state) {
            final stepController = TextEditingController(text: state.steps.toString());
            final waterController = TextEditingController(text: state.water.toString());

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  TextField(
                    controller: stepController,
                    decoration: const InputDecoration(labelText: 'Steps'),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: waterController,
                    decoration: const InputDecoration(labelText: 'Water Intake (ml)'),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      context.read<HealthBloc>().add(UpdateHealth(
                        steps: int.tryParse(stepController.text) ?? 0,
                        water: int.tryParse(waterController.text) ?? 0,
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
