import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../theme/doit_typos.dart';
import '../../common/consts/animal_type.dart';
import '../farm_state.dart';
import '../farm_view_model.dart';

class AnimalStatusBarWidget extends ConsumerWidget {
  const AnimalStatusBarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return Center(
      child: ClipRRect(
        clipBehavior: Clip.hardEdge,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
          child: DecoratedBox(
            decoration: BoxDecoration(
              boxShadow: <BoxShadow>[
                BoxShadow(
                  blurRadius: 15,
                  color: const Color(0xFF2F56A5).withOpacity(0.15),
                )
              ],
              borderRadius: BorderRadius.circular(8),
              color: Colors.white.withOpacity(0.1),
            ),
            child:
                isLandscape ? const LandscapeAnimal() : const PortraitAnimal(),
          ),
        ),
      ),
    );
  }
}

class LandscapeAnimal extends ConsumerWidget {
  const LandscapeAnimal({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final FarmState state = ref.watch(farmViewModelProvider);

    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 10, 16, 10),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                '총 ${state.animalCount}마리',
                style: DoitTypos.suitR16.copyWith(color: Colors.white),
              ),
            ],
          ),
          const SizedBox(
            width: 24,
          ),
          ...List<Widget>.generate(
            state.animalList.length,
            (int index) => Row(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8)),
                  width: 32,
                  height: 64,
                  clipBehavior: Clip.hardEdge,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8.0)),
                        border: Border.all(
                          color: Colors.white,
                        )),
                    child: LayoutBuilder(
                        builder: (BuildContext context,
                                BoxConstraints constraints) =>
                            Stack(
                              children: <Widget>[
                                Positioned(
                                  top: 0,
                                  left: 0,
                                  right: 0,
                                  child: Text(
                                    state.animalList[index].count.toString(),
                                    style: DoitTypos.suitSB16.copyWith(
                                      color: Colors.black,
                                      height: 1.6,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: SizedBox(
                                    width: constraints.maxWidth * 0.8,
                                    child: Image.asset(
                                      AnimalType.fromString(
                                              state.animalList[index].name)
                                          .verticalMarkPath,
                                    ),
                                  ),
                                ),
                              ],
                            )),
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class PortraitAnimal extends ConsumerWidget {
  const PortraitAnimal({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final FarmState state = ref.watch(farmViewModelProvider);
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 18, 10, 12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            '총 ${state.animalCount}마리',
            style:
                DoitTypos.suitR16.copyWith(color: Colors.white, fontSize: 14),
          ),
          const SizedBox(
            height: 16,
          ),
          ...List<Widget>.generate(
            state.animalList.length,
            (int index) => Column(
              children: <Widget>[
                Container(
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  width: 64,
                  height: 32,
                  child: LayoutBuilder(
                    builder:
                        (BuildContext context, BoxConstraints constraints) =>
                            Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        Positioned(
                          left:
                              state.animalList[index].count.toString().length >
                                      3
                                  ? 4
                                  : 12,
                          child: Text(state.animalList[index].count.toString(),
                              style: state.animalList[index].count
                                          .toString()
                                          .length >
                                      3
                                  ? DoitTypos.suitSB12
                                  : DoitTypos.suitSB16),
                        ),
                        Positioned(
                          left: 32,
                          child: SizedBox(
                            height: constraints.maxHeight * 1.0,
                            child: Image.asset(
                              AnimalType.fromString(
                                      state.animalList[index].name)
                                  .horizontalMarkPath,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
