import 'package:flutter/material.dart';
import 'package:rapidinho/ui/widget/delivery.dart';

class DeliveryTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 100.0),
      child: Center(
        child: Delivery(),
      ),
    );
  }
}