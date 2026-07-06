/// Mock AI Service for RizzAI
/// This service generates demo responses.
/// Ready to be extended with real OpenAI API integration.

class AIService {
  static const Map<String, List<String>> roastResponses = {
    'roast': [
      'That message is so generic, even autocorrect would be embarrassed.',
      'I\'ve seen more charm in a motivational poster from 2003.',
      'Your message has the personality of unseasoned rice.',
      'Wow, bold of you to hit send with that energy.',
      'That\'s the kind of message that makes phones want to self-destruct.',
      'Your typing style screams "I\'ve never used caps lock before."',
      'This message needs a fire extinguisher, not a compliment.',
    ],
  };

  static const Map<String, List<String>> rizzResponses = {
    'rizz': [
      'That message just became 10x cooler and smoother. Confidence level: maximum.',
      'Your crush just saw this and forgot all the other options existed.',
      'This version would make Shakespeare delete his entire career.',
      'Smooth, mysterious, and absolutely devastating to anyone who reads it.',
      'This message has more rizz than a TikTok influencer.',
      'You\'ve officially leveled up your texting game. Prepare for the replies.',
      'If smooth were a person, it would be this message.',
    ],
  };

  static Future<Map<String, String>> generateAIResponse(
    String text,
    String mode,
  ) async {
    await Future.delayed(const Duration(seconds: 1));

    final roastResponse = _generateMockResponse(text, 'roast');
    final rizzResponse = _generateMockResponse(text, 'rizz');

    return {
      'roast': roastResponse,
      'rizz': rizzResponse,
    };
  }

  static String _generateMockResponse(String input, String type) {
    final responses = type == 'roast' ? roastResponses['roast']! : rizzResponses['rizz']!;
    final randomIndex = DateTime.now().millisecond % responses.length;
    return responses[randomIndex];
  }
}
