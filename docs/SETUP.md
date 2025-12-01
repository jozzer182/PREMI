# 🔧 Guía de Configuración - PREMI+

Esta guía detalla los pasos necesarios para configurar el proyecto PREMI+ desde cero.

## 📋 Tabla de Contenidos

1. [Requisitos Previos](#requisitos-previos)
2. [Configuración de Firebase](#configuración-de-firebase)
3. [Configuración de Google Apps Script](#configuración-de-google-apps-script)
4. [Variables de Entorno](#variables-de-entorno)
5. [Ejecución del Proyecto](#ejecución-del-proyecto)
6. [Solución de Problemas](#solución-de-problemas)

---

## 📌 Requisitos Previos

### Software Necesario

- **Flutter SDK** >= 3.7.2
- **Dart SDK** >= 3.7.2
- **Git**
- **VS Code** o **Android Studio** (recomendado)
- **Chrome** (para desarrollo web)

### Verificar Instalación

```bash
flutter doctor
```

Asegúrate de que todos los checks estén en verde (✓).

---

## 🔥 Configuración de Firebase

### Paso 1: Crear Proyecto Firebase

1. Ve a [Firebase Console](https://console.firebase.google.com/)
2. Haz clic en "Agregar proyecto"
3. Nombra tu proyecto (ej: `premi-app`)
4. Sigue los pasos del asistente

### Paso 2: Habilitar Authentication

1. En el panel de Firebase, ve a **Authentication**
2. Haz clic en **Comenzar**
3. En la pestaña **Sign-in method**, habilita **Correo/Contraseña**

### Paso 3: Agregar App Web

1. En la página principal del proyecto, haz clic en el ícono de **Web** (`</>`)
2. Registra tu app con un nombre (ej: `premi-web`)
3. **NO** marques "Firebase Hosting" por ahora
4. Copia los valores de configuración que aparecen:

```javascript
const firebaseConfig = {
  apiKey: "AIza...",           // → FIREBASE_API_KEY
  authDomain: "...",           // → FIREBASE_AUTH_DOMAIN
  projectId: "...",            // → FIREBASE_PROJECT_ID
  storageBucket: "...",        // → FIREBASE_STORAGE_BUCKET
  messagingSenderId: "...",    // → FIREBASE_MESSAGING_SENDER_ID
  appId: "..."                 // → FIREBASE_APP_ID
};
```

---

## 📜 Configuración de Google Apps Script

### Paso 1: Crear Script

1. Ve a [Google Apps Script](https://script.google.com/)
2. Crea un nuevo proyecto
3. Implementa las funciones necesarias para tu backend

### Paso 2: Desplegar como Web App

1. Haz clic en **Implementar** → **Nueva implementación**
2. Selecciona **Aplicación web**
3. Configura:
   - **Ejecutar como**: Tu cuenta
   - **Quién puede acceder**: Cualquiera
4. Haz clic en **Implementar**
5. Copia la **URL de la aplicación web**

### URLs Necesarias

Necesitarás dos URLs de Google Apps Script:

1. **API_PREMI**: Para operaciones de la base de datos principal
2. **API_LOGIN**: Para operaciones de usuarios y autenticación

---

## 🔐 Variables de Entorno

### Crear Archivo .env

1. En la raíz del proyecto, copia el archivo de ejemplo:

```bash
cp .env.example .env
```

2. Edita `.env` con tus valores reales:

```env
# Firebase Configuration
FIREBASE_API_KEY=AIzaSyC-xxxxxxxxxxxxxxxxxxxxxxxxxxxx
FIREBASE_APP_ID=1:1234567890:web:abcdef123456
FIREBASE_MESSAGING_SENDER_ID=1234567890
FIREBASE_PROJECT_ID=tu-proyecto-id
FIREBASE_AUTH_DOMAIN=tu-proyecto-id.firebaseapp.com
FIREBASE_STORAGE_BUCKET=tu-proyecto-id.appspot.com

# Google Apps Script APIs
API_PREMI=https://script.google.com/macros/s/AKfycbz.../exec
API_LOGIN=https://script.google.com/macros/s/AKfycbz.../exec
```

### ⚠️ Importante

- **NUNCA** subas el archivo `.env` a control de versiones
- El archivo `.env` ya está incluido en `.gitignore`
- Cada desarrollador debe crear su propio `.env` local

---

## 🚀 Ejecución del Proyecto

### Instalar Dependencias

```bash
flutter pub get
```

### Ejecutar en Web

```bash
flutter run -d chrome
```

### Ejecutar en Android

```bash
flutter run -d android
```

### Ejecutar en iOS (solo macOS)

```bash
flutter run -d ios
```

### Build para Producción

```bash
# Web
flutter build web

# Android APK
flutter build apk

# Android App Bundle
flutter build appbundle

# iOS
flutter build ios
```

---

## 🔧 Solución de Problemas

### Error: "Cannot find .env file"

**Causa**: El archivo `.env` no existe o está en una ubicación incorrecta.

**Solución**:
```bash
cp .env.example .env
# Luego edita .env con tus valores reales
```

### Error: Firebase Initialization Failed

**Causa**: Credenciales de Firebase incorrectas.

**Solución**:
1. Verifica que todas las variables de entorno de Firebase estén correctas
2. Asegúrate de que el proyecto Firebase esté activo
3. Verifica que Authentication esté habilitado

### Error: API Request Failed

**Causa**: URLs de Google Apps Script incorrectas o scripts no desplegados.

**Solución**:
1. Verifica que los scripts estén desplegados como Web App
2. Confirma que las URLs en `.env` sean las correctas
3. Verifica los permisos de acceso del script

### Error: Flutter Doctor Issues

```bash
flutter doctor --verbose
```

Sigue las instrucciones específicas para cada problema detectado.

---

## 📚 Recursos Adicionales

- [Documentación de Flutter](https://flutter.dev/docs)
- [Firebase para Flutter](https://firebase.google.com/docs/flutter/setup)
- [flutter_dotenv Package](https://pub.dev/packages/flutter_dotenv)
- [Google Apps Script](https://developers.google.com/apps-script)

---

## 📞 Soporte

Si tienes problemas con la configuración:

1. Revisa esta guía completamente
2. Busca en los [Issues del repositorio](https://github.com/jozzer182/PREMI/issues)
3. Crea un nuevo Issue con detalles específicos del problema

