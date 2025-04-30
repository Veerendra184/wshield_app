import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _currentIndex = 0;

  final List<Map<String, String>> slides = [
    {
      'image': 'lib/assets/bodyguard_detail.png',
      'desc': 'Bodyguard Service - Ever felt unsafe walking alone at night in the city? Just pre-book a trained WSHIELD bodyguard from our app. Dont want them beside you? No problem — they can monitor you from a distance. Stay safe without feeling watched.',
    },
    {
      'image': 'lib/assets/drone_detail.png',
      'desc': " Drone Surveillance - What if no one can reach you in time? Our drone follows you silently, capturing live footage from above. If danger is sensed, Drone Will be Reacting to it. Aerial eyes when your'e truly alone.",
    },
    {
      'image': 'lib/assets/bag_detail.png',
      'desc': 'Smart Safety Bag - Who helps you when no one’s around — and no proof exists? Our bag includes a 360° camera + hidden panic button.One press alerts nearby WSHIELD volunteers.It captures real-time footage — useful for social proof and legal steps.',
    },
  ];

  void _goToNext() {
    setState(() {
      _currentIndex = (_currentIndex + 1) % slides.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentSlide = slides[_currentIndex];
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          const SizedBox(height: 40),
          const Text(
            'Choose Your Shield',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 20),

          // Image
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: SizedBox(
                height: screenHeight * 0.5,
                width: double.infinity,
                child: Image.asset(
                  currentSlide['image']!,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

          // Description + Slide Indicator + Button
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(20),
              width: double.infinity,
              child: Column(
                children: [
                  const SizedBox(height: 20),

                  // Description
                  Text(
                    currentSlide['desc']!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                      fontFamily: 'RobotoThin',
                      height: 1.6,
                    ),
                  ),

                  const SizedBox(height: 30),

                  // 🔘 Slide Indicator Dashes
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(slides.length, (index) {
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.symmetric(horizontal: 6),
                        height: 4,
                        width: _currentIndex == index ? 40 : 20,
                        decoration: BoxDecoration(
                          color: _currentIndex == index ? Colors.white : Colors.white38,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      );
                    }),
                  ),

                  const SizedBox(height: 30),

                  // ✅ NEXT Button
                  ElevatedButton(
                    onPressed: _goToNext,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                    ),
                    child: const Text("Next"),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
