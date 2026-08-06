import 'package:finance/core/errors/app_message.dart';
import 'package:finance/core/services/net_work_services/connection_checking.dart';
import 'package:finance/presentation/common_widgets/glass_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
// import 'package:url_launcher/url_launcher.dart'; // Uncomment if using url_launcher

class MarketOverviewCard extends ConsumerWidget {
  const MarketOverviewCard({super.key});

  // Helper method to open URLs (Requires url_launcher package)
  /*
  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $url');
    }
  }
  */

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onSurface,
        image: const DecorationImage(
          image: AssetImage('asset/image/marcket_image.webp'),
          fit: BoxFit.cover,
          // Added a dark filter to make the text pop against the bright graph
          colorFilter: ColorFilter.mode(Colors.black54, BlendMode.darken),
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Row 1: Sensex & Nifty 50
          Row(
            children: [
              Expanded(
                child: _buildDataTile(
                  context,
                  title: 'SENSEX',
                  value: '80,245.10', // Replace with dynamic data
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildDataTile(
                  context,
                  title: 'NIFTY 50',
                  value: '24,350.75', // Replace with dynamic data
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Row 2: Gold & Silver Prices
          Row(
            children: [
              Expanded(
                child: _buildDataTile(
                  context,
                  title: 'GOLD (10g)',
                  value: '₹ 72,400', // Replace with dynamic data
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildDataTile(
                  context,
                  title: 'SILVER (1kg)',
                  value: '₹ 91,250', // Replace with dynamic data
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Row 3: Navigation Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildNavButton(
                context,
                icon: Icons.language,
                label: 'BSE India',
                onTap: () async {
                  bool connect = await InternetChecker.hasConnection();
                  if (connect == true) {
                    final Uri url = Uri.parse('https://www.bseindia.com/');
                    if (await canLaunchUrl(url)) {
                      await launchUrl(
                        url,
                        mode: LaunchMode.externalApplication,
                      );
                    } else {
                      throw 'could not launch ';
                    }
                  } else {
                    // ignore: use_build_context_synchronously
                    AppMessage.show(context, 'No Network connection');
                  }
                },
              ),
              _buildNavButton(
                context,
                icon: Icons.trending_up,
                label: 'NSE India',
                onTap: () async {
                  bool connect = await InternetChecker.hasConnection();
                  if (connect == true) {
                    final Uri url = Uri.parse('https://www.nseindia.com/');
                    if (await canLaunchUrl(url)) {
                      await launchUrl(
                        url,
                        mode: LaunchMode.externalApplication,
                      );
                    } else {
                      throw 'could not launch ';
                    }
                  } else {
                    // ignore: use_build_context_synchronously
                    AppMessage.show(context, 'No Network connection');
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  // UI Helper for the Market Data Blocks
  Widget _buildDataTile(
    BuildContext context, {
    required String title,
    required String value,
  }) {
    return GlassContainer(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
      // decoration: BoxDecoration(
      color: Colors.black.withOpacity(0.2), // Glassmorphism effect
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: Colors.white.withOpacity(0.3), width: 1),
      blur: .1,
      // ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.white.withOpacity(0.8),
              fontSize: 12,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
        ],
      ),
    );
  }

  // UI Helper for the Bottom Navigation Buttons
  Widget _buildNavButton(
    BuildContext context, {
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return ElevatedButton.icon(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white.withOpacity(0.15),
        foregroundColor: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: Colors.white.withOpacity(0.3)),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      ),
      icon: Icon(icon, size: 18),
      label: Text(
        label,
        style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
      ),
    );
  }
}
