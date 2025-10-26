import 'package:coresight/blocs/auth/auth_bloc.dart';
import 'package:coresight/shared/theme.dart';
import 'package:coresight/ui/widgets/toast.dart';
import 'package:coresight/utils/status_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
    setStatusBar(
      color: Colors.transparent,
      iconBrightness: Brightness.dark,
      barBrightness: Brightness.light,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightBackgroundColor,
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthFailed) {
            GlobalToast.showError(state.e);
          }
          if (state is AuthInitial) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              '/signin',
              (route) => false,
            );
          }
        },
        builder: (context, state) {
          if (state is AuthSuccess) {
            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(vertical: 56, horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Profile Photo
                  Center(
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: tealColor,
                      ),
                      child: Center(
                        child: Text(
                          'JD',
                          style: whiteTextStyle.copyWith(
                            fontSize: h2,
                            fontWeight: semiBold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  // Name & Email
                  Center(
                    child: Column(
                      children: [
                        Text(
                          state.user.name ?? '',
                          style: blackTextStyle.copyWith(
                            fontSize: h2,
                            fontWeight: semiBold,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          '${state.user.username}@mail.com',
                          style: greyTextStyle.copyWith(fontSize: h4),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 24),
                  Text(
                    'Account Information',
                    style: blackTextStyle.copyWith(fontSize: h5),
                  ),
                  SizedBox(height: 10),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: whiteSecondaryColor,
                      border: BoxBorder.all(color: strokeColor, width: 1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        // Employee ID
                        Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 40,
                                  height: 40,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: whiteColor,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: SizedBox(
                                    width: 16,
                                    height: 16,
                                    child: Image.asset(
                                      'assets/icons/ic_user.png',
                                      color: blackColor,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Text(
                                  state.user.salesId ?? '',
                                  style: blackTextStyle.copyWith(fontSize: h5),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Divider(
                              height: 1,
                              thickness: 0.5,
                              color: strokeColor,
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        // Phone Number
                        Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 40,
                                  height: 40,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: whiteColor,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: SizedBox(
                                    width: 16,
                                    height: 16,
                                    child: Image.asset(
                                      'assets/icons/ic_phone.png',
                                      color: blackColor,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Text(
                                  '08123123123',
                                  style: blackTextStyle.copyWith(fontSize: h5),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Divider(
                              height: 1,
                              thickness: 0.5,
                              color: strokeColor,
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        // Role
                        Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 40,
                                  height: 40,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: whiteColor,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: SizedBox(
                                    width: 16,
                                    height: 16,
                                    child: Image.asset(
                                      'assets/icons/ic_id_card.png',
                                      color: blackColor,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Text(
                                  'Territory Sales Officer',
                                  style: blackTextStyle.copyWith(fontSize: h5),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Divider(
                              height: 1,
                              thickness: 0.5,
                              color: strokeColor,
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        // Area
                        Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 40,
                                  height: 40,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: whiteColor,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: SizedBox(
                                    width: 16,
                                    height: 16,
                                    child: Image.asset(
                                      'assets/icons/ic_map.png',
                                      color: blackColor,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Text(
                                  'Jakarta',
                                  style: blackTextStyle.copyWith(fontSize: h5),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Divider(
                              height: 1,
                              thickness: 0.5,
                              color: strokeColor,
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        // Report To
                        Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 40,
                                  height: 40,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: whiteColor,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: SizedBox(
                                    width: 16,
                                    height: 16,
                                    child: Image.asset(
                                      'assets/icons/ic_spv.png',
                                      color: blackColor,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Text(
                                  'Ada Lovelace',
                                  style: blackTextStyle.copyWith(fontSize: h5),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 24),
                  Text(
                    'Settings',
                    style: blackTextStyle.copyWith(fontSize: h5),
                  ),
                  SizedBox(height: 10),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: whiteSecondaryColor,
                      border: BoxBorder.all(color: strokeColor, width: 1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        // Change Password
                        Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 40,
                                  height: 40,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: whiteColor,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: SizedBox(
                                    width: 16,
                                    height: 16,
                                    child: Image.asset(
                                      'assets/icons/ic_password.png',
                                      color: blackColor,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Text(
                                  'Change Password',
                                  style: blackTextStyle.copyWith(fontSize: h5),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Divider(
                              height: 1,
                              thickness: 0.5,
                              color: strokeColor,
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        // FAQ
                        Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 40,
                                  height: 40,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: whiteColor,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: SizedBox(
                                    width: 16,
                                    height: 16,
                                    child: Image.asset(
                                      'assets/icons/ic_faq.png',
                                      color: blackColor,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Text(
                                  'FAQ',
                                  style: blackTextStyle.copyWith(fontSize: h5),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Divider(
                              height: 1,
                              thickness: 0.5,
                              color: strokeColor,
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        // Help
                        Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 40,
                                  height: 40,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: whiteColor,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: SizedBox(
                                    width: 16,
                                    height: 16,
                                    child: Image.asset(
                                      'assets/icons/ic_cs.png',
                                      color: blackColor,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Text(
                                  'Help',
                                  style: blackTextStyle.copyWith(fontSize: h5),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Divider(
                              height: 1,
                              thickness: 0.5,
                              color: strokeColor,
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        // Sign Out
                        GestureDetector(
                          onTap: () {
                            context.read<AuthBloc>().add(AuthLogout());
                          },
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 40,
                                  height: 40,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: redColor.withValues(alpha: (0.1)),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: SizedBox(
                                    width: 16,
                                    height: 16,
                                    child: Image.asset(
                                      'assets/icons/ic_logout.png',
                                      color: redColor,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Text(
                                  'Sign Out',
                                  style: redTextStyle.copyWith(fontSize: h5),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}
