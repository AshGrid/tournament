import 'package:flutter/material.dart';
import 'package:untitled/components/colors.dart';

class ImageSlider extends StatefulWidget {
  final List<String> imagePaths;

  const ImageSlider({
    Key? key,
    required this.imagePaths,
  }) : super(key: key);

  @override
  _ImageSliderState createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {
  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _pageController.addListener(() {
      final page = _pageController.page?.round() ?? 0;
      if (page != _currentPage) {
        setState(() {
          _currentPage = page;
        });
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.of(context).size.width > 600;
    final sliderHeight = 200.0;
    // isTablet
    //     ? MediaQuery.of(context).size.height * 0.4
    //     : MediaQuery.of(context).size.height * 0.225;

    return Stack(
      children: [
        // Slider Container
        SizedBox(
          height: sliderHeight,
          child: PageView(
            controller: _pageController,
            scrollDirection: Axis.horizontal,
            children: widget.imagePaths.map((path) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 8.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  image: DecorationImage(
                    image: NetworkImage(path),
                    fit: BoxFit.cover,
                  ),
                ),
              );
            }).toList(),
          ),
        ),

        // Page Indicator Dots
        Positioned(
          bottom: 10,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              widget.imagePaths.length,
                  (index) => AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.symmetric(horizontal: 4.0),
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _currentPage == index
                      ? AppColors.leagueTitleComponent
                      : Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
