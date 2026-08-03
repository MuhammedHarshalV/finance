import 'package:finance/controller/create_expense_controller/create_expense_state.dart';
import 'package:flutter_riverpod/legacy.dart';

class CreateExpenseController extends StateNotifier<CreateExpenseState> {
  CreateExpenseController() : super(const CreateExpenseState());

  void updateState({
    String? transactionType,
    String? category,
    String? desc,
    bool? isSubmit,
  }) {
    state = state.copyWith(
      transactionType: transactionType,
      category: category,
      description: desc,
      isSubmit: isSubmit,
    );
  }

  void reset() {
    state = const CreateExpenseState();
  }
}

final addTransactionProvider =
    StateNotifierProvider<CreateExpenseController, CreateExpenseState>(
      (ref) => CreateExpenseController(),
    );
