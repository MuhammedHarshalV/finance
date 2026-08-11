import 'package:finance/controller/home_screen/home_screen_controller.dart';
import 'package:finance/core/themes/colors.dart';
import 'package:finance/presentation/common_widgets/glass_container.dart';
import 'package:finance/presentation/screens/home_screen/widget/monyhly_expense_container.dart';
import 'package:finance/presentation/screens/home_screen/widget/expense_income_card.dart';
import 'package:finance/presentation/screens/home_screen/widget/marcket_overview_card.dart';
import 'package:finance/presentation/screens/home_screen/widget/weeks_trend_card.dart';
import 'package:finance/presentation/screens/monthly_all_transaction/screen/monthly_all_transaction_screen.dart';
import 'package:finance/presentation/screens/profile_screen/screen/profile_screen.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeState = ref.watch(homeProvider);
    final homeController = ref.read(homeProvider.notifier);

    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      body: CustomScrollView(
        slivers: [
          // HIDING TOP APP BAR
          SliverAppBar(
            floating: true, // Makes it appear as soon as you scroll up
            pinned: false, // Ensures it scrolls out of view completely
            snap: true, // Snaps into full view when scrolling up
            elevation: 4,
            shadowColor: Colors.black45,
            expandedHeight: 70.0, // Slightly taller for a premium feel
            backgroundColor:
                Colors.transparent, // Required to show the gradient
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF1A2980), // Deep stylish blue
                    Color(0xFF26D0CE), // Vibrant teal
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
              ),
            ),
            title: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.account_balance_wallet,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                const Text(
                  'FinanceTrack',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
            actions: [
              GlassContainer(
                border: Border.all(color: AppColors.appWhite),
                borderRadius: BorderRadius.circular(360),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    spacing: 10,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProfileScreen(),
                            ),
                          );
                        },
                        child: Icon(
                          Icons.person_2_outlined,
                          color: AppColors.appWhite,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 15),
            ],
          ),
          // BODY CONTENT
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),

                  Text(
                    'TIMELINE',
                    style: TextStyle(
                      color: Theme.of(
                        context,
                      ).colorScheme.onSurface.withOpacity(.6),
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Today, 2 May 2026',

                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurface,
                      fontSize: 26,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 16),

                  MonthDetailsCard(),
                  const SizedBox(height: 20),

                  AnimattedSensexCard(),

                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Recent Transactions',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurface,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      InkWell(
                        focusColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  MonthlyAllTransactionScreen(),
                            ),
                          );
                        },
                        child: Text(
                          "View All",
                          style: TextStyle(
                            color: AppColors.appGreen,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            sliver: SliverList.separated(
              itemBuilder: (context, index) => ExpenseIncomeCards(index: index),
              separatorBuilder: (_, __) => const SizedBox(height: 10),
              itemCount: homeState.expenseList.length >= 10
                  ? 10
                  : homeState.expenseList.length,
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: SpendingTrendsCard(
                // You can pass any number of values here, and it will draw the bars dynamically
                data: homeState.monthGraph,
                summaryText: homeController.getSpendingTrend(
                  homeState.monthExpense.length >= 2
                      ? homeState.monthExpense.sublist(
                          homeState.monthExpense.length - 2,
                        )
                      : homeState.monthExpense,
                ),
              ),
            ),
          ),

          SliverToBoxAdapter(child: SizedBox(height: 100)),
        ],
      ),
    );
  }
}
