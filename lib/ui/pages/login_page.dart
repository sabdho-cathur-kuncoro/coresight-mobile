import 'package:coresight/blocs/auth/auth_bloc.dart';
import 'package:coresight/models/signin_form_model.dart';
import 'package:coresight/ui/widgets/button.dart';
import 'package:coresight/ui/widgets/loading.dart';
import 'package:coresight/ui/widgets/text_input.dart';
import 'package:coresight/ui/widgets/toast.dart';
import 'package:coresight/utils/request_permissions.dart';
import 'package:flutter/material.dart';
import 'package:coresight/shared/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final usernameController = TextEditingController(text: 'sabdho.kuncoro');
  final passwordController = TextEditingController(text: 'P@ssword123');

  bool validate() {
    if (usernameController.text.isEmpty || passwordController.text.isEmpty) {
      return false;
    }
    return true;
  }

  @override
  void initState() {
    super.initState();
    _checkPermissionsAndHandle();
  }

  Future<void> _checkPermissionsAndHandle() async {
    bool granted = await checkRequiredPermissions();

    if (!mounted) return; // Guard against calling after dispose

    // if (!granted) {
    //   _showPermissionDeniedDialog();
    // }
  }

  void _showPermissionDeniedDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Permissions Required'),
        content: Text(
          'Camera, location, and storage permissions are required to continue. Please enable them in settings.',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              openAppSettings();
            },
            child: Text('Open Settings'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightBackgroundColor,
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthLoading) {
            GlobalLoading.show();
          }
          if (state is AuthFailed) {
            GlobalToast.showError(state.e);
          }
          if (state is AuthSuccess) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              '/home',
              (route) => false,
            );
          }
        },
        builder: (context, state) {
          return Stack(
            children: [
              // Background Image
              Image.asset(
                'assets/images/bg_login.png',
                fit: BoxFit.cover,
                width: double.infinity,
                height: MediaQuery.of(context).size.height / 1.4,
              ),

              // Top Content
              Positioned(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter, // Gradient starts here
                      end: Alignment.bottomCenter, // and ends here
                      colors: [
                        blackColor.withValues(alpha: (0.2)),
                        Colors.black.withValues(alpha: (0.5)),
                      ],
                      stops: [0.0, 0.5],
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 48,
                      left: 24,
                      right: 24,
                    ),
                    child: Column(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'CoreSight',
                              style: primaryTextStyle.copyWith(
                                fontSize: 30,
                                fontWeight: bold,
                              ),
                            ),
                            Text(
                              'Let`s get you back to tracking sales, stock, and promotions.',
                              style: whiteTextStyle.copyWith(fontSize: 16),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Login Content
              Positioned(
                bottom: 0,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: lightBackgroundColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(24),
                    child: Column(
                      children: [
                        CustomTextInput(
                          controller: usernameController,
                          label: 'Username',
                          hint: 'type your username',
                          labelStyle: blackTextStyle.copyWith(fontWeight: bold),
                        ),
                        SizedBox(height: 16),
                        CustomTextInput(
                          controller: passwordController,
                          label: 'Password',
                          hint: '**********',
                          labelStyle: blackTextStyle.copyWith(fontWeight: bold),
                          obscureText: true,
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {},
                            child: Text(
                              'Forgot Password?',
                              style: primaryTextStyle.copyWith(fontSize: 12),
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                        Button(
                          text: 'Sign In',
                          bgColor: primaryColor,
                          styleText: whiteTextStyle.copyWith(
                            fontSize: 16,
                            fontWeight: bold,
                          ),
                          onPressed: () async {
                            if (validate()) {
                              context.read<AuthBloc>().add(
                                AuthLogin(
                                  data: SigninFormModel(
                                    username: usernameController.text,
                                    password: passwordController.text,
                                  ),
                                ),
                              );
                            } else {
                              GlobalToast.showInfo(
                                'All fields must be filled!',
                              );
                            }
                          },
                        ),
                        SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'New to CoreSight? ',
                              style: blackTextStyle.copyWith(
                                fontSize: 12,
                                fontWeight: light,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {},
                              child: Text(
                                'Create Account',
                                style: blueTextStyle.copyWith(
                                  fontSize: 12,
                                  fontWeight: light,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
