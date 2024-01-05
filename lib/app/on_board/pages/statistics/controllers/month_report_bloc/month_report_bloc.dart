import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:financialjournal_app/app/on_board/pages/statistics/controllers/repositories/month_report_repositories.dart';
import 'package:financialjournal_app/app/on_board/pages/statistics/controllers/services/month_report_services.dart';
import 'package:formz/formz.dart';

import '../../../../../detail/models/totalamount_model.dart';

part 'month_report_event.dart';
part 'month_report_state.dart';

class MonthReportBloc extends Bloc<MonthReportEvent, MonthReportState> {
  MonthReportBloc() : super(const MonthReportState()) {
    on<GetMonthReportEvent>(_getAccount);
  }

  _getAccount(GetMonthReportEvent event, Emitter<MonthReportState> emit) async {
    TotalAmountModel incomeAmount;
    TotalAmountModel outlayAmount;
    GetMonthIncomeReportRepository getMonthIncomeReportRepository =
        GetMonthIncomeReportRepository(
      GetMonthIncomeReportService(),
    );
    GetMonthOutlayRepository getMonthOutlayReportService =
        GetMonthOutlayRepository(
      GetMonthOutlayReportService(),
    );
    double account = 0;
    emit(
      state.copyWith(
        status: FormzSubmissionStatus.inProgress,
      ),
    );
    try {
      incomeAmount = await getMonthIncomeReportRepository.getMonthIncomeReport(
        monthNumber: event.monthNumber,
      );
      outlayAmount = await getMonthOutlayReportService.getMonthOutlayReport(
        monthNumber: event.monthNumber,
      );
      account = incomeAmount.totalAmount - outlayAmount.totalAmount;
      emit(
        state.copyWith(
          status: FormzSubmissionStatus.success,
          account: account,
          monthIncome: incomeAmount.totalAmount,
          monthOutlay: outlayAmount.totalAmount,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: FormzSubmissionStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
