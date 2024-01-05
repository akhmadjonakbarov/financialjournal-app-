// ignore_for_file: must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../utils/money_formatter.dart';

import '../controllers/blocs/bloc/total_amount_bloc.dart';
import '../widgets/incomes_list.dart';
import '../widgets/outlays_list.dart';
import 'controllers/blocs/income_or_outlay_bloc.dart';
import 'widgets/show_account.dart';

class AccountPage extends StatefulWidget {
  final int debtorId;
  String? money;

  AccountPage({Key? key, required this.debtorId, this.money}) : super(key: key);

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  MoneyFormatter moneyFormatter = MoneyFormatter();

  @override
  void didChangeDependencies() {
    final bloc = context.read<IncomeOrOutlayBloc>();
    bloc.add(OutlayGetEvent(debtorId: widget.debtorId));
    bloc.add(IncomeGetEvent(debtorId: widget.debtorId));
    context.read<TotalAmountBloc>().add(
          GetTotalAmountEvent(
            debtorId: widget.debtorId,
          ),
        );
    super.didChangeDependencies();
  }

  void deleteTransaction(
      int transactionId, IncomeOrOutlayState state, bool isIncome) {
    double summa = 0.0;
    setState(() {
      if (isIncome) {
        state.incomes.removeWhere((element) => element.id == transactionId);
      } else {
        state.outlays.removeWhere((element) => element.id == transactionId);
      }
    });
    for (var element in isIncome ? state.incomes : state.outlays) {
      summa = summa + element.money;
    }
    setState(() {
      if (isIncome) {
        state.summaK = summa;
      } else {
        state.summaCh = summa;
      }
    });
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
                      BlocBuilder<TotalAmountBloc, TotalAmountState>(
                        builder: (context, state) {
                          if (state.status.isInProgress) {
                            return const Padding(
                              padding: EdgeInsets.symmetric(vertical: 60),
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            );
                          } else if (state.status.isSuccess) {
                            return ShowAccount(
                              sum_: state.account,
                            );
                          } else if (state.status.isFailure) {
                            return Text(state.errorMessage);
                          } else {
                            return const SizedBox.shrink();
                          }
                        },
                      ),
                      TabBar(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        labelStyle: GoogleFonts.nunito(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                        indicator: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
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
                                const Text("Kirimlar"),
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
                                const Text("Chiqimlar"),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                        child: TabBarView(
                          children: [
                            _buildTransactionList(true),
                            _buildTransactionList(false),
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

  Widget _buildTransactionList(bool isIncome) {
    return BlocBuilder<IncomeOrOutlayBloc, IncomeOrOutlayState>(
      builder: (context, state) {
        if (state.status.isInProgress) {
          return const Center(child: CircularProgressIndicator());
        } else if (state.status == FormzSubmissionStatus.success) {
          return state.incomes.isNotEmpty || state.outlays.isNotEmpty
              ? Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Umumiy:',
                            style: GoogleFonts.nunito(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '${moneyFormatter.formatter(data: isIncome ? state.summaK : state.summaCh)} UZS',
                            style: GoogleFonts.nunito(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: isIncome
                          ? IncomesList(
                              incomes: state.incomes,
                              onDelete: (id) =>
                                  deleteTransaction(id, state, true),
                            )
                          : OutlaysList(
                              outlays: state.outlays,
                              onDelete: (id) =>
                                  deleteTransaction(id, state, false),
                            ),
                    ),
                  ],
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
          return const SizedBox.shrink();
        }
      },
    );
  }
}
