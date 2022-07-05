import 'package:byte_bistro/Screens/login_screen.dart';
import 'package:byte_bistro/Screens/profile/profile_screen.dart';
import 'package:byte_bistro/Screens/reset_password.dart';
import 'package:byte_bistro/Screens/signup_screen.dart';
import 'package:byte_bistro/Screens/verify_reset_password.dart';
import 'package:byte_bistro/constants/colors.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:integration_test/integration_test.dart';

import '../lib/main.dart' as app;
import 'package:flutter/material.dart';

Future<void> addDelay(int ms) async {
  await Future<void>.delayed(Duration(milliseconds: ms));
}

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  if (binding is LiveTestWidgetsFlutterBinding) {
    binding.framePolicy = LiveTestWidgetsFlutterBindingFramePolicy.fullyLive;
  }

  group('end-to-end test', () {
    testWidgets('Test the login screen and naviagate to otp screen',
        (WidgetTester tester) async {
      final testWidget = GetMaterialApp(
        theme: ThemeData(

          primaryColor: Color(0xFFFFC61F),

          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Colors.brown,
          ).copyWith(
            secondary: kTextColor,
          ),

          fontFamily: ' San Francisco',

          textTheme: const TextTheme(
            headline1: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
              height: 1.5,
              color: kTextColor,
            ),
            headline2: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
              height: 1.5,
              color: kTextColor,
            ),
            bodyText1: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w300,
              height: 1.5,
              color: kTextColor,
            ),
            bodyText2: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w300,
              color: kTextLightColor,
            ),
          ),
        ),
        initialRoute: '/login',
        getPages: [
          GetPage(name: '/login', page: () => LoginScreen()),
          GetPage(name: '/signup', page: () => SignUpScreen()),
          GetPage(name: '/profile_screen', page: () => ProfileScreen()),
          GetPage(name: '/reset_password', page: () => ForgetPasswordScreen()),
          GetPage(
            name: '/verify_reset_password', page: () => VerifyResetPassword()),
        ],
        debugShowCheckedModeBanner: false,
        title: 'Byte Bistro',
      );
      await tester.pumpWidget(testWidget);

      await tester.pumpAndSettle();
      await tester.enterText(find.byKey(const ValueKey('username')), 'nishan');
      await addDelay(3000);

      await tester.enterText(find.byKey(const ValueKey('password')), 'pass');
      await addDelay(3000);
      await tester.ensureVisible(find.byKey(const ValueKey('loginButton')));
      await tester.tap(find.byKey(const ValueKey('show_hide')));
      await tester.pumpAndSettle();

      await addDelay(3000);

      await tester.tap(find.byKey(const ValueKey('show_hide')));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Forgot your password?'));
      await tester.pumpAndSettle();
      await addDelay(5000);

      await tester.enterText(
          find.byKey(const ValueKey('otp_email')), "automate_test@gmail.com");

      await addDelay(5000);

      expect(find.text('Please enter your email to receive a One Time Password(OTP) so that we can verify you.'), findsOneWidget);
    });
  });
}
