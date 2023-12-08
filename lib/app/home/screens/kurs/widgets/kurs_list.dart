import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../common/controllers/blocs/kurs/kurs_bloc.dart';
import '../../../../common/models/kurs_model.dart';
import 'kurs_tile.dart';

class KursList extends StatefulWidget {
  const KursList({super.key});

  @override
  State<KursList> createState() => _KursListState();
}

class _KursListState extends State<KursList> {
  @override
  void initState() {
    context.read<KursBloc>().add(KurssGetEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<KursBloc, KursState>(
      listener: (context, state) {
        if (state.status == FormzSubmissionStatus.failure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              duration: const Duration(seconds: 10),
              action: SnackBarAction(
                onPressed: () {
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                },
                label: "Ho'p",
              ),
              backgroundColor: Theme.of(context).colorScheme.error,
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Sizda xatolik mavjud! Iltimos keyinroq urunib ko\'ring!',
                    style: GoogleFonts.nunito(
                      fontSize: 17,
                      color: Colors.white,
                    ),
                  ),
                  Text(state.errorMessage),
                ],
              ),
            ),
          );
        }
      },
      builder: (context, state) {
        if (state.status == FormzSubmissionStatus.inProgress) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state.status == FormzSubmissionStatus.success) {
          return state.kurss.isNotEmpty
              ? Expanded(
                  child: ListView.separated(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    itemBuilder: (context, index) {
                      KursModel kurs = state.kurss[index];
                      return KursTile(
                        kurs: kurs,
                      );
                    },
                    separatorBuilder: (context, index) => const SizedBox(
                      height: 10,
                    ),
                    itemCount: state.kurss.length,
                  ),
                )
              : Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: MediaQuery.sizeOf(context).height * 0.2),
                    child: Text(
                      "Ma'lumotlar mavjud emas!",
                      style: GoogleFonts.nunito(
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                );
        } else {
          return Container();
        }
      },
    );
  }
}
