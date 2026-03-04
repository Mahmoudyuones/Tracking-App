import '../../domain/entities/request/apply_request_entity.dart';

sealed class ApplyIntents {}

class SubmitApplyIntent extends ApplyIntents {
  final ApplyRequestEntity request;
  SubmitApplyIntent({required this.request});
}
