// import 'package:carousel_slider/carousel_slider.dart';
import 'package:coresight/shared/theme.dart';
import 'package:coresight/ui/widgets/button.dart';
import 'package:coresight/utils/status_bar.dart';
import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage>
    with SingleTickerProviderStateMixin {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  late AnimationController _animController;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    setStatusBar(
      color: Colors.transparent,
      iconBrightness: Brightness.light,
      barBrightness: Brightness.dark,
    );

    _animController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );

    _slideAnimation = Tween<Offset>(
      begin: Offset(0, 0.1),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _animController, curve: Curves.easeOut));

    _fadeAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _animController, curve: Curves.easeIn));

    _animController.forward();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _animController.dispose();
    super.dispose();
  }

  final List<String> _images = [
    'assets/images/OB1.png',
    'assets/images/OB2.jpg',
    'assets/images/OB3.jpg',
  ];
  List<String> titles = [
    'See Your Business Clearly',
    'Insights That Drive Action',
    'Stronger Teams Better Results',
  ];
  List<String> subtitles = [
    'Giving you clarity at the very core of your business',
    'Helps you make confident decisions\n faster than ever before',
    'Give your people the tools to succeed\n all from one trusted platform',
  ];

  void _nextPage() {
    if (_currentPage < _images.length - 1) {
      _pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _completeOnboarding();
    }
  }

  void _skip() {
    _pageController.jumpToPage(_images.length - 1);
  }

  Future<void> _completeOnboarding() async {
    Navigator.pushNamedAndRemoveUntil(context, '/signin', (route) => false);
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
    _animController.reset();
    _animController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: _images.length,
            onPageChanged: _onPageChanged,
            itemBuilder: (context, index) {
              return Stack(
                children: [
                  // Background image
                  Image.asset(
                    _images[index],
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  ),

                  // Fade + Slide animated overlay
                  Positioned.fill(
                    child: Container(
                      color: Colors.black.withValues(alpha: (0.4)),
                      child: Stack(
                        children: [
                          Positioned(
                            bottom: 160,
                            left: 0,
                            right: 0,
                            child: SlideTransition(
                              position: _slideAnimation,
                              child: FadeTransition(
                                opacity: _fadeAnimation,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 24,
                                  ),
                                  child: Column(
                                    children: [
                                      Text(
                                        titles[index],
                                        style: whiteTextStyle.copyWith(
                                          fontSize: h2,
                                          fontWeight: bold,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                      Text(
                                        subtitles[index],
                                        style: whiteTextStyle,
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),

          // Skip button (only hidden on last page)
          if (_currentPage < _images.length - 1)
            Positioned(
              top: 50,
              right: 0,
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width - 40,
                ),
                child: ButtonText(
                  onPressed: _skip,
                  width: 50,
                  text: 'Skip',
                  styleText: whiteTextStyle.copyWith(fontSize: h5),
                ),
              ),
            ),

          // Next / Get Started button with fade
          Positioned(
            bottom: 80,
            left: 24,
            right: 24,
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: Button(
                onPressed: _nextPage,
                bgColor: primaryColor,
                styleText: whiteTextStyle.copyWith(
                  fontWeight: semiBold,
                  fontSize: h4,
                ),
                text: _currentPage == _images.length - 1
                    ? "Get Started"
                    : "Next",
              ),
            ),
          ),

          // Dots indicator
          Positioned(
            bottom: 50,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _images.length,
                (index) => AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  margin: EdgeInsets.symmetric(horizontal: 6),
                  width: _currentPage == index ? 12 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: _currentPage == index ? blueColor : greyColor,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
