import 'package:flutter/material.dart';
import 'package:project/modules/databseReport/views/table.dart';
import 'package:project/modules/forgot_account_page/provider/forgot_account_provider.dart';
import 'package:project/utils/colors.dart';
import 'package:project/widgets/button.dart';
import 'package:project/widgets/common_app_bar.dart';
import 'package:project/widgets/text_widget.dart';
import 'package:provider/provider.dart';

class ForgotAccountView extends StatelessWidget {
 
 const  ForgotAccountView({super.key});

  @override
  Widget build(BuildContext context) {
    final Width= MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: getAppBar(context, title: getForgotAccountAppBarTitle(context), onTap: () {
        Navigator.pop(context);
      }),
      
      
      body: Consumer<ForgotAccountProvider>(
        builder: (context, forgotAccountProvider, _) {  
          return
           Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key:forgotAccountProvider.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Recover your account',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Enter your registered mobile number to reset your account.',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: forgotAccountProvider.mobileNumberController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    labelText: 'Mobile Number',
                    hintText: 'Enter your mobile number',
                    prefixIcon: const Icon(Icons.phone),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your mobile number';
                    } else if (!RegExp(r'^\d{10}$').hasMatch(value)) {
                      return 'Please enter a valid 10-digit mobile number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                ParcelButton(width: Width*0.8,
                onTap: (){
                   if (forgotAccountProvider. formKey.currentState!.validate()) {
                      // Perform the account recovery process
                      final mobileNumber = forgotAccountProvider.mobileNumberController.text;
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Account recovery instructions sent to $mobileNumber'),
                        ),
                      );
                    }
                },
                label: "Recover Account",
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
Widget getForgotAccountAppBarTitle(BuildContext context) {
  
    return const TextWidget(
      label: "Forgot Account",
      textColor: ParcelColors.white,
      fontSize: 18,
      fontWeight: FontWeight.w700,
    );
  }
