import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nasa_immersive_od/features/immersive/presentation/timeline/bloc/timeline_bloc.dart';
import 'package:nasa_immersive_od/features/immersive/presentation/timeline/bloc/timeline_state.dart';

class TimelinePage extends StatelessWidget {
  const TimelinePage({super.key, required this.bloc});

  final TimelineBloc bloc;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<TimelineBloc, TimelineState>(
          bloc: bloc,
          listener: (context, state) {
            if (state is TimelineError) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
          builder: (context, state) {
            return switch (state) {
              TimelineInitial() => const SizedBox.shrink(),
              TimelineInProgress() => const CircularProgressIndicator(),
              TimelineSuccess() => Column(
                  children: [
                    Text(state.page.toString()),
                    Text(state.immersives.map((e) => e.title).toList().join())
                  ],
                ),
              TimelineState() => const SizedBox.shrink(),
            };
          }),
    );
  }
}
