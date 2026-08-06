import 'package:finance/controller/home_screen/home_screen_state.dart';
import 'package:finance/models/daily_expense_income_model.dart';

import 'package:flutter_riverpod/legacy.dart';
import 'package:hive/hive.dart';

class HomeController extends StateNotifier<HomeState> {
  HomeController() : super(const HomeState());

  Future<void> fetchExpenses() async {
    state = state.copyWith(isLoading: true);
    String boxName = "expense_box";
    final box = await Hive.openBox(boxName);

    final List<ExpenseHiveModel> expenses = box.values
        .map((e) => ExpenseHiveModel.fromMap(Map<String, dynamic>.from(e)))
        .toList();
    num monthlyIncome = 0;
    num monthlyExpense = 0;
    for (final expense in expenses) {
      if (expense.transactionType.toLowerCase() == 'expense') {
        monthlyExpense += expense.amount;
      } else {
        monthlyIncome += expense.amount;
      }
    }

    state = state.copyWith(
      expenseList: expenses.reversed.toList(),
      isLoading: false,
      monthlyExpense: monthlyExpense,
      monthlyIncome: monthlyIncome,
      currentBalance: monthlyIncome - monthlyExpense,
    );
  }


  //delete expense
  Future<void> deleteExpense(int index) async {
    String boxName = "expense_box";

    final box = await Hive.openBox(boxName);
    final hiveIndex = box.length - 1 - index;
    await box.deleteAt(hiveIndex);
    await fetchExpenses();
  }
}

final homeProvider = StateNotifierProvider<HomeController, HomeState>(
  (ref) => HomeController()..fetchExpenses(),
);
