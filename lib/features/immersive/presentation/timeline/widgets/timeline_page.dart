import 'dart:ffi';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:nasa_immersive_od/features/immersive/domain/entities/immersive_entity.dart';
import 'package:nasa_immersive_od/features/immersive/presentation/timeline/bloc/timeline_bloc.dart';
import 'package:nasa_immersive_od/features/immersive/presentation/timeline/bloc/timeline_state.dart';

class TimelinePage extends StatefulWidget {
  const TimelinePage({super.key, required this.bloc});

  final TimelineBloc bloc;

  @override
  State<TimelinePage> createState() => _TimelinePageState();
}

class _TimelinePageState extends State<TimelinePage> {
  final _controller = PageController();

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
                    children: [
                      Expanded(
                        child: TimelineCarousel(
                          immersives: state.immersives,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
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
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      FilledButton(
                        onPressed: widget.bloc.refresh,
                        child: const Text('Retry'),
                      )
                    ],
                  )
              },
            );
          }),
    );
  }
}

class TimelineCarousel extends StatefulWidget {
  const TimelineCarousel({
    super.key,
    required this.immersives,
  });

  final Set<ImmersiveEntity> immersives;

  @override
  State<TimelineCarousel> createState() => _TimelineCarouselState();
}

class _TimelineCarouselState extends State<TimelineCarousel> {
  late PageController _controller;
  late int _actual;
  @override
  void initState() {
    _actual = widget.immersives.length - 1;
    _controller = PageController(initialPage: _actual);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: PageView.builder(
            controller: _controller,
            itemCount: widget.immersives.length,
            itemBuilder: (_, index) => Column(
              children: [
                Image.memory(Uint8List.fromList(
                    widget.immersives.elementAt(index).imageBytes ?? [])),
                Text(
                  widget.immersives.elementAt(index).title,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        Wrap(
          alignment: WrapAlignment.center,
          children: List.generate(
            widget.immersives.length,
            (index) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: FilledButton(
                style: index == _actual
                    ? FilledButton.styleFrom(backgroundColor: Colors.amber)
                    : null,
                onPressed: () => setState(() {
                  _actual = index;
                  _controller.jumpToPage(index);
                }),
                child: Text(DateFormat.MMMd()
                    .format(widget.immersives.elementAt(index).date)),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
