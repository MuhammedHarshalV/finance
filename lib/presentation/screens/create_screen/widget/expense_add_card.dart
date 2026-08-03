import 'package:finance/controller/create_expense_controller/create_expense_controller.dart';
import 'package:finance/core/themes/colors.dart';
import 'package:finance/presentation/screens/create_screen/widget/category_card.dart';
import 'package:finance/presentation/screens/create_screen/widget/description_card.dart';
import 'package:finance/presentation/screens/create_screen/widget/expense_income_card.dart';
import 'package:finance/presentation/screens/create_screen/widget/priority_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ExpenseAddCard extends ConsumerWidget {
  ExpenseAddCard({super.key});
  // PriorityType priority = PriorityType.medium;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final expenseState = ref.watch(createExpensePrrovider);
    final expenseController = ref.read(createExpensePrrovider.notifier);

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.appBottomNavColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionLabel('Transaction Type', context),
          const SizedBox(height: 8),
          ExpenseIncomeCard(),
          const SizedBox(height: 20),

          _buildSectionLabel('Category', context),
          const SizedBox(height: 8),
          CategoryCard(),
          const SizedBox(height: 20),

          _buildSectionLabel('Priority', context),
          const SizedBox(height: 8),
          // PrioritySelector(selected: priority, onChanged: (value) {}),
          PriorityCard(),
          const SizedBox(height: 20),
          _buildSectionLabel('Description (Optional)', context),
          const SizedBox(height: 8),
          DescriptionCard(),
        ],
      ),
    );
  }

  Widget _buildSectionLabel(String text, BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: Theme.of(context).colorScheme.onSurface,
        fontSize: 13,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
