import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:glow/apis/auth_api.dart';
import 'package:glow/helpers/preferences.dart';
import 'package:glow/providers/auth_provider.dart';
import 'package:glow/providers/sch_provider.dart';
import 'package:glow/providers/student_provider/student_file_provider.dart';
import 'package:glow/providers/student_provider/student_home_provider.dart';
import 'package:glow/providers/student_provider/student_lesson_provider.dart';
import 'package:glow/screens/app/parent/home/home.dart';
import 'package:glow/screens/app/student/student_main.dart';
import 'package:glow/screens/onboarding/onboarding.dart';
import 'package:glow/theme.dart';
import 'package:provider/provider.dart';

final GetIt getIt = GetIt.I;
void setupLocator() {
  getIt.registerLazySingleton<Preference>(() => Preference());
  getIt.registerLazySingleton<AuthAPI>(() => AuthAPI());
  getIt.registerLazySingleton<AuthProvider>(() => AuthProvider());
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  Widget widget = await decideFirstWidget();
  runApp(GlowApp(widget));
  // runApp(DevicePreview(
  //   builder: (context) => GlowApp(widget),
  // ));
}

Future<Widget> decideFirstWidget() async {
  await getIt<Preference>().init();
  String token = getIt<Preference>().token;
  // check for accountType
  if (token != '') {
    getIt<AuthProvider>().getCurrentUser();
    switch (getIt<Preference>().accountType) {
      case 'parent':
        return ParentHomePage();
        break;
      case 'student':
        return StudentMainPage();
        break;
      case 'staff':
        // return StaffMainPage();

        break;
      // case 'sch_admin':
      //   return ParentHomePage();
      //   break;
      default:
        throw new Exception("${getIt<Preference>().accountType} not found");
    }
  }
  return OnboardingPage();
}

class GlowApp extends StatelessWidget {
  final Widget widget;
  GlowApp(this.widget);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: <SingleChildCloneableWidget>[
        // app provider
        ChangeNotifierProvider(create: (context) => getIt<AuthProvider>()),
        ChangeNotifierProvider(create: (context) => SchProvider()),
        // student
        ChangeNotifierProvider(create: (context) => StudentMainProvider()),
        ChangeNotifierProvider(create: (context) => StudentLessonProvider()),
        ChangeNotifierProvider(create: (context) => StudentFileProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: theme,
        title: 'GlowApp',
        home: widget,
      ),
    );
  }
}
