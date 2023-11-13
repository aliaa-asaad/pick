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
  int currentImage = 0;
  final PageController _pageController =
      PageController(initialPage: 0, viewportFraction: 1);

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        currentImage = _pageController.page!.round();
      });
    });
    Future.delayed(const Duration(seconds: 2), () {
      _animateSlider();
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _animateSlider();
    super.dispose();
  }

  void _animateSlider() {
    if (currentImage < HomeCubit.instance.imageSlider.length - 1) {
      currentImage++;
    } else {
      currentImage = 0;
    }
    if (mounted) {
      _pageController.animateToPage(
        currentImage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.ease,
      );
    }

    Future.delayed(const Duration(seconds: 2), () {
      _animateSlider();
    });
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
        titleTextStyle: TextStyleHelper.subtitle19.copyWith(
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
                // padding: EdgeInsets.all(8.r),
                height: MediaQueryHelper.height * 0.22,
                width: MediaQueryHelper.width,
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.circular(8.r), /* color: Colors.white */
                ),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      BlocBuilder<HomeCubit, HomeState>(
                        builder: (context, state) {
                          if (state is HomeLoading) {
                            return Padding(
                              padding: EdgeInsets.all(8.0.r),
                              child: const Center(
                                  child: CircularProgressIndicator()),
                            );
                          }
                          if (state is HomeError) {
                            return const Center(child: Text('error'));
                          }
                          if (state is HomeLoaded) {
                            return SizedBox(
                              height: MediaQueryHelper.height * .2,
                              width: MediaQueryHelper.width,
                              child: PageView.builder(
                                controller: _pageController,
                                itemCount:
                                    HomeCubit.instance.imageSlider.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return AnimatedBuilder(
                                    animation: _pageController,
                                    builder:
                                        (BuildContext context, Widget? widget) {
                                      double value = 1.0;
                                      if (_pageController
                                          .position.haveDimensions) {
                                        value = _pageController.page! - index;
                                        value = (1 - (value.abs() * 0.1))
                                            .clamp(0.0, 2.0);
                                      }
                                      return Center(
                                        child: SizedBox(
                                          height:
                                              Curves.easeOut.transform(value) *
                                                  MediaQueryHelper.height*.15,
                                          width:
                                              Curves.easeOut.transform(value) *
                                                  MediaQueryHelper.width,
                                          child: Container(
                                            padding: const EdgeInsets.all(
                                                0), // Remove padding around the image
                                            child: widget,
                                          ),
                                        ),
                                      );
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 3.0.r),
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(16.r),
                                        child: Image.network(
                                          HomeCubit.instance.imageSlider[index]
                                              .imageUrl!,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                          }
                          return const Text('null');
                        },
                      ),
                      SizedBox(
                        height: MediaQueryHelper.height * .01,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          cardContent.length,
                          (index) => CustomDot(
                            currentIndex: currentImage,
                            index: index,
                            color: currentImage == index
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
              Text('خدمات بيك اب', style: TextStyleHelper.subtitle19),
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
                                    Colors.grey.shade300 /* spreadRadius: 5 */,
                                blurRadius: 5.r)
                          ]),
                      child: Row(crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.all(8.0.r),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      cardContent[index]['title'],
                                      style: TextStyleHelper.subtitle19
                                          .copyWith(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .primary),
                                    ),
                                    Text(
                                      cardContent[index]['description'],
                                      style: TextStyleHelper.body15
                                          .copyWith(color: Colors.grey),
                                    )
                                  ]),
                            ),
                          ),
                          ClipRRect(
                              borderRadius: BorderRadius.circular(16.r),
                              clipBehavior: Clip.hardEdge,
                              child: SvgPicture.asset(
                                cardContent[index]['icon'],
                                height: MediaQueryHelper.height * .1,
                              ))
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
