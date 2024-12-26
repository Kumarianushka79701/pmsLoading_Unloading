import 'package:flutter/material.dart';
import 'package:project/modules/providers/local_database_provider.dart';
import 'package:project/widgets/custom_button.dart';
import 'package:provider/provider.dart';
import 'package:project/modules/auth/provider/auth_provider.dart';
import 'package:project/modules/auth/views/registration_view.dart';
import 'package:project/modules/tabScreen/views/tabs.dart';
import 'package:project/routes/app_routes.dart';
import 'package:project/utils/app_icons.dart';
import 'package:project/utils/colors.dart';
import 'package:project/widgets/common/RoundButton.dart';
import 'package:project/widgets/common/RoundTextField.dart';


class AuthScreen extends StatelessWidget {
  AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Stack(
            children: [
              // Background logo with opacity
              Positioned.fill(
                child: Opacity(
                  opacity: 0.1,
                  child: Image.asset(
                    AppIcons.pmsLogoTwo,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Consumer2<AuthProvider, LocalDatabaseProvider>(
                builder: (context, authProvider, localDatabaseProvider, _) {
                  return SingleChildScrollView(
                    child: SizedBox(
                      height: size.height,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Error Message Container
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
                          // Title
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
                              color: ParcelColors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          // Login Form
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 30, horizontal: 20),
                            child: Form(
                              key: authProvider.formKey,
                              child: Column(
                                children: [
                                  // User ID TextField
                                  RoundTextField(
                                    controller: authProvider.userIDController,
                                    hintText: 'User ID',
                                    prefixIcon: Icon(
                                      Icons.person,
                                      color: ParcelColors.catalinaBlue,
                                    ),
                                    isUpperCase: true,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter User ID';
                                      } else if (!RegExp(r'^[a-zA-Z]+$')
                                          .hasMatch(value)) {
                                        return 'User ID must contain only alphabetic characters';
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(height: 10),
                                  // Password TextField
                                  RoundTextField(
                                    controller: authProvider.passwordController,
                                    hintText: 'Password',
                                    prefixIcon: Icon(
                                      Icons.lock,
                                      color: ParcelColors.catalinaBlue,
                                    ),
                                    obscureText: true,
                                    isUpperCase: true,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter Password';
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(height: 10),
                                  // Station Code TextField
                                  RoundTextField(
                                    controller:
                                        authProvider.stationCodeController,
                                    hintText: 'Station Code',
                                    prefixIcon: Icon(
                                      Icons.location_on,
                                      color: ParcelColors.catalinaBlue,
                                    ),
                                    isUpperCase: true,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter Station Code';
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(height: 20),
                                  // Login Button
                                RoundButton(
                                  title: Text(
                                    authProvider.isLoading
                                        ? 'Logging In...'
                                        : 'Login',
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                  isLoading: authProvider.isLoading,
                                  onPressed: authProvider.isLoading
                                      ? () {}
                                      : () {
                                          handleLogin(
                                              context,
                                              authProvider,
                                              localDatabaseProvider);
                                        },
                                ),
                                  const SizedBox(height: 20),
                                  // Navigation Buttons
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pushNamed(
                                          context,
                                          Routes.FORGOT_ACCOUNT_PAGE,
                                        );
                                      },
                                      child: const Text(
                                        'Forgot Account',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      )),
                                  TextButton(
                                      onPressed: () {
                                        authProvider.passwordController.text
                                            .trim();
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const SignUpScreen(),
                                          ),
                                        );
                                      },
                                      child: Text(
                                        'Sign Up',
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      )),
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
      ),
    );
  }
// Add predefined credentials
 String predefinedUserID = "AT";
 String predefinedPassword = "AT";
 String predefinedStationCode = "NDLS";

Future<void> handleLogin(
    BuildContext context, AuthProvider authProvider, LocalDatabaseProvider localDatabaseProvider) async {
  try {
    // Retrieve user input
    String enteredUserID = authProvider.userIDController.text.trim();
    String enteredPassword = authProvider.passwordController.text.trim();
    String enteredStationCode = authProvider.stationCodeController.text.trim();

    // Check if the entered credentials match the predefined credentials
    if (enteredUserID == predefinedUserID &&
        enteredPassword == predefinedPassword &&
        enteredStationCode == predefinedStationCode) {
      // Save login information locally
      await localDatabaseProvider.saveLoginInfo(
        userId: enteredUserID,
        password: enteredPassword,
        stationCode: enteredStationCode,
      );

      // Navigate to the dashboard
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => TabsScreen()),
      );
    } else {
      // Show error message for invalid credentials
      showErrorMessage(context, "Invalid User ID, Password, or Station Code");
    }
  } catch (e) {
    // Handle errors
    debugPrint("Error during login: $e");
    showErrorMessage(context, "Login failed. Please try again.");
  }
}

void showErrorMessage(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(message)),
  );
}

// Future<void> handleLogin(
//     BuildContext context, AuthProvider authProvider, LocalDatabaseProvider localDatabaseProvider) async {
//   try {
//     // Check if all inputs are valid
//     if (authProvider.userIDController.text.isEmpty ||
//         authProvider.passwordController.text.isEmpty ||
//         authProvider.stationCodeController.text.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Please fill in all fields")),
//       );
//       return;
//     }

//     // Save login information locally
//     await localDatabaseProvider.saveLoginInfo(
//       userId: authProvider.userIDController.text,
//       password: authProvider.passwordController.text,
//       stationCode: authProvider.stationCodeController.text,
//     );

//     // Navigate to the target screen
//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(
//         builder: (context) => TabsScreen(), // Replace TabsScreen with your target screen
//       ),
//     );
//   } catch (e) {
//     // Handle errors
//     debugPrint("Error during login: $e");
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text("Login failed. Please try again.")),
//     );
//   }
// }

//   void showErrorMessage(BuildContext context, String message) {
//     ScaffoldMessenger.of(context)
//         .showSnackBar(SnackBar(content: Text(message)));
//   }
}
