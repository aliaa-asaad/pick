/* import 'package:flutter/material.dart';
import 'package:pick_up/features/my_order/presentation/widgets/custom_tab_bar.dart';
import 'package:pick_up/features/my_order/presentation/widgets/tab_bar_body.dart';

class MyTab extends StatefulWidget {
  const MyTab({super.key});

  @override
  State<MyTab> createState() => _MyTabState();
}

class _MyTabState extends State<MyTab> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            MyTabBar(
              tabController: _tabController,
              viewsBody: const [TabBarBody(), TabBarBody(),TabBarBody()],
              viewsTitle: const [
                Tab(
                  text: 'طلباتة جديدة',
                ),
                Tab(
                  text: 'قيد الانتظار',
                ),
                 Tab(
                  text: 'طللبات منتهية',
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
 */
