import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pick_up/app_widgets/custom_dot.dart';
import 'package:pick_up/features/client_home/data/view_model/cubit/home_cubit.dart';
import 'package:pick_up/routing/navigator.dart';
import 'package:pick_up/routing/routes.dart';
import 'package:pick_up/utilities/images.dart';
import 'package:pick_up/utilities/media_quary.dart';
import 'package:pick_up/utilities/text_style.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;
  PageController _controller = PageController();

  @override
  void initState() {
    _controller = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> cardContent = [
    {
      'title': 'توصيل أغراضك',
      'description': 'أوصل لك أي شيئ للمكان اللي تبيه',
      'icon': AppImages.homeCardIcon1
    },
    {
      'title': 'إستلام بضائعك',
      'description': 'أستلم عنك بضائعك واوصلها لحد بابك واركبها لك',
      'icon': AppImages.homeCardIcon2
    },
    {
      'title': 'نقل عفشك',
      'description': 'أنقل أغراضك مع الفك والتركيب في أي وقت',
      'icon': AppImages.homeCardIcon3
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text('الرئيسية'),
        titleTextStyle: TextStyleHelper.subtitle20.copyWith(
            color: Theme.of(context).colorScheme.primary, fontFamily: 'Cairo'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(24.0.r),
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(16.r),
                height: MediaQueryHelper.height * 0.2,
                width: MediaQueryHelper.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                    color: Colors.white),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      BlocBuilder<HomeCubit, HomeState>(
                        builder: (context, state) {
                          if (state is HomeLoading) {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                          if (state is HomeError) {
                            return const Center(child: Text('error'));
                          }
                          if (state is HomeLoaded) {
                            return SizedBox(
                              height: MediaQueryHelper.height * .2,
                              width: MediaQueryHelper.width,
                              child: FutureBuilder(
                                  future: Future.delayed(
                                      const Duration(seconds: 3), () {
                                    if (currentIndex ==
                                        cardContent.length - 1) {
                                      setState(() {
                                        currentIndex = 0;
                                      });
                                      Future.delayed(
                                          const Duration(seconds: 3),
                                          () => _controller
                                              .jumpToPage(currentIndex));
                                    }
                                    _controller.nextPage(
                                      duration: const Duration(seconds: 2),
                                      curve: Curves.ease,
                                    );
                                    Future.delayed(const Duration(seconds: 3),
                                        () {
                                      _controller.keepPage;
                                    });
                                  }),
                                  builder: (context, snapshot) {
                                    return PageView.builder(
                                      physics: const BouncingScrollPhysics(),
                                      itemCount: cardContent.length,
                                      onPageChanged: (int index) {
                                        setState(() {
                                          currentIndex = index;
                                        });
                                      },
                                      controller: _controller,
                                      itemBuilder: (context, index) =>
                                          Container(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(16.r),
                                            image: DecorationImage(
                                                image: NetworkImage(state
                                                    .imageSlider
                                                    .data![index]
                                                    .imageUrl!),
                                                fit: BoxFit.cover)
                                            //image: DecorationImage(image: )
                                            ),
                                      ),
                                    );
                                  }),
                            );
                          }
                          return const Text('null');
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          cardContent.length,
                          (index) => CustomDot(
                            currentIndex: currentIndex,
                            index: index,
                            color: currentIndex == index
                                ? Theme.of(context).colorScheme.primary
                                : Colors.grey,
                          ),
                        ),
                      ),
                    ]),
              ),
              SizedBox(
                height: MediaQueryHelper.height * .02,
              ),
              Text('خدمات بيك اب', style: TextStyleHelper.subtitle20),
              SizedBox(
                height: MediaQueryHelper.height * .02,
              ),
              Column(
                children: List.generate(
                  cardContent.length,
                  (index) => InkWell(
                    onTap: () {
                      AppRoutes.pushNamedNavigator(routeName: Routes.order);
                    },
                    child: Container(
                      width: MediaQueryHelper.width,
                      padding: EdgeInsets.only(bottom: 8.r),
                      margin: EdgeInsets.symmetric(
                        vertical: 8.r,
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.r),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color:
                                    Colors.grey.shade400 /* spreadRadius: 5 */,
                                blurRadius: 5)
                          ]),
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      cardContent[index]['title'],
                                      style: TextStyleHelper.subtitle20
                                          .copyWith(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .primary),
                                    ),
                                    Text(
                                      cardContent[index]['description'],
                                      style: TextStyleHelper.body16
                                          .copyWith(color: Colors.grey),
                                    )
                                  ]),
                            ),
                          ),
                          ClipRRect(borderRadius: BorderRadius.circular(16),
                            clipBehavior: Clip.hardEdge,
                              child:
                                  SvgPicture.asset(cardContent[index]['icon']))
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
