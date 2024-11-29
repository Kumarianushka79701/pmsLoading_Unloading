import 'package:flutter/material.dart';
import 'package:project/modules/auth/provider/auth_provider.dart';
import 'package:project/modules/forgot_account_page/views/forgot_account_view.dart';
import 'package:project/routes/app_routes.dart';
import 'package:project/utils/app_icons.dart';
import 'package:project/utils/colors.dart';
import 'package:project/widgets/text_feild.dart';
import 'package:project/widgets/text_widget.dart';
import 'package:provider/provider.dart';
import 'package:project/modules/tabScreen/views/tabs.dart';
import 'package:project/utils/color_extensions.dart';
import 'package:project/widgets/common/RoundButton.dart';
import 'package:project/widgets/common/RoundTextField.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Positioned.fill(
              child: Opacity(
                opacity: 0.1, // Adjust opacity here
                child: Image.asset(
                  AppIcons.pmsLogoTwo, // Ensure this path is correct
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Consumer<AuthProvider>(
              builder: (context, authProvider, _) {
                return SingleChildScrollView(
                  child: SizedBox(
                    height: size.height,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (!authProvider.isAuthenticated &&
                            authProvider.errorMessage != null)
                          Container(
                            padding: const EdgeInsets.all(8),
                            color: Colors.red,
                            child: Text(
                              authProvider.errorMessage!,
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        Text(
                          'Login Here',
                          style: Theme.of(context)
                              .textTheme
                              .headlineLarge!
                              .copyWith(
                                  color: ParcelColors.catalinaBlue,
                                  fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Welcome back you\'ve \nbeen missed',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        Image.asset(
                          AppIcons.logopms,
                          fit: BoxFit.cover,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 30, horizontal: 20),
                          child: Form(
                            child: Column(
                              children: [
                                RoundTextField(
                                  hintText: 'User ID',
                                  prefixIcon: Icon(
                                    Icons.person,
                                    color: ParcelColors.catalinaBlue,
                                  ),
                                  isUpperCase: true,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter userid';
                                    } else if (!RegExp(r'^[a-zA-Z]+$')
                                        .hasMatch(value)) {
                                      return 'UserId must contain only alphabetic characters';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    // Save the entered value
                                  },
                                ),
                                const SizedBox(height: 10),
                                RoundTextField(
                                  prefixIcon: Icon(
                                    Icons.lock,
                                    color: ParcelColors.catalinaBlue,
                                  ),
                                  hintText: 'Password',
                                  isUpperCase: true,
                                  obscureText: true,
                                  onSaved: (value) {
                                    // Save the entered value
                                  },
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter password';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 10),
                                RoundTextField(
                                  hintText: 'Station Code',
                                  prefixIcon: Icon(
                                    Icons.location_on,
                                    color: ParcelColors.catalinaBlue,
                                  ),
                                  isUpperCase: true,
                                  onSaved: (value) {
                                    // Save the entered value
                                  },
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter station code';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 20),
                                RoundButton(
                                  title: Text(
                                    authProvider.isLoading
                                        ? 'Logging In...'
                                        : 'Login',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  isLoading: authProvider.isLoading,
                                  loadingIndicator: const SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2.0,
                                    ),
                                  ),
                                  onPressed: () {
                                    // Call the login method from the AuthProvider
                                    authProvider.login('AT', 'AT', 'NDLS');
                                    if (authProvider.isAuthenticated) {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const TabsScreen()),
                                      );
                                    }
                                  },
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                               ElevatedButton(
  onPressed: () {
    Navigator.pushNamed(context, Routes.FORGOT_ACCOUNT_PAGE);
    print("object");
  },
  child: Text('Go to Forgot Account Page'),
)
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
