import 'package:financialjournal_app/app/detail/pages/account_page.dart';
import 'package:financialjournal_app/app/detail/pages/add_income_page.dart';
import 'package:financialjournal_app/app/detail/pages/add_outlay_page.dart';

import 'package:google_fonts/google_fonts.dart';

import '../home/models/debtor_model.dart';

import '../home/widgets/custom_app_bar.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  final DebtorModel debtor;

  const DetailScreen({super.key, required this.debtor});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              CustomAppBar(
                debtor: widget.debtor,
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 5),
                height: 70,
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return TabBar(
                      padding: EdgeInsets.symmetric(horizontal: 5),
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
                    AccountPage(debtor: widget.debtor),
                    AddIncomePage(),
                    AddOutlayPage(),
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
