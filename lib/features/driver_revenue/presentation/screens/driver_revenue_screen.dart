import 'package:flutter/material.dart';
import 'package:pick_up/utilities/text_style.dart';

class DriverRevenueScreen extends StatelessWidget {
  const DriverRevenueScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text('الارباح',
            style: TextStyleHelper.subtitle19
                .copyWith(color: Theme.of(context).colorScheme.primary)),
        backgroundColor: Colors.transparent,
      ),
    );
  }
}
