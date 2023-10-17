import 'package:flutter/material.dart';

class OrderDescription extends StatelessWidget {
  const OrderDescription({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
              padding: const EdgeInsets.symmetric(vertical:8.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'وصف لشحنتك. مثال عدد 4 كراسى او جهاز تليفزيون',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            )
            ;
  }
}