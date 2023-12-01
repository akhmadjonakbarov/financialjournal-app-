// ignore_for_file: must_be_immutable

import '../models/debtor_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';

import '../../detail/detial_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/blocs/debtor/debtor_bloc.dart';

class DebtorTile extends StatelessWidget {
  final DebtorModel debtor;

  DebtorTile({super.key, required this.debtor});

  Map<String, dynamic> newDebtorData = {
    'name': '',
    'phone': '',
  };

  // flutter variables
  final _debtorUpdateFormKey = GlobalKey<FormState>();

  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Rostan ham ${debtor.name} o\'chirishni istaysizmi?',
              textAlign: TextAlign.center,
              style: GoogleFonts.nunito(fontSize: 22),
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Ink(
                  width: 80,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Theme.of(context).colorScheme.error,
                  ),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(16),
                    onTap: () {
                      context
                          .read<DebtorBloc>()
                          .add(DebtorDeleteEvent(id: debtor.id));
                      Navigator.of(context).pop();
                    },
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Ha',
                        style: GoogleFonts.nunito(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                Ink(
                  width: 80,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.green,
                  ),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(16),
                    onTap: () => Navigator.of(context).pop(),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Yo\'q',
                        style: GoogleFonts.nunito(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void _showUpdateDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Form(
          key: _debtorUpdateFormKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                initialValue: debtor.name,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
                onChanged: (name) {
                  newDebtorData['name'] = name;
                },
              ),
              const SizedBox(
                height: 5,
              ),
              TextFormField(
                initialValue: "+998 ${debtor.phonenumber}",
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "+998 99 123 45 67",
                ),
                inputFormatters: [
                  MaskedInputFormatter(
                    '+### ## ### ## ##',
                  )
                ],
                onChanged: (phone) {
                  String newPhone = phone.replaceAll('+998', '');
                  newPhone = newPhone.replaceAll(' ', '');
                  newDebtorData['phone'] = newPhone;
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Iltimos telefon raqam kiriting!';
                  } else if (value.length < 9) {
                    return 'Telefon raqam mos kelmadi!';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              Ink(
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: InkWell(
                  borderRadius: BorderRadius.circular(5),
                  onTap: () {
                    bool isValid =
                        _debtorUpdateFormKey.currentState!.validate();
                    if (isValid) {
                      _debtorUpdateFormKey.currentState!.save();
                      context.read<DebtorBloc>().add(DebtorUpdateEvent(
                            newName: newDebtorData['name'],
                            newPhone: newDebtorData['phone'],
                            id: debtor.id,
                          ));
                      Navigator.of(context).pop();
                      _debtorUpdateFormKey.currentState!.reset();
                    }
                    // context.read<Bloc>()
                  },
                  child: Align(
                    child: Text(
                      'Yangilash',
                      style: GoogleFonts.nunito(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    newDebtorData = {
      'name': debtor.name,
      'phone': debtor.phonenumber,
    };
    return ListTile(
      onTap: () {
        Navigator.of(context).push(
          CupertinoPageRoute(
            builder: (context) => DetailScreen(
              debtor: debtor,
            ),
          ),
        );
      },
      title: Text(
        debtor.name,
        style: GoogleFonts.nunito(fontSize: 18),
      ),
      subtitle: Text(
        debtor.phonenumber,
        style: GoogleFonts.nunito(fontSize: 17),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Ink(
            child: InkWell(
              borderRadius: BorderRadius.circular(100),
              onLongPress: () => _showUpdateDialog(context),
              child: const Padding(
                padding: EdgeInsets.all(5.0),
                child: Icon(
                  CupertinoIcons.pencil,
                  size: 25,
                  color: Colors.green,
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          Ink(
            child: InkWell(
              borderRadius: BorderRadius.circular(100),
              onLongPress: () => _showDeleteDialog(context),
              child: const Padding(
                padding: EdgeInsets.all(5.0),
                child: Icon(
                  CupertinoIcons.delete_simple,
                  size: 25,
                  color: Colors.red,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
