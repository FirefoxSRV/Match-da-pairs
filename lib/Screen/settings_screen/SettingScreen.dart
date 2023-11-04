import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mem_game/Material_components/material_alert_dialog.dart';
import 'package:mem_game/Screen/settings_screen/setting_screen_utils/custom_text_button.dart';
import 'package:mem_game/Screen/settings_screen/setting_screen_utils/google_logic.dart';
import 'package:mem_game/Screen/settings_screen/setting_screen_utils/sign_in_button.dart';
import 'package:mem_game/constants.dart';
import '../../Material_components/material_switch.dart';
import 'setting_screen_utils/custom_circular_progress_indicator.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isSigningIn = false;

  @override
  Widget build(BuildContext context) {
    bool but = true;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: LayoutBuilder(builder: (context, constraints) {
        late double containerHeight = constraints.maxHeight;
        late double containerWidth = constraints.maxWidth;
        return CustomScrollView(
          slivers: [
            SliverAppBar(
                leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                ),
                backgroundColor: Theme.of(context).colorScheme.background,
                bottom: PreferredSize(
                    preferredSize: const Size(0, 40),
                    child: Text(
                      "Settings ",
                      style: GoogleFonts.quicksand(fontSize: 40.0, fontWeight: FontWeight.w500, color: Theme.of(context).colorScheme.tertiary),
                    ))),
            SliverToBoxAdapter(
                child: SizedBox(
              height: containerHeight / 28.6,
            )),
            SliverToBoxAdapter(
                child: Divider(
              endIndent: 10,
              indent: 10,
              color: Theme.of(context).colorScheme.outline,
            )),
            SliverToBoxAdapter(
              child: SizedBox(
                height: containerHeight / 50,
              ),
            ),
            SliverToBoxAdapter(
              child: CustomTextButton(
                onPressed: () {},
                content: "The data of your cards are stored locally and secured using your fingerprint .",
                title: 'Store your data locally !',
                containerWidth: containerWidth,
                containerHeight: containerHeight,
                fontAwesomeIcon: FontAwesomeIcons.folder,
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: containerHeight / 30.26,
              ),
            ),
            SliverToBoxAdapter(
              child: SignInButton(
                onPressed: () async {
                  setState(() {
                    _isSigningIn = true;
                  });

                  signingInLoader(context, "Signing in...");

                  User? user;
                  try {
                    user = await signInWithGoogle(_googleSignIn, _auth);
                  } catch (error) {
                    print(error);
                    showDialog(context: context, builder:(dialogContext) {
                      return OpenMaterialAlertDialog( title: 'Cannot Sign In', containerHeight: containerHeight,content: 'An error occurred while signing in with Google',);
                    });
                  } finally {
                    Navigator.of(context, rootNavigator: true).pop();
                  }

                  if (user == null) {
                    showDialog(context: context, builder:(dialogContext) {
                      return OpenMaterialAlertDialog(title: 'Cannot Sign In', containerHeight: containerHeight,content: 'An error occurred while signing in with Google',);
                    });
                  } else {
                    print(user.email);
                  }

                  setState(() {
                    _isSigningIn = false;
                  });
                },
                title: _isSigningIn?"Signing in .....":"Sign In with Google",
                fontAwesomeIcon: FontAwesomeIcons.google,
                containerWidth: containerWidth,
                containerHeight: containerHeight,
                content: 'You have not yet signed in. Sign in to sync across devices',
                isLoading: _isSigningIn,
              ),
            ),
            SliverToBoxAdapter(
              child: Center(
                child: MaterialSwitch(value: but, onChanged: (but) {}),
              ),
            )
          ],
        );
      }),
    );
  }
}
