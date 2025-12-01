import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:localstorage/localstorage.dart';
import 'package:premi_1/Home/home_page.dart';
import 'package:premi_1/login/view/login_page.dart';
import 'bloc/main_bloc.dart';
import '../firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    // Load environment variables first
    await dotenv.load(fileName: ".env");
    await initLocalStorage();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    runApp(const MyApp());
  } catch (e) {
    // ignore: avoid_print
    print(e);
    // ignore: avoid_print
    print('Error al inicializar Firebase');
    // ignore: avoid_print
    print(e.runtimeType);
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MainBloc()..add(Load()),
      child: BlocBuilder<MainBloc, MainState>(
        builder: (context, state) {
          return MaterialApp(
            title: 'PREMI+',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              colorSchemeSeed: state.themeColor??const Color(0xFFBB2649),
              useMaterial3: true,
            ),
            darkTheme: ThemeData(
              colorSchemeSeed: state.themeColor??const Color(0xFFBB2649),
              useMaterial3: true,
              brightness: state.isDark ? Brightness.dark : Brightness.light,
            ),
            // localizationsDelegates: GlobalMaterialLocalizations.delegates,
            // supportedLocales: const [Locale('en'), Locale('es')],
            themeMode: ThemeMode.dark,
            home: StreamBuilder<User?>(
              stream: FirebaseAuth.instance.userChanges(),
              builder: (context, snapshot) {
                if (snapshot.hasData &&
                    (snapshot.data?.emailVerified ?? false)) {
                  return const HomePage();
                }
                return const LoginPage();
              },
            ),
          );
        },
      ),
    );
  }
}
