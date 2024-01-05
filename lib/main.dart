import 'package:alice/alice.dart';
import 'package:financialjournal_app/app/detail/controllers/blocs/bloc/total_amount_bloc.dart';
import 'package:financialjournal_app/app/on_board/onboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app/authentication/authentication_screen.dart';
import 'app/authentication/controllers/authentication_bloc/authentication_bloc.dart';
import 'app/common/controllers/blocs/kurs/kurs_bloc.dart';
import 'app/common/controllers/blocs/user/user_bloc.dart';
import 'app/detail/pages/controllers/blocs/income_or_outlay_bloc.dart';

import 'app/on_board/controllers/blocs/debtor/debtor_bloc.dart';
import 'app/on_board/pages/statistics/controllers/month_report_bloc/month_report_bloc.dart';
import 'utils/service_locator.dart/service_locator.dart';

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
        BlocProvider(
          create: (context) => KursBloc(),
        ),
        BlocProvider(
          create: (context) => IncomeOrOutlayBloc(),
        ),
        BlocProvider(
          create: (context) => TotalAmountBloc(),
        ),
        BlocProvider(
          create: (context) => MonthReportBloc(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: alice.getNavigatorKey(),
        title: 'Financial App',
        home: BlocConsumer<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            // if (state is AuthenticationErrorState) {
            //   showDialog(
            //     context: context,
            //     builder: (context) {
            //       return AlertDialog(
            //         shape: RoundedRectangleBorder(
            //           borderRadius: BorderRadius.circular(16),
            //         ),
            //         actions: <Widget>[
            //           TextButton(
            //             onPressed: () {
            //               Navigator.of(context).pop();
            //             },
            //             child: const Text('OK'),
            //           ),
            //         ],
            //         content: Text(
            //           "Ro'yhatdan o'tishda xatolik mavjud! Iltimos qaytadan urunib ko'ring",
            //           textAlign: TextAlign.start,
            //           style: GoogleFonts.nunito(
            //             fontSize: 20,
            //           ),
            //         ),
            //       );
            //     },
            //   );
            // } else
            if (state is AuthUnAvailableInternet) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                  ),
                  duration: const Duration(seconds: 3),
                  backgroundColor: Theme.of(context).colorScheme.error,
                  content: Container(
                    decoration: const BoxDecoration(),
                    height: 60,
                    child: Text(
                      "Internet mavjud emas!\nIltimos internetni yoqing!",
                      style: GoogleFonts.nunito(
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              );
            } else if (state is LoginOrPasswordIncorrectState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                  ),
                  duration: const Duration(seconds: 3),
                  backgroundColor: Theme.of(context).colorScheme.error,
                  content: Container(
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(),
                    height: 35,
                    child: Text(
                      "Login yoki parol xato!",
                      style: GoogleFonts.nunito(
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
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
              return const OnBoardScreen();
            }
            return const AuthenticationScreen();
          },
        ),
      ),
    );
  }
}
