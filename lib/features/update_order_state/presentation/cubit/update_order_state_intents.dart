sealed class UpdateOrderStateIntents {
  const UpdateOrderStateIntents();
}

class GetOrderByOrderIdIntent extends UpdateOrderStateIntents {
  final String userId;
  final String orderId;

  const GetOrderByOrderIdIntent({required this.userId, required this.orderId});
}

class ChangeOrderStatusIntent extends UpdateOrderStateIntents {
  final String orderId;
  final String state;
  final String userId;

  const ChangeOrderStatusIntent({
    required this.orderId,
    required this.state,
    required this.userId,
  });
}

class UpdateOnlyFirestoreIntent extends UpdateOrderStateIntents {
  final String orderId;
  final String newState;
  final String userId;

  const UpdateOnlyFirestoreIntent({
    required this.orderId,
    required this.newState,
    required this.userId,
  });
}

class UpdateDriverLocationIntent extends UpdateOrderStateIntents {
  final double latitude;
  final double longitude;
  final String orderId;
  final String userId;

  const UpdateDriverLocationIntent({
    required this.latitude,
    required this.longitude,
    required this.orderId,
    required this.userId,
  });
}

class StartDriverSimulationIntent extends UpdateOrderStateIntents {
  final double storeLatitude;
  final double storeLongitude;
  final String orderId;
  final String userId;
  final double startLatitude;
  final double startLongitude;

  const StartDriverSimulationIntent({
    required this.storeLatitude,
    required this.storeLongitude,
    required this.orderId,
    required this.userId,
    required this.startLatitude,
    required this.startLongitude,
  });
}
