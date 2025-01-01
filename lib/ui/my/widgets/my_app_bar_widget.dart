import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../routes/routes.dart';
import '../../../theme/doit_color_theme.dart';
import '../../../theme/doit_typos.dart';
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

    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 52, 0, 18),
      child: Row(
        children: <Widget>[
          Text(
            '마재훈',
            style: DoitTypos.suitSB20.copyWith(
              color: doitColorTheme.main,
            ),
          ),
          const SizedBox(width: 16),
          const Wrap(
            spacing: 8,
            children: <Widget>[
              TextChipWidget(
                title: '2000.05.23',
                padding: EdgeInsetsDirectional.symmetric(
                  horizontal: 8,
                  vertical: 2,
                ),
              ),
              TextChipWidget(
                title: '09:30 생',
                padding: EdgeInsetsDirectional.symmetric(
                  horizontal: 8,
                  vertical: 2,
                ),
              ),
              TextChipWidget(
                title: '남성',
                padding: EdgeInsetsDirectional.symmetric(
                  horizontal: 8,
                  vertical: 2,
                ),
              ),
            ],
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
                      colorFilter: ColorFilter.mode(
                        doitColorTheme.gray80,
                        BlendMode.srcIn,
                      ),
                    ),
                  ],
                ),
              ),
              PopupMenuItem<String>(
                padding: EdgeInsets.zero,
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
                      width: 24,
                      height: 24,
                      Assets.logout,
                      colorFilter: ColorFilter.mode(
                        doitColorTheme.gray80,
                        BlendMode.srcIn,
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
    );
  }
}
