import 'dart:ui';

import 'package:flutter/material.dart';

import '../../../theme/doit_typos.dart';

class AnimalStatus {
  final String count;
  final String animalAssetPath;

  AnimalStatus({
    required this.count,
    required this.animalAssetPath,
  });
}

class AnimalStatusBarWidget extends StatelessWidget {
  const AnimalStatusBarWidget({
    required this.data,
    super.key,
  });

  final List<AnimalStatus> data;

  Widget _portraitAnimal() => Padding(
        padding: const EdgeInsets.fromLTRB(10, 18, 10, 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              '총 73마리',
              style:
                  DoitTypos.suitR16.copyWith(color: Colors.white, fontSize: 14),
            ),
            const SizedBox(
              height: 16,
            ),
            ...List<Widget>.generate(
              data.length,
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
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            data[index].count,
                            style: data[index].count.length > 2
                                ? DoitTypos.suitSB12.copyWith(
                                    color: Colors.black,
                                  )
                                : DoitTypos.suitSB16.copyWith(
                                    color: Colors.black,
                                  ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(
                          width: 32,
                          height: 32,
                          child: Image.asset(data[index].animalAssetPath),
                        ),
                      ],
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

  Widget _landscapeAnimal() => Padding(
        padding: const EdgeInsets.fromLTRB(24, 10, 16, 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  '총 74마리',
                  style: DoitTypos.suitR16.copyWith(color: Colors.white),
                ),
              ],
            ),
            const SizedBox(
              width: 24,
            ),
            ...List<Widget>.generate(
              data.length,
              (int index) => Row(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8)),
                    width: 32,
                    height: 64,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8.0)),
                          border: Border.all(
                            color: Colors.white,
                          )),
                      child: Stack(
                        children: <Widget>[
                          Positioned(
                            top: 0,
                            left: 0,
                            right: 0,
                            child: Text(
                              data[index].count,
                              style: DoitTypos.suitSB16.copyWith(
                                color: Colors.black,
                                height: 1.6,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
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

  @override
  Widget build(BuildContext context) {
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
            child: isLandscape ? _landscapeAnimal() : _portraitAnimal(),
          ),
        ),
      ),
    );
  }
}
