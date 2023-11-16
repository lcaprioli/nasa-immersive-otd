import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:nasa_immersive_od/features/immersive/data/dtos/immersive_dto.dart';
import 'package:nasa_immersive_od/features/immersive/domain/entities/immersive_entity.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final tImmersiveDto = ImmersiveDto(
    date: DateTime(2017, 7, 8),
    explanation:
        "Similar in size to large, bright spiral galaxies in our neighborhood, IC 342 is a mere 10 million light-years distant in the long-necked, northern constellation Camelopardalis. A sprawling island universe, IC 342 would otherwise be a prominent galaxy in our night sky, but it is hidden from clear view and only glimpsed through the veil of stars, gas and dust clouds along the plane of our own Milky Way galaxy. Even though IC 342's light is dimmed by intervening cosmic clouds, this sharp telescopic image traces the galaxy's own obscuring dust, blue star clusters, and glowing pink star forming regions along spiral arms that wind far from the galaxy's core. IC 342 may have undergone a recent burst of star formation activity and is close enough to have gravitationally influenced the evolution of the local group of galaxies and the Milky Way.",
    title: "Hidden Galaxy IC 342",
    url: "https://apod.nasa.gov/apod/image/1707/ic342_rector1024s.jpg",
    imageBytes: const [],
  );

  final tImmersiveJSON = json.decode(fixture('apod_item.json'));

  test(
    'should be a subclass of Immersive entity',
    () async {
      expect(tImmersiveDto, isA<ImmersiveEntity>());
    },
  );
  test(
    'should return a valid model',
    () async {
      final result = ImmersiveDto.fromJson(tImmersiveJSON);
      expect(result, tImmersiveDto);
    },
  );
  test(
    'should return a JSON map',
    () async {
      final result = tImmersiveDto.toJson();
      expect(result, tImmersiveJSON);
    },
  );
}
