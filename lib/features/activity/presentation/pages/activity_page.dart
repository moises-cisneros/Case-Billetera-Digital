import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:case_digital_wallet/core/theme/app_theme.dart';
import 'package:case_digital_wallet/features/activity/presentation/bloc/activity_bloc.dart';

class ActivityPage extends StatefulWidget {
  const ActivityPage({super.key});

  @override
  State<ActivityPage> createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  late final ActivityBloc _activityBloc;

  @override
  void initState() {
    super.initState();
    _activityBloc = ActivityBloc()..add(LoadActivitiesRequested());
  }

  @override
  void dispose() {
    _activityBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _activityBloc,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Actividad'),
          automaticallyImplyLeading: false,
        ),
        body: BlocBuilder<ActivityBloc, ActivityState>(
          builder: (context, state) {
            if (state is ActivityLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ActivityLoaded) {
              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: state.activities.length,
                itemBuilder: (context, index) {
                  final activity = state.activities[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    child: ListTile(
                      leading: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: activity.type == 'deposit'
                              ? AppTheme.successColor.withOpacity(0.1)
                              : AppTheme.textTertiary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          activity.type == 'deposit'
                              ? Icons.arrow_downward
                              : Icons.swap_horiz,
                          color: activity.type == 'deposit'
                              ? AppTheme.successColor
                              : AppTheme.textTertiary,
                          size: 20,
                        ),
                      ),
                      title: Text(
                        activity.description,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      subtitle: Text(
                        activity.date.toString(),
                        style: TextStyle(
                          color: AppTheme.textSecondary,
                          fontSize: 14,
                        ),
                      ),
                      trailing: Text(
                        'Bs ${activity.amount.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: activity.amount >= 0
                              ? AppTheme.successColor
                              : AppTheme.textPrimary,
                        ),
                      ),
                    ),
                  );
                },
              );
            } else if (state is ActivityError) {
              return Center(
                child: Text(
                  state.message,
                  style: const TextStyle(color: AppTheme.errorColor),
                ),
              );
            }

            return const Center(
              child: Text('No hay actividades para mostrar'),
            );
          },
        ),
      ),
    );
  }
}
