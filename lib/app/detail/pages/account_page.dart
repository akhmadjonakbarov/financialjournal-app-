import 'package:financialjournal_app/app/detail/pages/widgets/show_account.dart';
import 'package:financialjournal_app/app/home/models/debtor_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../utils/money_formatter.dart';
import '../widgets/incomes_list.dart';
import '../widgets/outlays_list.dart';
import 'controllers/blocs/income_or_outlay_bloc.dart';

class AccountPage extends StatefulWidget {
  final DebtorModel debtor;

  const AccountPage({super.key, required this.debtor});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  MoneyFormatter moneyFormatter = MoneyFormatter();

  @override
  void didChangeDependencies() {
    context.read<IncomeOrOutlayBloc>().add(OutlayGetEvent(debtorId: widget.debtor.id));
    context.read<IncomeOrOutlayBloc>().add(IncomeGetEvent(debtorId: widget.debtor.id));
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ShowAccount(sum_: 450000),
                      TabBar(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        labelStyle: GoogleFonts.nunito(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                        indicator: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          // Creates border
                          color: Colors.black,
                        ),
                        unselectedLabelColor: Colors.black,
                        splashBorderRadius: BorderRadius.circular(10),
                        indicatorSize: TabBarIndicatorSize.tab,
                        tabs: [
                          Tab(
                            height: 80,
                            child: Row(
                              children: [
                                Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(color: Colors.black),
                                    borderRadius: BorderRadius.circular(
                                      5,
                                    ),
                                  ),
                                  width: 35,
                                  height: 35,
                                  child: const Icon(
                                    CupertinoIcons.arrow_down,
                                    size: 20,
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text("Kirimlar"),
                                    Text(
                                      "${moneyFormatter.formatter(data: 25000)} UZS",
                                      style: GoogleFonts.nunito(
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          Tab(
                            height: 80,
                            child: Row(
                              children: [
                                Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black),
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(
                                      5,
                                    ),
                                  ),
                                  width: 35,
                                  height: 35,
                                  child: const Icon(
                                    CupertinoIcons.arrow_up,
                                    size: 20,
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text("Chiqimlar"),
                                    Text(
                                      "${moneyFormatter.formatter(data: 25000)} UZS",
                                      style: GoogleFonts.nunito(
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                        child: TabBarView(
                          children: [
                            BlocBuilder<IncomeOrOutlayBloc, IncomeOrOutlayState>(
                              builder: (context, state) {
                                if (state.status == FormzSubmissionStatus.inProgress) {
                                  return const Align(
                                    alignment: Alignment.center,
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (state.status == FormzSubmissionStatus.success) {
                                  return state.incomes.isNotEmpty
                                      ? IncomesList(incomes: state.incomes)
                                      : Align(
                                          child: Text(
                                            "Ma'lumotlar mavjud emas!",
                                            style: GoogleFonts.nunito(
                                              fontSize: 25,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        );
                                } else {
                                  return Container();
                                }
                              },
                            ),
                            BlocBuilder<IncomeOrOutlayBloc, IncomeOrOutlayState>(
                              builder: (context, state) {
                                if (state.status == FormzSubmissionStatus.inProgress) {
                                  return const Align(
                                    alignment: Alignment.center,
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (state.status == FormzSubmissionStatus.success) {
                                  return state.outlays.isNotEmpty
                                      ? OutlaysList(
                                          outlays: state.outlays,
                                        )
                                      : Align(
                                          child: Text(
                                            "Ma'lumotlar mavjud emas!",
                                            style: GoogleFonts.nunito(
                                              fontSize: 25,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        );
                                } else {
                                  return Container();
                                }
                              },
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
