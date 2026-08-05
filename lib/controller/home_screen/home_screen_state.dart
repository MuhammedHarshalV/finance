import 'package:finance/models/daily_expense_income_model.dart';

class HomeState {
  final bool isLoading;
  final List<ExpenseHiveModel> expenseList;
  final num monthlyIncome;
  final num monthlyExpense;
  final num currentBalance;

  const HomeState({
    this.isLoading = false,
    this.expenseList = const [],
    this.monthlyIncome = 0,
    this.monthlyExpense = 0,
    this.currentBalance = 0,
  });

  HomeState copyWith({
    bool? isLoading,
    List<ExpenseHiveModel>? expenseList,
    num? monthlyIncome,
    num? monthlyExpense,
    num? currentBalance,
  }) {
    return HomeState(
      isLoading: isLoading ?? this.isLoading,
      expenseList: expenseList ?? this.expenseList,
      monthlyIncome: monthlyIncome ?? this.monthlyIncome,
      monthlyExpense: monthlyExpense ?? this.monthlyExpense,
      currentBalance: currentBalance ?? this.currentBalance,
    );
  }
}
