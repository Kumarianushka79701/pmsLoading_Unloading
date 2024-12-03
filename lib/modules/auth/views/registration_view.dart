


import 'package:flutter/material.dart';
import 'package:project/modules/auth/provider/auth_provider.dart';
import 'package:project/modules/tabScreen/views/tabs.dart';
import 'package:project/utils/colors.dart';
import 'package:project/widgets/common/RoundButton.dart';
import 'package:project/widgets/common/RoundTextField.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(title: const Text("Sign Up")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: authProvider.formKey,
          child: Column(
            children: [
              RoundTextField(
                hintText: 'User ID',
                prefixIcon: Icon(Icons.person, color: ParcelColors.catalinaBlue),
                isUpperCase: true,
                controller: authProvider.userIDController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a user ID';
                  } else if (!RegExp(r'^[a-zA-Z]+$').hasMatch(value)) {
                    return 'User ID must contain only alphabetic characters';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              RoundTextField(
                hintText: 'Password',
                prefixIcon: Icon(Icons.lock, color: ParcelColors.catalinaBlue),
                isUpperCase: true,
                obscureText: true,
                controller: authProvider.passwordController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a password';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              RoundTextField(
                hintText: 'Station Code',
                prefixIcon: Icon(Icons.location_on, color: ParcelColors.catalinaBlue),
                isUpperCase: true,
                controller: authProvider.stationCodeController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a station code';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              RoundButton(
                title: Text(
                  authProvider.isLoading ? 'Signing Up...' : 'Sign Up',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                isLoading: authProvider.isLoading,
                onPressed: () {
                  if (authProvider.formKey.currentState?.validate() ?? false) {
                    final userId = authProvider.userIDController.text.trim();
                    final password = authProvider.passwordController.text.trim();
                    final stationCode = authProvider.stationCodeController.text.trim();

                    authProvider.signUp(userId, password, stationCode).then((_) {
                      if (authProvider.isAuthenticated) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const TabsScreen()),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(authProvider.errorMessage ?? 'Unknown error')),
                        );
                      }
                    });
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
