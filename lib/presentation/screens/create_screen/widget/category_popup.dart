import 'package:finance/controller/create_expense_controller/create_expense_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CategoryPickerPopup {
  // Method to display the bottom sheet
  static Future<Map<String, dynamic>?> show(BuildContext context) {
    return showModalBottomSheet<Map<String, dynamic>>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Theme.of(
        context,
      ).scaffoldBackgroundColor, // Dark background matching image
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => CategoryPopup(),
    );
  }
}

class CategoryPopup extends ConsumerWidget {
  const CategoryPopup({super.key});
  static const List<Map<String, dynamic>> _categories = [
    {'name': 'Shopping', 'icon': Icons.shopping_cart_outlined},
    {'name': 'Food', 'icon': Icons.restaurant_outlined},
    {'name': 'Phone', 'icon': Icons.smartphone_outlined},
    {'name': 'Entertainment', 'icon': Icons.sports_esports_outlined},
    {'name': 'Education', 'icon': Icons.school_outlined},
    {'name': 'Beauty', 'icon': Icons.content_cut_outlined},
    {'name': 'Sports', 'icon': Icons.directions_run_outlined},
    {'name': 'Social', 'icon': Icons.people_outline},
    {'name': 'Transportation', 'icon': Icons.directions_bus_outlined},
    {'name': 'Clothing', 'icon': Icons.checkroom_outlined},
    {'name': 'Car', 'icon': Icons.directions_car_outlined},
    {'name': 'Alcohol', 'icon': Icons.wine_bar_outlined},
    {'name': 'Cigarettes', 'icon': Icons.smoking_rooms_outlined},
    {'name': 'Electronics', 'icon': Icons.computer_outlined},
    {'name': 'Travel', 'icon': Icons.flight_outlined},
    {'name': 'Health', 'icon': Icons.monitor_heart_outlined},
    {'name': 'Pets', 'icon': Icons.pets_outlined},
    {'name': 'Repairs', 'icon': Icons.build_outlined},
    {'name': 'Housing', 'icon': Icons.home_outlined},
    {'name': 'Home', 'icon': Icons.weekend_outlined},
    {'name': 'Gifts', 'icon': Icons.card_giftcard_outlined},
    {'name': 'Donations', 'icon': Icons.volunteer_activism_outlined},
    {'name': 'Lottery', 'icon': Icons.casino_outlined},
    {'name': 'Snacks', 'icon': Icons.takeout_dining_outlined},
    {'name': 'Love', 'icon': Icons.favorite_border},
    {'name': 'Other', 'icon': Icons.more_horiz},
  ];
  static const List<Map<String, dynamic>> incomeCategories = [
    {'name': 'Salary', 'icon': Icons.account_balance_wallet_outlined},
    {'name': 'Business', 'icon': Icons.business_center_outlined},
    {'name': 'Freelance', 'icon': Icons.laptop_mac_outlined},
    {'name': 'Investment', 'icon': Icons.trending_up_outlined},
    {'name': 'Interest', 'icon': Icons.savings_outlined},
    {'name': 'Bonus', 'icon': Icons.workspace_premium_outlined},
    {'name': 'Commission', 'icon': Icons.payments_outlined},
    {'name': 'Rental Income', 'icon': Icons.home_work_outlined},
    {'name': 'Cashback', 'icon': Icons.redeem_outlined},
    {'name': 'Refund', 'icon': Icons.assignment_return_outlined},
    {'name': 'Gift', 'icon': Icons.card_giftcard_outlined},
    {'name': 'Lottery', 'icon': Icons.casino_outlined},
    {'name': 'Scholarship', 'icon': Icons.school_outlined},
    {'name': 'Pension', 'icon': Icons.elderly_outlined},
    {'name': 'Government Benefit', 'icon': Icons.account_balance_outlined},
    {'name': 'Insurance Claim', 'icon': Icons.health_and_safety_outlined},
    {'name': 'Dividends', 'icon': Icons.show_chart_outlined},
    {'name': 'Savings Withdrawal', 'icon': Icons.account_balance_wallet},
    {'name': 'Family Support', 'icon': Icons.favorite_border},
    {'name': 'Selling Items', 'icon': Icons.sell_outlined},
    {'name': 'Online Earnings', 'icon': Icons.public_outlined},
    {'name': 'Reward', 'icon': Icons.emoji_events_outlined},
    {'name': 'Profit', 'icon': Icons.monetization_on_outlined},
    {'name': 'Side Hustle', 'icon': Icons.work_outline},
    {'name': 'Other', 'icon': Icons.more_horiz},
  ];
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenHeight = MediaQuery.of(context).size.height;
    final expenseState = ref.watch(createExpensePrrovider);
    final expenseController = ref.read(createExpensePrrovider.notifier);

    return Container(
      height: screenHeight * 0.7,
      padding: const EdgeInsets.only(top: 24, left: 16, right: 16),
      child: Column(
        children: [
          // Optional drag handle indicator
          Container(
            width: 40,
            height: 4,
            margin: const EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onSurface,
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          Expanded(
            child: GridView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount:
                  (expenseState.transactionType == 'Expense' ||
                      expenseState.transactionType.isEmpty)
                  ? _categories.length
                  : incomeCategories.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4, // 4 columns as shown in the image
                crossAxisSpacing: 8,
                mainAxisSpacing: 24,
                childAspectRatio:
                    0.75, // Adjusts the height/width ratio of the grid items
              ),
              itemBuilder: (context, index) {
                final finalList =
                    (expenseState.transactionType == 'Expense' ||
                        expenseState.transactionType.isEmpty)
                    ? _categories
                    : incomeCategories;
                final category = finalList[index];
                return GestureDetector(
                  onTap: () {
                    expenseController.updateState(category: category['name']);
                    Navigator.pop(context, category);
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Circular Icon Outline
                      Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Theme.of(
                              context,
                            ).colorScheme.onSurface, // Grey outline
                            width: 1.5,
                          ),
                          color: Colors.transparent,
                        ),
                        child: Icon(
                          category['icon'] as IconData,
                          color: Theme.of(
                            context,
                          ).colorScheme.onSurface, // Off-white icon color
                          size: 26,
                        ),
                      ),
                      const SizedBox(height: 10),
                      // Category Text
                      Text(
                        category['name'] as String,
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurface,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          height: 1.1,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
