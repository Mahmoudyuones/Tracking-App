import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../../config/di/di.dart';
import '../../../../../core/constants/app_text_string.dart';
import '../../../../../core/gen/assets.gen.dart';
import '../../../../../core/utility/ui/ui_utils.dart';
import '../cubit/home_intents.dart';
import '../cubit/home_tab_cubit.dart';
import '../cubit/home_tab_side_effects.dart';
import '../cubit/home_tab_state.dart';
import '../widgets/errors_happen_widget.dart';
import '../widgets/order_card_widget.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  late final HomeTabCubit _homeTabCubit;

  @override
  void initState() {
    super.initState();
    _homeTabCubit = getIt<HomeTabCubit>();
    _homeTabCubit.sideEffects.listen((event) {
      if (mounted) {
        switch (event) {
          case LoadingPendingOrdersSideEffect():
            UIUtils.showEasyLoading();
          case HideLoadingSideEffect():
            UIUtils.hideLoading(context);
        }
      }
    });
    _homeTabCubit.doIntent(const GetPendingOrdersIntent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _homeTabCubit,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SvgPicture.asset(Assets.icons.homeAppBarLeading.path),
              BlocBuilder<HomeTabCubit, HomeTabState>(
                builder: (context, state) {
                  if (state.getPendingOrdersState?.errorMessage != null ||
                      state.getPendingOrdersState?.isEmpty == true) {
                    return Expanded(
                      child: ErrorsOrEmptyHappenWidget(
                        text:
                            state.getPendingOrdersState?.errorMessage ??
                            AppTextString.noOrdersFound,
                        lottie:
                            state.getPendingOrdersState?.errorMessage != null
                            ? Assets.lotties.error.path
                            : Assets.lotties.empty.path,
                      ),
                    );
                  } else if (state.getPendingOrdersState?.data?.isNotEmpty ==
                      true) {
                    final orders = state.getPendingOrdersState!.data!;
                    return Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 24),
                        child: ListView.builder(
                          itemCount: orders.length,
                          itemBuilder: (context, index) {
                            return OrderCardWidget(order: orders[index]);
                          },
                        ),
                      ),
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
