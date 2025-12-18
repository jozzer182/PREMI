# PREMI+ 🏆

<p align="center">
  <img src="images/rules.png" alt="PREMI+ Logo" width="120"/>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white" alt="Flutter"/>
  <img src="https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white" alt="Dart"/>
  <img src="https://img.shields.io/badge/Firebase-FFCA28?style=for-the-badge&logo=firebase&logoColor=black" alt="Firebase"/>
  <img src="https://img.shields.io/badge/Google_Apps_Script-4285F4?style=for-the-badge&logo=google&logoColor=white" alt="Google Apps Script"/>
</p>

<p align="center">
  <strong>Rewards and Penalties Management System</strong>
</p>

---

## 📋 Description

**PREMI+** is a multi-platform Flutter application designed for comprehensive management of enterprise rewards and penalties. It enables complete lifecycle tracking of records, from the initial request to the final invoicing.

## ✨ Key Features

- 🔐 **Secure authentication** with Firebase Auth
- 📊 **Interactive dashboard** with real-time data visualization
- 📝 **Complete record management**:
  - Create new records
  - Track statuses (Requested, Response, Reply, Invoiced)
  - Upload file attachments
- 🔍 **Advanced search and filtering** of records
- 📱 **Responsive design** for Web and mobile devices
- 🎨 **Customizable theme** with Material Design 3
- 📈 **Reports and statistics** with interactive charts

## 🛠️ Tech Stack

| Technology | Usage |
|------------|-------|
| **Flutter 3.x** | Multi-platform development framework |
| **Dart 3.x** | Programming language |
| **Firebase Auth** | User authentication |
| **Firebase Analytics** | Usage analytics |
| **Google Apps Script** | Backend API and data storage |
| **flutter_bloc** | State management |
| **fl_chart** | Chart visualization |

## 🏗️ Project Architecture

```
lib/
├── bloc/                    # BLoC for state management
│   ├── main_bloc.dart
│   ├── main_event.dart
│   └── main_state.dart
├── desplegables/           # Dropdown data models
├── dialogs/                # Application dialogs
├── Home/                   # Home page
├── login/                  # Authentication module
│   ├── model/
│   └── view/
├── nuevo/                  # New record creation
├── resources/              # Resources and utilities
│   ├── env_config.dart     # Environment variables configuration
│   └── ...
├── Todos/                  # Record listings and management
├── user/                   # User model
├── users/                  # User management
├── vista/                  # Additional views
├── firebase_options.dart   # Firebase configuration
├── main.dart              # Entry point
└── router.dart            # Route configuration
```

## 🚀 Installation

### Prerequisites

- [Flutter SDK](https://flutter.dev/docs/get-started/install) (^3.7.2)
- [Dart SDK](https://dart.dev/get-dart) (^3.7.2)
- [Firebase](https://firebase.google.com/) account
- [Google Apps Script](https://script.google.com/) configured

### Installation Steps

1. **Clone the repository**
   ```bash
   git clone https://github.com/jozzer182/PREMI.git
   cd PREMI
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Configure environment variables**
   ```bash
   cp .env.example .env
   ```
   Edit the `.env` file with your actual credentials.

4. **Run the application**
   ```bash
   # Web
   flutter run -d chrome
   
   # Android
   flutter run -d android
   
   # iOS
   flutter run -d ios
   ```

## ⚙️ Configuration

### Environment Variables

Create a `.env` file in the project root with the following variables:

```env
# Firebase Configuration
FIREBASE_API_KEY=your_api_key
FIREBASE_APP_ID=your_app_id
FIREBASE_MESSAGING_SENDER_ID=your_sender_id
FIREBASE_PROJECT_ID=your_project_id
FIREBASE_AUTH_DOMAIN=your_project.firebaseapp.com
FIREBASE_STORAGE_BUCKET=your_project.appspot.com

# Google Apps Script APIs
API_PREMI=https://script.google.com/macros/s/YOUR_SCRIPT_ID/exec
API_LOGIN=https://script.google.com/macros/s/YOUR_SCRIPT_ID/exec
```

### Firebase Setup

1. Create a project in [Firebase Console](https://console.firebase.google.com/)
2. Enable Authentication with Email/Password
3. Copy the web configuration credentials to the `.env` file

### Google Apps Script Setup

1. Create the necessary scripts in [Google Apps Script](https://script.google.com/)
2. Deploy as web application
3. Copy the deployment URLs to the `.env` file

## 📦 Main Dependencies

```yaml
dependencies:
  flutter_dotenv: ^5.1.0      # Environment variables
  firebase_core: ^3.13.0      # Firebase Core
  firebase_auth: ^5.5.2       # Authentication
  flutter_bloc: ^9.1.0        # State management
  fl_chart: ^0.64.0           # Charts
  http: ^1.1.0                # HTTP requests
  file_picker: ^10.1.2        # File selection
  intl: ^0.20.2               # Internationalization
```

## 🤝 Contributing

Contributions are welcome. Please:

1. Fork the project
2. Create a branch for your feature (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📄 License

This project is under the MIT License. See the `LICENSE` file for more details.

## 📬 Contact

**José Zarabanda**

[![LinkedIn](https://img.shields.io/badge/LinkedIn-0077B5?style=for-the-badge&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/zarabandajose/)
[![GitHub](https://img.shields.io/badge/GitHub-100000?style=for-the-badge&logo=github&logoColor=white)](https://github.com/jozzer182)
[![Website](https://img.shields.io/badge/Website-FF7139?style=for-the-badge&logo=firefox&logoColor=white)](https://zarabanda-dev.web.app/)

---

<p align="center">
  Made with ❤️ using Flutter
</p>
