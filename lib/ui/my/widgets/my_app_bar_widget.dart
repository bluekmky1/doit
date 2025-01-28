import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';
import '../../../core/loading_status.dart';
import '../../../routes/routes.dart';
import '../../../theme/doit_color_theme.dart';
import '../../../theme/doit_typos.dart';
import '../../../util/date_time_format_helper.dart';
import '../../common/consts/assets.dart';
import '../../common/widgets/text_chip_widget.dart';
import '../my_state.dart';
import '../my_view_model.dart';

class MyAppBarWidget extends ConsumerWidget {
  const MyAppBarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final DoitColorTheme doitColorTheme =
        Theme.of(context).extension<DoitColorTheme>()!;

    final MyState state = ref.watch(myViewModelProvider);
    final MyViewModel viewModel = ref.read(myViewModelProvider.notifier);

    if (state.getUserDataLoadingStatus == LoadingStatus.loading) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(0, 52, 0, 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Shimmer.fromColors(
              baseColor: doitColorTheme.gray10,
              highlightColor: doitColorTheme.gray20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: 100,
                    height: 24,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: <Widget>[
                      Container(
                        width: 60,
                        height: 20,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        width: 80,
                        height: 20,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        width: 70,
                        height: 20,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 52, 0, 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              const SizedBox(width: 4),
              Text(
                state.userName,
                style: DoitTypos.suitSB20.copyWith(
                  color: doitColorTheme.main,
                ),
              ),
              const Spacer(),
              PopupMenuButton<String>(
                color: doitColorTheme.background,
                elevation: 0.3,
                shadowColor: doitColorTheme.shadow1,
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                child: SvgPicture.asset(
                  Assets.dropDown,
                  colorFilter: ColorFilter.mode(
                    doitColorTheme.gray80,
                    BlendMode.srcIn,
                  ),
                ),
                itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                  PopupMenuItem<String>(
                    padding: EdgeInsets.zero,
                    onTap: () {
                      context.goNamed(Routes.profile.name);
                    },
                    value: 'edit',
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SvgPicture.asset(
                          Assets.edit,
                          width: 20,
                          height: 20,
                          colorFilter: ColorFilter.mode(
                            doitColorTheme.gray80,
                            BlendMode.srcIn,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '프로필 수정',
                          style: DoitTypos.suitR12.copyWith(
                            color: doitColorTheme.gray80,
                          ),
                        ),
                      ],
                    ),
                  ),
                  PopupMenuItem<String>(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    onTap: () async {
                      await viewModel.signOut();

                      if (context.mounted) {
                        context.goNamed(Routes.signIn.name);
                      }
                    },
                    value: 'logout',
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SvgPicture.asset(
                          width: 20,
                          height: 20,
                          Assets.logout,
                          colorFilter: ColorFilter.mode(
                            doitColorTheme.error,
                            BlendMode.srcIn,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '로그아웃',
                          style: DoitTypos.suitR12.copyWith(
                            color: doitColorTheme.error,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
                onSelected: (String value) {},
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: <Widget>[
              Wrap(
                spacing: 8,
                children: <Widget>[
                  TextChipWidget(
                    title: state.lunarSolar,
                    padding: const EdgeInsetsDirectional.symmetric(
                      horizontal: 8,
                      vertical: 2,
                    ),
                  ),
                  TextChipWidget(
                    title: DateTimeFormatter.getFullDate(
                      state.birthDate,
                    ),
                    padding: const EdgeInsetsDirectional.symmetric(
                      horizontal: 8,
                      vertical: 2,
                    ),
                  ),
                  TextChipWidget(
                    title: state.unknownBirthTime
                        ? '태어난 시간 모름'
                        : DateTimeFormatter.getSimpleTimeString(
                            state.birthDate,
                          ),
                    padding: const EdgeInsetsDirectional.symmetric(
                      horizontal: 8,
                      vertical: 2,
                    ),
                  ),
                  TextChipWidget(
                    title: state.gender,
                    padding: const EdgeInsetsDirectional.symmetric(
                      horizontal: 8,
                      vertical: 2,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
