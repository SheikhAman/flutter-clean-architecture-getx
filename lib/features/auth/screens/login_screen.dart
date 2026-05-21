import 'package:flutter/material.dart';
import 'package:flutter_core/core/utils/validators.dart';
import 'package:flutter_core/core/widgets/app_loader_button.dart';
import 'package:flutter_core/core/widgets/app_text_field.dart';
import 'package:flutter_core/core/widgets/language_toggle.dart';
import 'package:flutter_core/routes/app_routes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController(text: 'demo@mail.com');
  final _password = TextEditingController(text: 'password');
  final _controller = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Align(
                  alignment: Alignment.centerRight,
                  child: LanguageToggle(),
                ),
                SizedBox(height: 32.h),
                Text(
                  'welcome'.tr,
                  style: TextStyle(
                    fontSize: 28.sp,
                    fontWeight: FontWeight.w800,
                    color: scheme.primary,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  'login'.tr,
                  style: TextStyle(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 32.h),
                AppTextField(
                  controller: _email,
                  label: 'email'.tr,
                  prefixIcon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                  validator: Validators.email,
                ),
                SizedBox(height: 16.h),
                AppTextField(
                  controller: _password,
                  label: 'password'.tr,
                  prefixIcon: Icons.lock_outline,
                  obscure: true,
                  validator: Validators.required,
                ),
                SizedBox(height: 28.h),
                Obx(
                  () => AppLoaderButton(
                    label: 'login'.tr,
                    isLoading: _controller.isLoading.value,
                    icon: Icons.login,
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _controller.login(
                          email: _email.text.trim(),
                          password: _password.text,
                        );
                      }
                    },
                  ),
                ),
                SizedBox(height: 16.h),
                Center(
                  child: TextButton(
                    onPressed: () => Get.toNamed(AppRoutes.register),
                    child: Text('register'.tr),
                  ),
                ),
                SizedBox(height: 8.h),
                Center(
                  child: Text(
                    'demo_otp_hint'.tr,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: scheme.onSurfaceVariant,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
