import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../../../core/style/color/app_colors.dart';
import '../../../../../core/utility/ui/ui_utils.dart';
import '../../../../../features/orders/domain/entities/order_wrapper_entity.dart';
import '../../view_model/product_details_cubit.dart';
import '../../view_model/product_details_events.dart';
import '../../view_model/product_details_ui_events.dart';
import '../widgets/order_details_app_bar.dart';
import '../widgets/order_details_body.dart';

class OrderDetailsScreen extends StatefulWidget {
  const OrderDetailsScreen({super.key, required this.order});

  final OrderWrapperEntity order;

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  late final ProductDetailsCubit _cubit;
  late final List<String> productIds;
  @override
  void initState() {
    super.initState();
    _cubit = GetIt.instance<ProductDetailsCubit>();

    productIds =
        widget.order.order?.orderItems
            ?.map((item) => item.product?.id ?? '')
            .where((id) => id.isNotEmpty)
            .toList() ??
        [];
    _cubit.onEvent(GetMultipleProductDetailsEvent(productIds: productIds));

    _cubit.uiEventStream.listen((event) {
      if (!mounted) return;
      switch (event) {
        case PartialSuccessUiEvent():
          const SizedBox.shrink();
        case ErrorUiEvent():
          _handleError(event.message);
        default:
          break;
      }
    });
  }

  void _handleError(String message) {
    UIUtils.hideLoading(context);
    UIUtils.showMessage(
      message,
      backGroundColor: AppColors.red,
      textColor: AppColors.white,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _cubit,
      child: Scaffold(
        appBar: const OrderDetailsAppBar(),
        body: OrderDetailsBody(order: widget.order, productIds: productIds),
      ),
    );
  }
}
