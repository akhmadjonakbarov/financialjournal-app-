import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:financialjournal_app/app/detail/controllers/repository/total_amount_repositories.dart';
import 'package:financialjournal_app/app/detail/controllers/services/total_amount_services.dart';
import 'package:financialjournal_app/app/detail/models/totalamount_model.dart';
import 'package:formz/formz.dart';

part 'total_amount_event.dart';
part 'total_amount_state.dart';

class TotalAmountBloc extends Bloc<TotalAmountEvent, TotalAmountState> {
  TotalAmountBloc() : super(const TotalAmountState()) {
    on<GetTotalAmountEvent>(_getAccount);
  }

  _getAccount(GetTotalAmountEvent event, Emitter<TotalAmountState> emit) async {
    log("get Account was called");
    TotalAmountModel incomeAmount;
    TotalAmountModel outlayAmount;
    GetIncomeTotalAmountRepository getIncomeTotalAmountRepository =
        GetIncomeTotalAmountRepository(
      GetIncomeTotalAmountService(),
    );
    GetOutlayTotalAmountRepository getOutlayTotalAmountRepository =
        GetOutlayTotalAmountRepository(
      GetOutlayTotalAmountService(),
    );
    double account = 0;
    emit(
      state.copyWith(
        status: FormzSubmissionStatus.inProgress,
      ),
    );
    try {
      incomeAmount = await getIncomeTotalAmountRepository.getIncomeTotalAmount(
        debtorId: event.debtorId,
      );
      outlayAmount = await getOutlayTotalAmountRepository.getOutlayTotalAmount(
        debtorId: event.debtorId,
      );
      log("IncomeAccount: ${incomeAmount.totalAmount}");
      log("OutlayAccount: ${outlayAmount.totalAmount}");
      account = incomeAmount.totalAmount - outlayAmount.totalAmount;
      emit(
        state.copyWith(
          status: FormzSubmissionStatus.success,
          account: account,
        ),
      );
      log("Account: $account");
    } catch (e) {
      emit(
        state.copyWith(
          status: FormzSubmissionStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
    log("get Account was finished to call");
  }
}
