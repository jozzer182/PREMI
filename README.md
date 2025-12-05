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
  <strong>Sistema de Gestión de Premios y Apremios</strong>
</p>

---

## 📋 Descripción

**PREMI+** es una aplicación Flutter multiplataforma diseñada para la gestión integral de premios y apremios empresariales. Permite el seguimiento completo del ciclo de vida de los registros, desde la solicitud inicial hasta la facturación final.

## ✨ Características Principales

- 🔐 **Autenticación segura** con Firebase Auth
- 📊 **Dashboard interactivo** con visualización de datos en tiempo real
- 📝 **Gestión completa de registros**:
  - Creación de nuevos registros
  - Seguimiento de estados (Solicitado, Respuesta, Réplica, Facturado)
  - Carga de archivos adjuntos
- 🔍 **Búsqueda y filtrado** avanzado de registros
- 📱 **Diseño responsive** para Web y dispositivos móviles
- 🎨 **Tema personalizable** con Material Design 3
- 📈 **Reportes y estadísticas** con gráficos interactivos

## 🛠️ Stack Tecnológico

| Tecnología | Uso |
|------------|-----|
| **Flutter 3.x** | Framework de desarrollo multiplataforma |
| **Dart 3.x** | Lenguaje de programación |
| **Firebase Auth** | Autenticación de usuarios |
| **Firebase Analytics** | Analíticas de uso |
| **Google Apps Script** | Backend API y almacenamiento de datos |
| **flutter_bloc** | Gestión de estado |
| **fl_chart** | Visualización de gráficos |

## 🏗️ Arquitectura del Proyecto

```
lib/
├── bloc/                    # BLoC para gestión de estado
│   ├── main_bloc.dart
│   ├── main_event.dart
│   └── main_state.dart
├── desplegables/           # Modelos de datos desplegables
├── dialogs/                # Diálogos de la aplicación
├── Home/                   # Página principal
├── login/                  # Módulo de autenticación
│   ├── model/
│   └── view/
├── nuevo/                  # Creación de nuevos registros
├── resources/              # Recursos y utilidades
│   ├── env_config.dart     # Configuración de variables de entorno
│   └── ...
├── Todos/                  # Listados y gestión de registros
├── user/                   # Modelo de usuario
├── users/                  # Gestión de usuarios
├── vista/                  # Vistas adicionales
├── firebase_options.dart   # Configuración de Firebase
├── main.dart              # Punto de entrada
└── router.dart            # Configuración de rutas
```

## 🚀 Instalación

### Prerrequisitos

- [Flutter SDK](https://flutter.dev/docs/get-started/install) (^3.7.2)
- [Dart SDK](https://dart.dev/get-dart) (^3.7.2)
- Cuenta de [Firebase](https://firebase.google.com/)
- [Google Apps Script](https://script.google.com/) configurado

### Pasos de Instalación

1. **Clonar el repositorio**
   ```bash
   git clone https://github.com/jozzer182/PREMI.git
   cd PREMI
   ```

2. **Instalar dependencias**
   ```bash
   flutter pub get
   ```

3. **Configurar variables de entorno**
   ```bash
   cp .env.example .env
   ```
   Edita el archivo `.env` con tus credenciales reales.

4. **Ejecutar la aplicación**
   ```bash
   # Web
   flutter run -d chrome
   
   # Android
   flutter run -d android
   
   # iOS
   flutter run -d ios
   ```

## ⚙️ Configuración

### Variables de Entorno

Crea un archivo `.env` en la raíz del proyecto con las siguientes variables:

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

1. Crea un proyecto en [Firebase Console](https://console.firebase.google.com/)
2. Habilita Authentication con Email/Password
3. Copia las credenciales de configuración web al archivo `.env`

### Google Apps Script Setup

1. Crea los scripts necesarios en [Google Apps Script](https://script.google.com/)
2. Despliega como aplicación web
3. Copia las URLs de despliegue al archivo `.env`

## 📦 Dependencias Principales

```yaml
dependencies:
  flutter_dotenv: ^5.1.0      # Variables de entorno
  firebase_core: ^3.13.0      # Firebase Core
  firebase_auth: ^5.5.2       # Autenticación
  flutter_bloc: ^9.1.0        # Gestión de estado
  fl_chart: ^0.64.0           # Gráficos
  http: ^1.1.0                # Peticiones HTTP
  file_picker: ^10.1.2        # Selección de archivos
  intl: ^0.20.2               # Internacionalización
```

## 🤝 Contribuir

Las contribuciones son bienvenidas. Por favor:

1. Haz fork del proyecto
2. Crea una rama para tu feature (`git checkout -b feature/AmazingFeature`)
3. Commit tus cambios (`git commit -m 'Add some AmazingFeature'`)
4. Push a la rama (`git push origin feature/AmazingFeature`)
5. Abre un Pull Request

## 📄 Licencia

Este proyecto está bajo la Licencia MIT. Ver el archivo `LICENSE` para más detalles.

## 📬 Contacto

**José Zarabanda**

[![LinkedIn](https://img.shields.io/badge/LinkedIn-0077B5?style=for-the-badge&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/zarabandajose/)
[![GitHub](https://img.shields.io/badge/GitHub-100000?style=for-the-badge&logo=github&logoColor=white)](https://github.com/jozzer182)
[![Website](https://img.shields.io/badge/Website-FF7139?style=for-the-badge&logo=firefox&logoColor=white)](https://zarabanda-dev.web.app/)

---

<p align="center">
  Hecho con ❤️ usando Flutter
</p>
