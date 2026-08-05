import 'dart:developer';

import 'package:finance/controller/bottom_nav_controller/bottom_nav_controller.dart';

import 'package:finance/presentation/common_widgets/glass_container.dart';
import 'package:finance/presentation/screens/bottom_nav_screen/widget/bottom_nav_items.dart';
import 'package:finance/presentation/screens/create_screen/screen/create_screen.dart';
import 'package:finance/presentation/screens/home_screen/screen/home_screen.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class BottomNavScreen extends ConsumerWidget {
  const BottomNavScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    log('rebuild nav screen');

    final index = ref.watch(bottomNavProvider.select((e) => e.currentIndex));

    final pages = const [HomeScreen(), SizedBox(), SearchPage()];

    return SafeArea(
      top: false,
      child: Scaffold(
        extendBody: true,
        extendBodyBehindAppBar: true,
        body: IndexedStack(index: index, children: pages),
        bottomNavigationBar: GlassContainer(
          blur: 10,
          margin: const EdgeInsets.only(bottom: 10, left: 30, right: 30),
          child: Row(
            children: [
              BottomNavItems(icon: Icons.home, title: "Home", index: 0),

              BottomNavItems(
                icon: Icons.add_circle_outline,
                title: "Create",
                index: 1,
                onTap: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const NewTransactionScreen(),
                    ),
                  );

                  // When returning from Create
                  ref.read(bottomNavProvider.notifier).changeIndex(0);
                },
              ),
              BottomNavItems(
                icon: Icons.leaderboard_outlined,
                title: "History",
                index: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Search")),
      body: ListView.builder(
        itemCount: 30,
        itemBuilder: (_, i) {
          return ListTile(title: Text("Item $i"));
        },
      ),
    );
  }
}
