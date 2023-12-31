import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../utils/check_time.dart';
import '../../../authentication/models/user_model.dart';
import '../../../common/controllers/blocs/user/user_bloc.dart';
import '../../controllers/blocs/debtor/debtor_bloc.dart';
import '../../widgets/add_bottom_window.dart';
import '../../widgets/custom_drawer.dart';
import '../../widgets/debtor_list.dart';
import '../../widgets/profile_app_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
// dart variables
  late String time;
  bool isFirstInit = true;
  UserModel? user;

  // flutter variables
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void didChangeDependencies() {
    if (isFirstInit) {
      setState(() {
        time = checkTime();
      });
      context.read<DebtorBloc>().add(DebtorGetEvent());
    }
    isFirstInit = false;
    super.didChangeDependencies();
  }

  void showEditDebtorBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return const AddDebtorBottomSheet();
      },
    );
  }

  void _openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: const CustomDrawer(),
      body: SafeArea(
        child: Column(
          children: [
            BlocBuilder<UserBloc, UserState>(
              builder: (context, state) {
                return state.user != null
                    ? ProfileAppBar(
                        time: time,
                        user: state.user!,
                        onTap: _openDrawer,
                      )
                    : const SizedBox.shrink();
              },
            ),
            BlocConsumer<DebtorBloc, DebtorState>(
              listener: (context, state) {
                if (state.status.isFailure) {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        content: Text(
                          state.errorMessage.toString(),
                        ),
                      );
                    },
                  );
                }
              },
              builder: (context, state) {
                if (state.status.isInProgress) {
                  return Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: MediaQuery.sizeOf(context).height * 0.3),
                    child: const CircularProgressIndicator(),
                  );
                } else if (state.status.isSuccess) {
                  return state.debtors.isNotEmpty
                      ? DebtorList(debtors: state.debtors)
                      : Padding(
                          padding: EdgeInsets.symmetric(
                              vertical:
                                  MediaQuery.sizeOf(context).height * 0.38),
                          child: Text(
                            "Ma'lumotlar mavjud emas!",
                            style: GoogleFonts.nunito(
                              fontSize: 25,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        );
                } else if (state.status.isFailure) {
                  return Center(
                    child: Text(state.errorMessage),
                  );
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.small(
        onPressed: showEditDebtorBottomSheet,
        child: const Icon(
          CupertinoIcons.add,
        ),
      ),
    );
  }
}
