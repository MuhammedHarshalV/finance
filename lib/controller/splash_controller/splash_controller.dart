import 'dart:developer';

import 'package:finance/controller/splash_controller/splash_state.dart';
import 'package:finance/models/daily_expense_income_model.dart';
import 'package:finance/models/monthly_expense_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

class SplashNotifierController extends StateNotifier<SplashState> {
  SplashNotifierController() : super(const SplashState()) {
    _initialize();
  }
  @override
  void dispose() {
    log(
      'Splash controller disposed---------------------------------------------------------',
    );
    super.dispose();
  }

  Future<void> _initialize() async {
    await Future.wait([checkInitialRoute()]);
  }

  Future<void> checkInitialRoute() async {
    await Future.delayed(const Duration(seconds: 2)).then((value) async {
      await checkAndArchiveMonth();
      return state = state.copyWith(
        navigationScreen: SplashNavigationState.homeScreen,
      );
    });
  }

  //save to monthly expense hive
  Future<void> checkAndArchiveMonth() async {
    final expenseBox = await Hive.openBox("expense_box");

    if (expenseBox.isEmpty) return;

    final lastExpense = ExpenseHiveModel.fromMap(
      Map<String, dynamic>.from(expenseBox.getAt(expenseBox.length - 1)),
    );

    final lastMonth = DateFormat(
      'MM-yyyy',
    ).format(DateFormat('dd-MM-yyyy').parse(lastExpense.createdAt));

    final currentMonth = DateFormat('MM-yyyy').format(DateTime.now());

    // Same day -> nothing to do
    if (lastMonth == currentMonth) {
      log('month cannot twisted');
      return;
    }

    num totalIncome = 0;
    num totalExpense = 0;

    for (final value in expenseBox.values) {
      final expense = ExpenseHiveModel.fromMap(
        Map<String, dynamic>.from(value),
      );

      if (expense.transactionType == "Income") {
        totalIncome += expense.amount;
      } else {
        totalExpense += expense.amount;
      }
    }

    final monthBox = await Hive.openBox("monthly_expense_box");

    final monthModel = MonthlyExpenseModel(
      date: DateFormat(
        'MMMM-yyyy',
      ).format(DateFormat('dd-MM-yyyy').parse(lastExpense.createdAt)),
      income: totalIncome,
      expense: totalExpense,
    );
    log(monthModel.toMap().toString());
    // Prevent duplicate month
    final exists = monthBox.values.any((e) {
      final data = MonthlyExpenseModel.fromMap(Map<String, dynamic>.from(e));
      return data.date == monthModel.date;
    });

    if (!exists) {
      await monthBox.add(monthModel.toMap());
    }

    await expenseBox.clear();
  }
}

final splashProvider =
    StateNotifierProvider.autoDispose<SplashNotifierController, SplashState>((
      ref,
    ) {
      return SplashNotifierController();
    });

final splashScreenProvider = Provider<SplashNavigationState>((ref) {
  return ref.watch(splashProvider).navigationScreen;
});
