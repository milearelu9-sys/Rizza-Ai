import 'package:flutter/material.dart';
import 'input_screen.dart';
import 'history_screen.dart';
import '../widgets/action_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Header with History Button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(width: 48),
                  ShaderMask(
                    shaderCallback: (bounds) => LinearGradient(
                      colors: [const Color(0xFFFF006E), const Color(0xFF00D4FF)],
                    ).createShader(bounds),
                    child: const Text(
                      'RizzAI',
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 2,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.history),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HistoryScreen(),
                        ),
                      );
                    },
                  ),
                ],
              ),
              Text(
                'Your AI Text Assistant for Fun',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Colors.grey[400],
                  fontSize: 14,
                ),
              ),
              // Main Buttons
              Column(
                children: [
                  ActionButton(
                    label: 'Roast Me',
                    icon: '🔥',
                    colors: const [Color(0xFFFF006E), Color(0xFFC2002F)],
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const InputScreen(mode: 'roast'),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  ActionButton(
                    label: 'Rizz Boost',
                    icon: '💘',
                    colors: const [Color(0xFFFF006E), Color(0xFF8338EC)],
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const InputScreen(mode: 'rizz'),
                        ),
                      );
                    },
                  ),
                ],
              ),
              // Footer
              Text(
                'Made with ✨ by RizzAI',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
