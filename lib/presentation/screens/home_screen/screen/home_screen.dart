import 'package:finance/core/themes/colors.dart';
import 'package:finance/presentation/common_widgets/glass_container.dart';
import 'package:finance/presentation/screens/home_screen/widget/animation_container.dart';
import 'package:finance/presentation/screens/home_screen/widget/savings_card.dart';
import 'package:finance/presentation/screens/home_screen/widget/weeks_trend_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:math' as math;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late ScrollController _scrollController;
  bool _isBottomNavVisible = true;

  // Colors used in the design
  final Color primaryDark = const Color(0xFF161C2D);
  final Color accentMint = const Color(0xFF7CF3D3);
  final Color incomeGreen = const Color(0xFF00796B);
  final Color expenseRed = const Color(0xFFE55B5B);
  final Color textGrey = const Color(0xFF6B7280);

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        if (_isBottomNavVisible) {
          setState(() => _isBottomNavVisible = false);
        }
      } else if (_scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        if (!_isBottomNavVisible) {
          setState(() => _isBottomNavVisible = true);
        }
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                          // PersistentNavBarNavigator.pushNewScreen(
                          //   context,
                          //   screen: NotificationScreen(),
                          //   withNavBar: true,
                          //   pageTransitionAnimation:
                          //       PageTransitionAnimation.cupertino,
                          // );
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
            child: Column(
              children: [
                const SizedBox(height: 10),

                _buildTimelineHeader(),
                const SizedBox(height: 16),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: AnimatedBalanceCard(),
                ),
                const SizedBox(height: 20),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: SavingsCard(),
                ),

                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: _buildSectionHeader('Recent Transactions', 'View All'),
                ),
              ],
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            sliver: SliverList.separated(
              itemBuilder: (context, index) => _buildTransactionItem(index),
              separatorBuilder: (_, __) => const SizedBox(height: 10),
              itemCount: 10,
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: SpendingTrendsCard(
                // You can pass any number of values here, and it will draw the bars dynamically
                data: const [30.0, 55.0, 85.0, 45.0, 25.0, 90.0, 45.0],
                summaryText:
                    "You spent 15% less this week compared to last week.",
              ),
            ),
          ),

          SliverToBoxAdapter(child: SizedBox(height: 100)),

          // SliverPadding(
          //   padding: const EdgeInsets.symmetric(horizontal: 10.0),
          //   sliver: SliverList(
          //     delegate: SliverChildListDelegate([

          //       //  const SizedBox(height: 16),
          //       // Dummy list to enable scrolling

          //     ]),
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget _buildTimelineHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'TIMELINE',
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurface.withOpacity(.6),
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
      ],
    );
  }

  Widget _buildSectionHeader(String title, String actionText) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurface,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          actionText,
          style: TextStyle(
            color: AppColors.appGreen,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildTransactionItem(int index) {
    return Container(
      // margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        //color: index % 2 == 0 ? AppColors.appGreen : Colors.red,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: index % 2 == 0 ? AppColors.appGreen : Colors.red,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: index % 2 == 0
                  ? AppColors.appGreen.withValues(alpha: .5)
                  : AppColors.appRed.withValues(alpha: .5),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(Icons.shopping_bag_outlined, color: primaryDark),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Shopping',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Supermarket',
                  style: TextStyle(
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withValues(alpha: .7),
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
          Text(
            '-₹ 120.50',
            style: TextStyle(
              color: index % 2 == 0 ? AppColors.appGreen : Colors.red,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
