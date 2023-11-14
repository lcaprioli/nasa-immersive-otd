import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:nasa_immersive_od/features/immersive/presentation/timeline/bloc/timeline_bloc.dart';
import 'package:nasa_immersive_od/features/immersive/presentation/timeline/bloc/timeline_state.dart';
import 'package:nasa_immersive_od/shared/utils/date_utils.dart';

class TimelinePage extends StatefulWidget {
  const TimelinePage({super.key, required this.bloc});

  final TimelineBloc bloc;

  @override
  State<TimelinePage> createState() => _TimelinePageState();
}

class _TimelinePageState extends State<TimelinePage> {
  @override
  void initState() {
    widget.bloc.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<TimelineBloc, TimelineState>(
          bloc: widget.bloc,
          listener: (context, state) {
            if (state is TimelineError) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 40,
                vertical: 20,
              ),
              child: switch (state) {
                TimelineInitial() => const SizedBox.shrink(),
                TimelineInProgress() => const CircularProgressIndicator(),
                TimelineSuccess() => Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        state.immersives.map((e) => e.title).toList().join(','),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: state.immersives
                            .map(
                              (e) => Text(DateFormat.MMMd().format(e.date)),
                            )
                            .toList(),
                      ),
                      Text(state.page.toString()),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FilledButton(
                            onPressed: widget.bloc.prev,
                            child: const Text('<'),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          FilledButton(
                            onPressed: state.page > 0 ? widget.bloc.next : null,
                            child: const Text('>'),
                          ),
                        ],
                      ),
                    ],
                  ),
                TimelineError() => Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.crisis_alert,
                        size: 95,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        state.message,
                        textAlign: TextAlign.center,
                      )
                    ],
                  )
              },
            );
          }),
    );
  }
}
