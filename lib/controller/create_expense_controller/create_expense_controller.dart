import 'package:finance/controller/create_expense_controller/create_expense_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/legacy.dart';

class CreateExpenseController extends StateNotifier<CreateExpenseState> {
  CreateExpenseController() : super(const CreateExpenseState());

  void updateState({
    String? transactionType,
    String? category,
    String? desc,
    bool? isSubmit,
    String? priority,
    num? amount,
  }) {
    state = state.copyWith(
      transactionType: transactionType,
      category: category,
      description: desc,
      isSubmit: isSubmit,
      priority: priority,
      amount: amount,
    );
  }

  final descriptionController = TextEditingController();
  final amountController = TextEditingController();

  void reset() {
    state = const CreateExpenseState();
  }
}

final createExpensePrrovider =
    StateNotifierProvider<CreateExpenseController, CreateExpenseState>(
      (ref) => CreateExpenseController(),
    );
