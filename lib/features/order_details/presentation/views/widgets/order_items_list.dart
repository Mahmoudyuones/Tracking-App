import 'package:flutter/material.dart';

import '../../../../../features/orders/domain/entities/order_item_entity.dart';
import 'order_item_tile.dart';

class OrderItemsList extends StatelessWidget {
  const OrderItemsList({super.key, required this.items});

  final List<OrderItemEntity> items;

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return const SliverToBoxAdapter(child: SizedBox.shrink());
    }

    final cardColor = Theme.of(context).cardColor;
    final radius = BorderRadius.circular(12);

    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      sliver: DecoratedSliver(
        decoration: BoxDecoration(color: cardColor, borderRadius: radius),
        sliver: SliverList.separated(
          itemCount: items.length,
          separatorBuilder: (context, index) =>
              const Divider(height: 1, thickness: 1, indent: 12, endIndent: 12),
          itemBuilder: (context, index) => OrderItemTile(item: items[index]),
        ),
      ),
    );
  }
}
