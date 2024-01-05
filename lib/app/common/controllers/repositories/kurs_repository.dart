import '../services/kurs_service.dart';

abstract class KursRepository {
  Future getKurss();
  Future getSingleKurs();
  Future addKurs({required double kurs});
}

class GetKurssRepository extends KursRepository {
  final GetKursService _getKursService;
  GetKurssRepository(this._getKursService);
  @override
  Future getKurss() async {
    return await _getKursService.getKurss();
  }

  @override
  Future getSingleKurs() async {
    return await _getKursService.getSingleKurs();
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class AddKursRepository extends KursRepository {
  final AddKursService _addKursService;
  AddKursRepository(this._addKursService);

  @override
  Future addKurs({required double kurs}) async {
    await _addKursService.addKurs(kurs: kurs);
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
