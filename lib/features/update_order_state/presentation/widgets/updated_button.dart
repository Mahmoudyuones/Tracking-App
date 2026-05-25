import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_text_string.dart';
import '../../../../core/style/color/app_colors.dart';
import '../cubit/update_order_state_cubit.dart';
import '../cubit/update_order_state_intents.dart';
import '../cubit/update_order_state_state.dart';

class UpdatedButton extends StatelessWidget {
  const UpdatedButton({super.key, required this.userId, required this.orderId});
  final String userId;
  final String orderId;

  List<String> getTitles() {
    return [
      AppTextString.arrivedAtPickupPoint,
      AppTextString.startDeliver,
      AppTextString.arrivedToUser,
      AppTextString.deliveredToTheUser,
      AppTextString.deliveredToTheUser,
    ];
  }

  List<String> getStates() {
    return [
      AppTextString.picked,
      AppTextString.outForDelivery,
      AppTextString.arrived,
      AppTextString.delivered,
    ];
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return BlocBuilder<UpdateOrderStateCubit, UpdateOrderStateState>(
      builder: (context, state) {
        return SizedBox(
          width: double.infinity,
          height: 52,
          child: ElevatedButton(
            onPressed: state.currentStep == 4
                ? null
                : state.currentStep == 0 || state.currentStep == 3
                ? () {
                    context.read<UpdateOrderStateCubit>().doIntent(
                      ChangeOrderStatusIntent(
                        userId: userId,
                        orderId: orderId,
                        state: getStates()[state.currentStep],
                      ),
                    );
                  }
                : () {
                    context.read<UpdateOrderStateCubit>().doIntent(
                      UpdateOnlyFirestoreIntent(
                        userId: userId,
                        orderId: orderId,
                        newState: getStates()[state.currentStep],
                      ),
                    );
                  },
            child: state.loadingUpdate
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: AppColors.white,
                    ),
                  )
                : Text(
                    getTitles()[state.currentStep],
                    style: textTheme.bodyMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
          ),
        );
      },
    );
  }
}
