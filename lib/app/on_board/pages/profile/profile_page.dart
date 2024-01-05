import 'package:financialjournal_app/app/authentication/controllers/authentication_bloc/authentication_bloc.dart';
import 'package:financialjournal_app/app/common/controllers/blocs/user/user_bloc.dart';
import 'package:financialjournal_app/app/on_board/pages/profile/widgets/profile_button_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: BlocBuilder<UserBloc, UserState>(
            builder: (context, state) {
              return Column(
                children: [
                  const Text(
                    "Settings",
                    style: TextStyle(fontSize: 20),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Column(
                    children: [
                      Text(
                        state.user!.name,
                        style: GoogleFonts.nunito(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ProfileButtonTile(
                    icon: Icons.person_2_outlined,
                    title: "Account",
                    onTap: () {},
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ProfileButtonTile(
                    icon: Icons.edit,
                    title: "Theme",
                    onTap: () {},
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Divider(),
                  ProfileButtonTile(
                    icon: Icons.key,
                    title: "Privacy Policy",
                    onTap: () {},
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ProfileButtonTile(
                    icon: Icons.help_center,
                    title: "Help Center",
                    onTap: () {},
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ProfileButtonTile(
                    icon: Icons.exit_to_app_outlined,
                    title: "Log Out",
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return Container(
                            child: Wrap(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 16,
                                    right: 16,
                                    top: 10,
                                  ),
                                  child: Text(
                                    'Tizimdan chiqishni istaysizmi?',
                                    style: GoogleFonts.nunito(fontSize: 20),
                                  ),
                                ),
                                ListTile(
                                  leading: Icon(Icons.check),
                                  title: Text('Ha'),
                                  onTap: () {
                                    // Perform logout logic here
                                    Navigator.of(context)
                                        .pop(); // Close the bottom sheet
                                    context
                                        .read<AuthenticationBloc>()
                                        .add(LogoutEvent());
                                  },
                                ),
                                ListTile(
                                  leading: Icon(Icons.close),
                                  title: Text('Yo\'q'),
                                  onTap: () {
                                    Navigator.of(context)
                                        .pop(); // Close the bottom sheet
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
