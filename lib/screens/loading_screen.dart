import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'result_screen.dart';
import '../services/ai_service.dart';

class LoadingScreen extends StatefulWidget {
  final String inputText;
  final String mode;

  const LoadingScreen({
    Key? key,
    required this.inputText,
    required this.mode,
  }) : super(key: key);

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  late Future<Map<String, String>> _responsesFuture;

  @override
  void initState() {
    super.initState();
    _responsesFuture = _generateResponses();
  }

  Future<Map<String, String>> _generateResponses() async {
    await Future.delayed(const Duration(seconds: 2));
    return AIService.generateAIResponse(widget.inputText, widget.mode);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: FutureBuilder(
          future: _responsesFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SpinKitFadingCircle(
                      color: widget.mode == 'roast'
                          ? const Color(0xFFFF006E)
                          : const Color(0xFF8338EC),
                      size: 50.0,
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'AI is thinking…',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Colors.grey[300],
                      ),
                    ),
                  ],
                ),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Oops! Something went wrong',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Go Back'),
                    ),
                  ],
                ),
              );
            } else if (snapshot.hasData) {
              return ResultScreen(
                roastResponse: snapshot.data!['roast'] ?? '',
                rizzResponse: snapshot.data!['rizz'] ?? '',
                inputText: widget.inputText,
                mode: widget.mode,
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
