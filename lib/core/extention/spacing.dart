import 'package:flutter/material.dart';

extension Spacing on num {
  Widget get verticalSpacing => SizedBox(height: toDouble());

  Widget get horizontalSpacing => SizedBox(width: toDouble());
}
