import 'package:flutter/material.dart';
import 'package:pick_up/utilities/media_quary.dart';

class OrderDataTypeCard extends StatefulWidget {
  final List<String> content;
  const OrderDataTypeCard({super.key, required this.content});

  @override
  State<OrderDataTypeCard> createState() => _OrderDataTypeCardState();
}

class _OrderDataTypeCardState extends State<OrderDataTypeCard> {
  int currentIndex = -1;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQueryHelper.height * .1,
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(
          vertical: 8,
        ),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 2.5,
          crossAxisSpacing: MediaQueryHelper.width * .05,
          mainAxisSpacing:
              MediaQueryHelper.height * .01, /*  mainAxisExtent: 500 */
        ),
        itemCount: widget.content.length,
        itemBuilder: (context, index) => InkWell(
          onTap: () {
            setState(() {
              currentIndex = index;
            });
          },
          child: Container(
            height: MediaQueryHelper.height * .1,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                  color: currentIndex == index ? Colors.green : Colors.grey,
                  width: 1.5),
              color: Colors.white,
            ),
            child: Row(
              children: [
                Text(widget.content[index]),
                const Spacer(),
                Icon(
                  Icons.check_circle,
                  color: currentIndex == index ? Colors.green : Colors.grey,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
