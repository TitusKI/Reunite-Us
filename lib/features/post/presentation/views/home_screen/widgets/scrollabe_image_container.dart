import 'package:afalagi/core/constants/constant.dart';
import 'package:flutter/material.dart';

class ScrollableImageContainer extends StatefulWidget {
  final List<String> images;

  const ScrollableImageContainer({super.key, required this.images});

  @override
  State<ScrollableImageContainer> createState() =>
      _ScrollableImageContainerState();
}

class _ScrollableImageContainerState extends State<ScrollableImageContainer> {
  int _currentPageIndex = 0;
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPageIndex = _pageController.page!.round();
      });
    });

    // Auto-scroll images every 3 seconds
    Future.delayed(const Duration(seconds: 3), _autoScroll);
  }

  void _autoScroll() {
    if (_pageController.hasClients) {
      int nextPage = _currentPageIndex + 1 < widget.images.length
          ? _currentPageIndex + 1
          : 0;
      _pageController.animateToPage(
        nextPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
      Future.delayed(const Duration(seconds: 3), _autoScroll);
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const postPictureUrl = '${AppConstant.UPLOAD_BASE_URL}/post/';

    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          height: 280,
          child: PageView.builder(
            controller: _pageController,
            itemCount: widget.images.length,
            itemBuilder: (context, index) {
              return Stack(
                fit: StackFit.expand,
                children: [
                  // Image with fade effect
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
                    child: Container(
                      key: ValueKey(widget.images[index]),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                              "$postPictureUrl${widget.images[index]}"),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                  // Gradient overlay for readability
                  Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          // Colors.black.withOpacity(0.3),
                          Colors.transparent,
                          // Colors.black.withOpacity(0.3),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
        // Dot indicators for navigation
        if (widget.images.length > 1)
          Positioned(
            bottom: 10,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                widget.images.length,
                (index) => AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: index == _currentPageIndex ? 12 : 8,
                  height: index == _currentPageIndex ? 12 : 8,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color:
                        index == _currentPageIndex ? Colors.blue : Colors.grey,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
