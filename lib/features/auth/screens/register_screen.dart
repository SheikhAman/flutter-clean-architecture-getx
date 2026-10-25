import 'package:flutter/material.dart';
import 'package:flutter_core/core/utils/validators.dart';
import 'package:flutter_core/core/widgets/app_loader_button.dart';
import 'package:flutter_core/core/widgets/app_text_field.dart';
import 'package:flutter_core/core/widgets/language_toggle.dart';
import 'package:flutter_core/features/auth/controllers/auth_controller.dart';
import 'package:flutter_core/routes/app_routes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController(text: 'John Doe');
  final _emailController = TextEditingController(text: 'demo@mail.com');
  final _phoneController = TextEditingController(text: '+1 555-0199');
  final _passwordController = TextEditingController(text: 'password123');
  final _confirmPasswordController = TextEditingController(text: 'password123');
  final AuthController _controller = Get.find<AuthController>();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text('register'.tr),
        actions: const [
          LanguageToggle(),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Create an Account',
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                    color: colorScheme.onSurface,
                  ),
                ),
                SizedBox(height: 6.h),
                Text(
                  'Join the Flutter Core clean architecture starter',
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
                SizedBox(height: 24.h),
                AppTextField(
                  controller: _nameController,
                  label: 'Full Name',
                  prefixIcon: Icons.person_outline,
                  validator: Validators.required,
                ),
                SizedBox(height: 16.h),
                AppTextField(
                  controller: _emailController,
                  label: 'email'.tr,
                  prefixIcon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                  validator: Validators.email,
                ),
                SizedBox(height: 16.h),
                AppTextField(
                  controller: _phoneController,
                  label: 'Phone Number',
                  prefixIcon: Icons.phone_outlined,
                  keyboardType: TextInputType.phone,
                  validator: Validators.required,
                ),
                SizedBox(height: 16.h),
                AppTextField(
                  controller: _passwordController,
                  label: 'password'.tr,
                  prefixIcon: Icons.lock_outline,
                  obscure: true,
                  validator: Validators.required,
                ),
                SizedBox(height: 16.h),
                AppTextField(
                  controller: _confirmPasswordController,
                  label: 'Confirm Password',
                  prefixIcon: Icons.lock_reset_outlined,
                  obscure: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Confirm password is required';
                    }
                    if (value != _passwordController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 28.h),
                Obx(
                  () => AppLoaderButton(
                    label: 'register'.tr,
                    isLoading: _controller.isLoading.value,
                    icon: Icons.person_add_rounded,
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _controller.register(
                          name: _nameController.text.trim(),
                          email: _emailController.text.trim(),
                          phone: _phoneController.text.trim(),
                          password: _passwordController.text,
                        );
                      }
                    },
                  ),
                ),
                SizedBox(height: 16.h),
                Wrap(
                  alignment: WrapAlignment.center,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Text(
                      'Already have an account? ',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                    TextButton(
                      onPressed: () => Get.offNamed(AppRoutes.login),
                      child: Text('login'.tr),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
