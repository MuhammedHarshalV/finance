import 'package:finance/controller/create_expense_controller/create_expense_controller.dart';

import 'package:finance/presentation/screens/create_screen/widget/category_popup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CategoryCard extends ConsumerWidget {
  const CategoryCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final expenseState = ref.watch(createExpensePrrovider);

    return InkWell(
      focusColor: Colors.transparent,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
      onTap: () {
        CategoryPickerPopup.show(context);
      },
      child: Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Theme.of(context).colorScheme.onSurface),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                (expenseState.category.isEmpty &&
                        expenseState.transactionType.isEmpty)
                    ? 'Food'
                    : (expenseState.category.isEmpty &&
                          expenseState.transactionType == 'Income')
                    ? 'Salary'
                    : (expenseState.category.isEmpty &&
                          expenseState.transactionType == 'Expense')
                    ? "Food"
                    : expenseState.category,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                ),
              ),
              Icon(
                Icons.arrow_drop_down_circle_outlined,
                color: Theme.of(context).colorScheme.onSurface,
                size: 25,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
