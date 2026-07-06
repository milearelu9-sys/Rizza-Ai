# 🎉 RizzAI - Your AI Text Assistant for Fun

A Flutter mobile application that uses AI to generate funny roasts and smooth rizz boosts for your messages. Perfect for entertainment and having a laugh!

## ✨ Features

- 🔥 **Roast Me** - Get hilariously savage roasts (safe & fun!)
- 💘 **Rizz Boost** - Transform your messages into smooth, charming versions  
- 🌙 **Dark Mode UI** - Modern neon-themed interface with Material 3
- ⚡ **Smooth Animations** - Loading spinners and interactive button press effects
- 📋 **Copy & Share** - Easily copy or share AI-generated responses
- 🎨 **Sleek Design** - Gradient buttons, modern cards, responsive layout

## 📱 Screenshots

### Home Screen
- Gradient "RizzAI" title
- Two main action buttons (Roast Me 🔥 & Rizz Boost 💘)
- Clean, minimal design

### Input Screen  
- Spacious text input area
- Mode-specific instructions
- Generate button (enabled only with text)

### Loading Screen
- Animated spinner (SpinKit FadingCircle)
- "AI is thinking…" message
- 2-second simulated processing

### Result Screen
- Input preview
- Gradient-bordered result card
- Copy, Share, and Try Another buttons

## 📁 Project Structure

```
lib/
├── main.dart                 # App initialization & theme
├── screens/
│   ├── home_screen.dart      # Main mode selection screen
│   ├── input_screen.dart     # Text input interface
│   ├── loading_screen.dart   # Async response loading
│   └── result_screen.dart    # Response display & actions
├── widgets/
│   ├── action_button.dart    # Gradient buttons with animations
│   ├── custom_text_field.dart # Reusable input field
│   └── result_card.dart      # Result display card
└── services/
    └── ai_service.dart       # Mock AI logic (ready for OpenAI)
```

## 🚀 Getting Started

### Prerequisites
- Flutter SDK 3.0+
- Dart SDK

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/milearelu9-sys/Rizza-Ai.git
   cd Rizza-Ai
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

## 🎯 How to Use

1. Launch the app
2. Choose **Roast Me** (🔥) for funny roasts or **Rizz Boost** (💘) for smooth vibes
3. Enter or paste your message
4. Tap **Generate** and wait for AI magic ✨
5. View, copy, or share the response!

## 🎨 Design System

### Color Palette
- **Background**: Dark Navy `#0A0E27`
- **Surface**: Deep Blue `#1A1F3A`  
- **Roast Color**: Neon Red `#FF006E`
- **Rizz Color**: Purple `#8338EC`
- **Accent**: Cyan `#00D4FF`

### Typography
- **Font**: Poppins (Google Fonts)
- **Theme**: Material 3 Dark Mode
- **Responsive**: Adapts to all screen sizes

## 📦 Dependencies

```yaml
flutter: SDK framework
google_fonts: Beautiful typography  
flutter_spinkit: Loading animations
share_plus: Cross-platform sharing
```

## 🧠 AI Logic

### Current Implementation
- Mock AI responses with demo data
- Randomly selects from predefined roast/rizz lists
- 2-second simulated processing delay

### Future OpenAI Integration

The `AIService` is structured for easy API integration:

1. Add `openai_flutter` package:
   ```yaml
   dependencies:
     openai_flutter: ^1.0.0
   ```

2. Implement real API calls in `lib/services/ai_service.dart`

3. Add your OpenAI API key to environment

## 🔒 Clean Architecture

- **Presentation Layer**: Screens & Widgets (UI logic)
- **Business Logic Layer**: Services (AI & data processing)
- **Application Layer**: Main (Config & theming)

## 🎓 Code Quality

- ✅ Uses `const` constructors everywhere
- ✅ Proper state management with StatefulWidget
- ✅ Reusable, well-documented widgets
- ✅ Clean separation of concerns
- ✅ Follows Flutter best practices

## 🚀 Future Enhancements

- [ ] Real OpenAI API integration
- [ ] User authentication & profiles
- [ ] Save favorite responses
- [ ] Response history
- [ ] Custom AI prompts
- [ ] Multi-language support
- [ ] Voice input support
- [ ] Rate limiting & credits system
- [ ] Unit & widget tests
- [ ] Web platform support

## 🐛 Troubleshooting

### Build Issues
```bash
flutter clean
flutter pub get
flutter pub upgrade
```

### Font Not Loading
Ensure fonts are in `pubspec.yaml` and assets directory exists.

## 📝 License

Open source and available under MIT License.

## 🤝 Contributing

Contributions welcome! Feel free to submit pull requests.

---

**Made with ✨ by RizzAI** | Have fun and stay sharp! 🔥💘
