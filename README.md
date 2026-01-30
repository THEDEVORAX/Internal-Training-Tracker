# 📊 Internal Training Tracker

[![Flutter](https://img.shields.io/badge/Flutter-3.10.7-02569B?logo=flutter&logoColor=white)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.1.0-0175C2?logo=dart&logoColor=white)](https://dart.dev)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

An **enterprise-grade performance analytics dashboard** built with Flutter. This application provides HR and management with deep insights into employee training progress, skill development, and overall learning velocity using a premium, modern UI.

---

## ✨ Key Features

- 📈 **Dynamic Analytics Dashboard**: Real-time visualization of training progress and performance metrics.
- 🎯 **Skill Assessment Radar**: Interactive radar charts to visualize proficiency across different categories (Technical, Soft Skills, Leadership, etc.).
- 👨‍💼 **Employee Performance Profiles**: Comprehensive view of individual learning journeys, including completion rates and average scores.
- 🎨 **Premium UI/UX**: 
  - Glassmorphism design language.
  - Adaptive Dark & Light modes.
  - Smooth, physics-based animations.
  - Fully responsive layout (Mobile, Tablet, Desktop).
- 📊 **Metric Tiles**: Instant access to Weighted Performance, Learning Velocity, and Assessment Score averages with trend indicators.
- 📜 **Training History**: Detailed audit trail of all completed and ongoing courses.

## 🛠️ Tech Stack

- **Framework**: [Flutter](https://flutter.dev)
- **State Management**: [flutter_bloc](https://pub.dev/packages/flutter_bloc) (BLoC Pattern)
- **Architecture**: Clean Architecture (Data, Domain, Presentation layers)
- **Charts**: [fl_chart](https://pub.dev/packages/fl_chart)
- **Animations**: [flutter_animate](https://pub.dev/packages/flutter_animate)
- **Theming**: [Google Fonts (Inter)](https://fonts.google.com/specimen/Inter)
- **Icons**: [Lucide Icons / Material Icons]

---

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (v3.10.7 or higher)
- Dart SDK (v3.1.0 or higher)

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/THEDEVORAX/Internal-Training-Tracker.git
   ```

2. **Navigate to the project directory**
   ```bash
   cd Internal-Training-Tracker
   ```

3. **Install dependencies**
   ```bash
   flutter pub get
   ```

4. **Run the application**
   ```bash
   flutter run
   ```

---

## 🏗️ Project Structure

The project follows a **Clean Architecture** approach to ensure scalability and maintainability:

```text
lib/
├── core/           # Theme, constants, and shared utilities
├── data/           # Repository implementations and data sources
├── domain/         # Entities, use cases, and repository interfaces
└── presentation/   # BLoCs, screens, and reusable widgets
```

---

## 📸 Screenshots

| Light Mode | Dark Mode |
|:---:|:---:|
| <img src="assets/screenshots/light_dashboard.png" width="400"> | <img src="assets/screenshots/dark_dashboard.png" width="400"> |

*(Note: Add your actual screenshots to the `assets/screenshots/` folder for better visibility)*

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

<p align="center">
  Made with ❤️ by <b>TheDevorax</b>
</p>
