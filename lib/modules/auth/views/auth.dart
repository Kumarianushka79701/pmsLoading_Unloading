import 'package:flutter/material.dart';
import 'package:project/modules/auth/provider/auth_provider.dart';
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

    return Scaffold(
      body: Consumer<AuthProvider>(
        builder: (context, authProvider, _) {
          return SingleChildScrollView(
            child: SizedBox(
              height: size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (!authProvider.isAuthenticated && authProvider.errorMessage != null)
                    Container(
                      padding: const EdgeInsets.all(8),
                      color: Colors.red,
                      child: Text(
                        authProvider.errorMessage!,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  Text(
                    'Login here',
                    style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                      color: AppColors.primary,
                    ),
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
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                    child: Form(
                      child: Column(
                        children: [
                          RoundTextField(
                            hintText: 'User ID',
                            isUpperCase: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter userid';
                              } else if (!RegExp(r'^[a-zA-Z]+$').hasMatch(value)) {
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
                              authProvider.isLoading ? 'Logging In...' : 'Login',
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
                              authProvider.login('userId', 'password', 'stationCode');
                              if (authProvider.isAuthenticated) {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(builder: (context) => const TabsScreen()),
                                );
                              }
                            },
                          ),
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
    );
  }
}