import 'package:alice/alice.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app/authentication/authentication_screen.dart';
import 'app/home/controllers/blocs/debtor/debtor_bloc.dart';
import 'utils/service_locator.dart/service_locator.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app/authentication/controllers/authentication_bloc/authentication_bloc.dart';
import 'app/common/blocs/user/user_bloc.dart';
import 'app/home/home_screen.dart';

final navigatorKey = GlobalKey<NavigatorState>();

Alice alice = Alice(
  navigatorKey: navigatorKey,
  showInspectorOnShake: true,
  showNotification: true,
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  runApp(
    BlocProvider(
      create: (context) => AuthenticationBloc(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<AuthenticationBloc>().add(AppStartEvent());

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => UserBloc(),
        ),
        BlocProvider(
          create: (context) => DebtorBloc(),
        ),
      ],
      child: MaterialApp(
        navigatorKey: alice.getNavigatorKey(),
        title: 'Financial App',
        home: BlocConsumer<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            if (state is AuthenticationErrorState) {
              print(state.errorMessage);
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('OK'),
                      ),
                    ],
                    content: Text(
                      "Ro'yhatdan o'tishda xatolik mavjud! Iltimos qaytadan urunib ko'ring",
                      textAlign: TextAlign.start,
                      style: GoogleFonts.nunito(
                        fontSize: 20,
                      ),
                    ),
                  );
                },
              );
            }
          },
          builder: (context, state) {
            if (state is UnAuthenticatedState) {
              return const AuthenticationScreen();
            } else if (state is AuthenticatingState) {
              return const Scaffold(
                body: SafeArea(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              );
            } else if (state is AuthenticatedState) {
              context.read<UserBloc>().add(SetUserEvent(user: state.user));
              return const HomeScreen();
            }
            return const AuthenticationScreen();
          },
        ),
      ),
    );
  }
}
