import 'package:flutter/material.dart';
import 'loading_screen.dart';
import '../widgets/custom_text_field.dart';

class InputScreen extends StatefulWidget {
  final String mode;

  const InputScreen({Key? key, required this.mode}) : super(key: key);

  @override
  State<InputScreen> createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  final TextEditingController _controller = TextEditingController();
  bool _isButtonActive = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        _isButtonActive = _controller.text.trim().isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _generateResponse() {
    if (_controller.text.trim().isEmpty) return;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LoadingScreen(
          inputText: _controller.text,
          mode: widget.mode,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isModeRoast = widget.mode == 'roast';
    final accentColor = isModeRoast ? const Color(0xFFFF006E) : const Color(0xFF8338EC);
    final modeTitle = isModeRoast ? 'Roast Me' : 'Rizz Boost';
    final modeEmoji = isModeRoast ? '🔥' : '💘';

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Row(
          children: [
            Text(modeEmoji, style: const TextStyle(fontSize: 24)),
            const SizedBox(width: 8),
            Text(modeTitle),
          ],
        ),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Text(
              isModeRoast
                  ? 'Paste a message to get roasted!'
                  : 'Paste a message to boost your rizz!',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Colors.grey[300],
              ),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: CustomTextField(
                controller: _controller,
                placeholder: 'Enter or paste your message...',
                accentColor: accentColor,
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: _isButtonActive ? _generateResponse : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: accentColor,
                  disabledBackgroundColor: Colors.grey[700],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: Text(
                  'Generate',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
