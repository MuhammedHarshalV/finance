import 'package:finance/controller/create_expense_controller/create_expense_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ExpenseIncomeCard extends ConsumerWidget {
  const ExpenseIncomeCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final expenseState = ref.watch(createExpensePrrovider);
    final expenseController = ref.read(createExpensePrrovider.notifier);
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Theme.of(context).colorScheme.onSurface),
      ),
      child: Padding(
        padding: const EdgeInsets.all(0),
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
                  expenseController.updateState(
                    transactionType: 'Expense',
                    category: '',
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    // border: Border.all(color: AppColors.appBlue),
                    borderRadius: BorderRadius.circular(30),
                    color:
                        (expenseState.transactionType.isEmpty ||
                            expenseState.transactionType == 'Expense')
                        ? Theme.of(context).colorScheme.onSurface
                        : null,
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        'Expense',
                        style: TextStyle(
                          color:
                              (expenseState.transactionType.isEmpty ||
                                  expenseState.transactionType == 'Expense')
                              ? Theme.of(context).scaffoldBackgroundColor
                              : Theme.of(context).colorScheme.onSurface,
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
                  expenseController.updateState(
                    transactionType: 'Income',
                    category: '',
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    //border: Border.all(color: AppColors.appBlue),
                    borderRadius: BorderRadius.circular(30),
                    color: expenseState.transactionType == 'Income'
                        ? Theme.of(context).colorScheme.onSurface
                        : null,
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        'Income',
                        style: TextStyle(
                          color: expenseState.transactionType == 'Income'
                              ? Theme.of(context).scaffoldBackgroundColor
                              : Theme.of(context).colorScheme.onSurface,
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
      ),
    );
  }
}
