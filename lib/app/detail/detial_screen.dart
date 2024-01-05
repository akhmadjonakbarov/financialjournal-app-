// ignore_for_file: must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../on_board/controllers/blocs/debtor/debtor_bloc.dart';
import 'pages/account_page.dart';
import 'pages/add_income_page.dart';
import 'pages/add_outlay_page.dart';
import 'widgets/custom_app_bar.dart';

class DetailScreen extends StatefulWidget {
  String debtorName;
  int debtorId;

  DetailScreen({
    super.key,
    required this.debtorName,
    required this.debtorId,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  void didChangeDependencies() {
    if (widget.debtorName.isEmpty) {
      context.read<DebtorBloc>().getSingleDebtor(widget.debtorId).then((value) {
        setState(() {
          widget.debtorName = value.name;
          widget.debtorId = value.id;
        });
      });
    } else {
      context.read<DebtorBloc>().getSingleDebtor(widget.debtorId).then((value) {
        setState(() {
          widget.debtorName = value.name;
          widget.debtorId = value.id;
        });
      });
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              CustomAppBar(
                text: widget.debtorName,
                isBackButton: true,
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 5),
                height: 70,
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return TabBar(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
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
                      tabs: const [
                        Tab(
                          icon: Icon(
                            CupertinoIcons.chart_bar_square,
                          ),
                          text: 'Hisobotlar',
                        ),
                        Tab(
                          icon: Icon(
                            CupertinoIcons.add_circled,
                          ),
                          text: 'Kirim',
                        ),
                        Tab(
                          icon: Icon(
                            CupertinoIcons.minus_circle,
                          ),
                          text: 'Chiqim',
                        ),
                      ],
                    );
                  },
                ),
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    AccountPage(
                      debtorId: widget.debtorId,
                    ),
                    AddIncomePage(
                      debtorId: widget.debtorId,
                      isUpdate: false,
                    ),
                    AddOutlayPage(
                      debtorId: widget.debtorId,
                      isUpdate: false,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
