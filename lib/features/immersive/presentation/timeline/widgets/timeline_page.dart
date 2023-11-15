import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
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
  @override
  void initState() {
    widget.bloc.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              child: Text(
                'Immersive of the Day',
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium
                    ?.copyWith(color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              child: BlocConsumer<TimelineBloc, TimelineState>(
                  bloc: widget.bloc,
                  listener: (context, state) {
                    if (state is TimelineError) {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text(state.message)));
                    }
                  },
                  builder: (context, state) {
                    return Center(
                      child: switch (state) {
                        TimelineInitial() => const SizedBox.shrink(),
                        TimelineInProgress() =>
                          const CircularProgressIndicator(),
                        TimelineSuccess() => Column(
                            children: [
                              Flexible(
                                flex: 3,
                                child: TimelineCarousel(
                                  immersives: state.immersives,
                                ),
                              ),
                              ColoredBox(
                                color: Colors.grey,
                                child: Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: FilledButton(
                                          onPressed: widget.bloc.prev,
                                          child: const Text('< Previous'),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      Expanded(
                                        child: FilledButton(
                                          onPressed: state.page > 0
                                              ? widget.bloc.next
                                              : null,
                                          child: const Text('Next >'),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
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
            ),
          ],
        ),
      ),
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
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    _actual = widget.immersives.length - 1;
    _controller = PageController(initialPage: _actual);
    super.initState();
  }

  @override
  void didUpdateWidget(covariant TimelineCarousel oldWidget) {
    _actual = widget.immersives.length - 1;
    _controller = PageController(initialPage: _actual);

    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            flex: 5,
            child: PageView.builder(
              controller: _controller,
              itemCount: widget.immersives.length,
              itemBuilder: (_, index) => Column(
                children: [
                  Expanded(
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Positioned.fill(
                          child: Image.memory(
                            Uint8List.fromList(
                                widget.immersives.elementAt(index).imageBytes ??
                                    []),
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Align(
                          child: FilledButton(
                            style: FilledButton.styleFrom(
                                padding: const EdgeInsets.all(20),
                                textStyle:
                                    Theme.of(context).textTheme.headlineSmall,
                                backgroundColor: Colors.black.withAlpha(80)),
                            onPressed: () => Modular.to.pushNamed('/detail',
                                arguments: widget.immersives.elementAt(index)),
                            child: const Text('Open Immersive'),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Text(
                      widget.immersives.elementAt(index).title,
                      style: Theme.of(context).textTheme.headlineSmall,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(
                widget.immersives.length,
                (index) => Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: FilledButton(
                      style: index == _actual
                          ? FilledButton.styleFrom(
                              backgroundColor: Colors.deepOrangeAccent)
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
            ),
          ),
        ],
      ),
    );
  }
}
