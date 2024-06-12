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
    _buildSlide("assets/img/img-onBoardingLogo.png", "Wilujeng Sumping", "Gaskeun adalah aplikasi yang memudahkan Anda menyewa mobil di Bandung yang sesuai dengan kebutuhan Anda."),
    _buildSlide("assets/img/img-onBoardingKey.png", "Temukan Mobil Impian", "Nikmati proses sewa yang aman dan terjamin, temukan pilihan mobil sesuai, dan dapatkan dukungan terbaik dari kami."),
    _buildSlide("assets/img/img-onBoardingCar.png", "Mulai Kelilingi Bandung", "Solusi sewa mobil terbaik untuk kebutuhan Anda dan nikmati kemudahan sewa mobil dengan pelayanan terbaik dari kami."),
  ];

  static Widget _buildSlide(String imagePath, String heading, String description) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(imagePath, height: 200),
          const SizedBox(height: 10),
          Text(
            heading,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          Text(
            description,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    // Automatically move to the next slide
    Future.delayed(Duration(seconds: 15), _autoSlide);
  }

  void _autoSlide() {
    if (_current < _slides.length - 1) {
      _controller.nextPage();
    } else {
      widget.onFinish();
    }
    Future.delayed(Duration(seconds: 15), _autoSlide);
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
                  enlargeCenterPage: false,  // Disable enlarging center page
                  viewportFraction: 1.0,    // Ensure each slide takes up the full viewport
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
