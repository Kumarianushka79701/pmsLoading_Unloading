import 'package:flutter/material.dart';
import 'package:project/modules/providers/local_database_provider.dart';
import 'package:project/widgets/text_widget.dart';
import 'package:provider/provider.dart';
import 'package:project/modules/auth/provider/auth_provider.dart';
import 'package:project/modules/tabScreen/views/tabs.dart';
import 'package:project/utils/colors.dart';
import 'package:project/widgets/common/RoundButton.dart';
import 'package:project/widgets/common/RoundTextField.dart';
class AuthScreen extends StatelessWidget {
  AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final RunMasterService runMasterService = RunMasterService();

    return Scaffold(
      backgroundColor: ParcelColors.white,
      body: Consumer2<AuthProvider, LocalDatabaseProvider>(
        builder: (context, authProvider, localDatabaseProvider, _) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: TextWidget(
                      label: 'User Login',
                      fontWeight: FontWeight.w700,
                      textColor: ParcelColors.trueBlue,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 20),
                  RoundTextField(
                    controller: authProvider.userIDController,
                    hintText: 'User ID',
                    prefixIcon: const Icon(
                      Icons.person,
                      color: ParcelColors.catalinaBlue,
                    ),
                    isUpperCase: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter User ID';
                      } else if (!RegExp(r'^[a-zA-Z]+$').hasMatch(value)) {
                        return 'User ID must contain only alphabetic characters';
                      }
                      return null;
                    },
                  ),
                  
                  const SizedBox(height: 10),
                  RoundTextField(
                    controller: authProvider.passwordController,
                    hintText: 'Password',
                    
                    prefixIcon: const Icon(
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
                  RoundTextField(
                    controller: authProvider.stationCodeController,
                    hintText: 'Station Code',
                    prefixIcon: const Icon(
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
                  RoundButton(
                    title: Text(
                      authProvider.isLoading ? 'Logging In...' : 'Get Started',
                      style: const TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    isLoading: authProvider.isLoading,
                    onPressed: authProvider.isLoading
                        ? () {}
                        : () async {
                            authProvider.setLoading(true);
                            try {
                              print("Login started: ${DateTime.now()}");

                              final result = await runMasterService
                                  .runMasterMethod(context);

                              print("API call completed: ${DateTime.now()}");

                              if (result == "success") {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text("Login successful!")),
                                );

                                Navigator.pushNamed(context, '/home');

                                await handleLogin(context, authProvider,
                                    localDatabaseProvider);
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text("Login failed: $result")),
                                );
                              }
                            } catch (e) {
                              print("Error occurred: $e");
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("Unexpected error: $e")),
                              );
                            } finally {
                              print(
                                  "Login process finished: ${DateTime.now()}");
                              authProvider.setLoading(false);
                            }
                          },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  final String predefinedUserID = "AT";
  final String predefinedPassword = "AT";
  final String predefinedStationCode = "NDLS";

  Future<void> handleLogin(BuildContext context, AuthProvider authProvider,
      LocalDatabaseProvider localDatabaseProvider) async {
    try {
      String enteredUserID = authProvider.userIDController.text.trim();
      String enteredPassword = authProvider.passwordController.text.trim();
      String enteredStationCode =
          authProvider.stationCodeController.text.trim();

      if (enteredUserID == predefinedUserID &&
          enteredPassword == predefinedPassword &&
          enteredStationCode == predefinedStationCode) {
        await localDatabaseProvider.saveLoginInfo(
          userId: enteredUserID,
          password: enteredPassword,
          stationCode: enteredStationCode,
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const TabsScreen()),
        );
      } else {
        showErrorMessage(context, "Invalid User ID, Password, or Station Code");
      }
    } catch (e) {
      debugPrint("Error during login: $e");
      showErrorMessage(context, "Login failed. Please try again.");
    }
  }

  void showErrorMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}