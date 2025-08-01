# 🔁 Palindrome Checker App

A beautifully designed Flutter app that checks whether a string is a **palindrome** and maintains a complete **history** of checks with time-stamped results. The app features an animated splash screen, form-based user intro, and a persistent history manager using `Provider` and `SharedPreferences`.

---

<h2 align="center">📷 App Screenshots</h2>

<p align="center">
  <img src="https://github.com/NoorMustafa4556/Palindrome-Checker-App/blob/main/assets/images/1.png" width="30%"/>
  <img src="https://github.com/NoorMustafa4556/Palindrome-Checker-App/blob/main/assets/images/3(1).png" width="30%"/>
<img src="https://github.com/NoorMustafa4556/Palindrome-Checker-App/blob/main/assets/images/3.png" width="30%"/>
  
  <img src="https://github.com/NoorMustafa4556/Palindrome-Checker-App/blob/main/assets/images/4.png" width="30%"/>
  <img src="https://github.com/NoorMustafa4556/Palindrome-Checker-App/blob/main/assets/images/5.png" width="30%"/>
  <img src="https://github.com/NoorMustafa4556/Palindrome-Checker-App/blob/main/assets/images/6.png" width="30%"/>
</p>

---

## 🚀 Features

### 🔹 Splash Screen
- Gradient animated background
- Profile image and personal info
- Auto-navigation to the intro form

### 🔹 Intro Form Screen
- Enter Name, Roll No, Department, Section, Semester, Session
- Transitions to the main palindrome checker screen

### 🔹 Palindrome Checker
- Validates if the entered string is a palindrome
- Displays meaningful success or error messages
- Shows result in color-coded output (green for true, red for false)

### 🔹 History Management
- Maintains a list of previous entries with:
  - Input string
  - Whether it was a palindrome
  - Date and time of check
- Options to:
  - Clear entire history
  - Select and delete specific entries

---

## 🛠️ Tech Stack & Key Packages

- **Framework**: [Flutter](https://flutter.dev/)
- **State Management**: `provider`
- **Local Storage**: `shared_preferences`
- **Animation**: `flutter_spinkit`
- **UI Icons & Fonts**: `google_fonts`, `font_awesome_flutter`, `animated_text_kit`

---

## 📁 Folder Structure

```
lib/
├── main.dart
├── Providers/
│   └── HistoryProvider.dart
├── Palindrome Check/
│   ├── PalindromeLoad.dart
│   ├── Palindrome1.dart
│   ├── PalindromeCheck.dart
│   └── PalindromeHistory.dart
assets/
└── images/
    ├── 1.png - 6.png
    └── profile.png
```

---

## ⚙️ Getting Started

### 📋 Prerequisites

Ensure Flutter SDK is installed. Refer to the [Flutter Install Guide](https://flutter.dev/docs/get-started/install).

### 🔧 Installation Steps

```bash
# 1. Clone the repository
git clone https://github.com/NoorMustafa4556/Palindrome-Checker-App.git

# 2. Navigate to the directory
cd Palindrome-Checker-App

# 3. Install dependencies
flutter pub get

# 4. Run the app
flutter run
```

---

## 🤝 Contributing

Contributions are welcome! Feel free to fork the repo and submit pull requests.

1. Fork the project  
2. Create your feature branch: `git checkout -b feature/AmazingFeature`  
3. Commit your changes: `git commit -m 'Add some AmazingFeature'`  
4. Push to the branch: `git push origin feature/AmazingFeature`  
5. Open a pull request

---

## 👤 Developer Info

> **Name:** Noor Mustafa  
> **Roll No:** 1160  
> **Department:** Computer Science  
> **Semester:** 6th  
> **Section:** M3 (C)  
> **Subject:** Theory Of Automata  
> **University:** The Islamia University of Bahawalpur

---

Made with 💚 using Flutter & Dart
