import 'package:finance/controller/create_expense_controller/create_expense_controller.dart';
import 'package:finance/core/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PriorityCard extends ConsumerWidget {
  const PriorityCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final expenseState = ref.watch(createExpensePrrovider);
    final expenseController = ref.read(createExpensePrrovider.notifier);
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.appWhite),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        spacing: 10,
        children: [
          Expanded(
            child: InkWell(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              hoverColor: Colors.transparent,
              focusColor: Colors.transparent,
              onTap: () async {
                expenseController.updateState(priority: 'Low');
              },
              child: Container(
                decoration: BoxDecoration(
                  // border: Border.all(color: AppColors.appBlue),
                  borderRadius: BorderRadius.circular(30),
                  color:
                      (expenseState.priority.isEmpty ||
                          expenseState.priority == 'Low')
                      ? AppColors.appGreen
                      : null,
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      'Low',
                      style: TextStyle(
                        color:
                            (expenseState.priority.isEmpty ||
                                expenseState.priority == 'Low')
                            ? AppColors.appWhite
                            : AppColors.appBlack,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              hoverColor: Colors.transparent,
              focusColor: Colors.transparent,
              onTap: () async {
                expenseController.updateState(priority: 'Medium');
              },
              child: Container(
                decoration: BoxDecoration(
                  //border: Border.all(color: AppColors.appBlue),
                  borderRadius: BorderRadius.circular(30),
                  color: expenseState.priority == 'Medium'
                      ? Colors.orange
                      : null,
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      'Medium',
                      style: TextStyle(
                        color: expenseState.priority == 'Medium'
                            ? AppColors.appWhite
                            : AppColors.appBlack,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              hoverColor: Colors.transparent,
              focusColor: Colors.transparent,
              onTap: () async {
                expenseController.updateState(priority: 'High');
              },
              child: Container(
                decoration: BoxDecoration(
                  // border: Border.all(color: AppColors.appBlue),
                  borderRadius: BorderRadius.circular(30),
                  color: expenseState.priority == 'High'
                      ? AppColors.appRed
                      : null,
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      'High',
                      style: TextStyle(
                        color: expenseState.priority == 'High'
                            ? AppColors.appWhite
                            : AppColors.appBlack,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
