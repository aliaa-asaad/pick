import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pick_up/app_widgets/custom_button.dart';
import 'package:pick_up/features/order/presentation/widgets/car_card.dart';
import 'package:pick_up/features/order/presentation/widgets/floor.dart';
import 'package:pick_up/features/order/presentation/widgets/order_data_type_card.dart';
import 'package:pick_up/features/order/presentation/widgets/order_description.dart';
import 'package:pick_up/features/order/presentation/widgets/order_type.dart';
import 'package:pick_up/features/order/presentation/widgets/title_text.dart';

class OrderDataScreen extends StatelessWidget {
  final Function() onPressed;
  const OrderDataScreen({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(24.0.r),
        child: InkWell(onTap: (){FocusScope.of(context).unfocus();},
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TitleText(title: "حدد نوع الشاحنة"),
              const CarCard(),
              const TitleText(title: "حدد نوع الشحنة"),
              const OrderType(),
              const TitleText(title: "مواصفات شحنتك"),
              const OrderDescription(),
              const TitleText(title: 'خدمات التحميل والتنزيل'),
              const OrderDataTypeCard(content: [
                'مطلوبة',
                'غير مطلوبة',
              ]),
              const TitleText(title: 'حدد طابق الاستلام والتسليم'),
              const Floor(),
              const TitleText(title: "المصعد الكهربائي"),
              const OrderDataTypeCard(content: [
                'متوفر',
                'غير متوفر',
              ]),
              const TitleText(title: "عامل إضافي"),
              const OrderDataTypeCard(content: [
                'متوفر',
                'غير متوفر',
              ]),
              CustomButton(
                onPressed: onPressed,
                text: 'التالي',
                background: Theme.of(context).colorScheme.primary,
              )
            ],
          ),
        ),
      ),
    );
  }
}
