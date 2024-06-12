import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class OnboardingCarousel extends StatefulWidget {
  final VoidCallback onFinish;

  const OnboardingCarousel({required this.onFinish, Key? key}) : super(key: key);

  @override
  _OnboardingCarouselState createState() => _OnboardingCarouselState();
}

class _OnboardingCarouselState extends State<OnboardingCarousel> {
  final CarouselController _controller = CarouselController();
  int _current = 0;

  final List<Widget> _slides = [
    _buildSlide('assets/images/slide1.png', 'Discover your dream car.'),
    _buildSlide('assets/images/slide2.png', 'Enjoy a safe and guaranteed rental process.'),
    _buildSlide('assets/images/slide3.png', 'Get the best support from our customer service team.'),
  ];

  static Widget _buildSlide(String imagePath, String text) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(imagePath, height: 200),
        const SizedBox(height: 20),
        Text(
          text,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    // Automatically move to the next slide
    Future.delayed(Duration(seconds: 3), _autoSlide);
  }

  void _autoSlide() {
    if (_current < _slides.length - 1) {
      _controller.nextPage();
    } else {
      widget.onFinish();
    }
    Future.delayed(Duration(seconds: 3), _autoSlide);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CarouselSlider(
                items: _slides,
                carouselController: _controller,
                options: CarouselOptions(
                  height: 400,
                  autoPlay: false,
                  enlargeCenterPage: true,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _current = index;
                    });
                  },
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _slides.asMap().entries.map((entry) {
                return GestureDetector(
                  onTap: () => _controller.animateToPage(entry.key),
                  child: Container(
                    width: 12.0,
                    height: 12.0,
                    margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: (Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black)
                          .withOpacity(_current == entry.key ? 0.9 : 0.4),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          Positioned(
            bottom: 30,
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (_current == 0)
                  Container(),
                if (_current > 0)
                  TextButton(
                    onPressed: () => _controller.previousPage(),
                    child: Text('Kembali'),
                  ),
                if (_current < _slides.length - 1)
                  TextButton(
                    onPressed: () => _controller.nextPage(),
                    child: Text('Selanjutnya'),
                  ),
                if (_current == _slides.length - 1)
                  TextButton(
                    onPressed: widget.onFinish,
                    child: Text('Gas!'),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
