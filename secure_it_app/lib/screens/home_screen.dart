import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_state_provider.dart';
import '../theme/app_theme.dart';
import '../widgets/warning_overlay_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  void _showTestWarning(BuildContext context) {
    showDialog(
      context: context,
      barrierColor: Colors.black87,
      builder: (_) => WarningOverlayCard(
        riskScore: 92,
        title: 'High Risk Transfer Detected!',
        description: 'This UPI ID has been reported for lottery scams recently.',
        onCancel: () => Navigator.of(context).pop(),
        onContinue: () {
          Navigator.of(context).pop();
          Navigator.of(context).pushNamed('/education');
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<AppStateProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('SECURE-it', style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, size: 28),
            onPressed: () => Navigator.pushNamed(context, '/settings'),
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TweenAnimationBuilder<double>(
              tween: Tween(begin: 0.8, end: 1.0),
              duration: const Duration(seconds: 2),
              curve: Curves.easeInOut,
              builder: (context, value, child) {
                return Transform.scale(
                  scale: state.isProtected ? value : 1.0,
                  child: Container(
                    padding: const EdgeInsets.all(40),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: state.isProtected 
                        ? AppTheme.accentTeal.withOpacity(0.2) 
                        : AppTheme.errorRed.withOpacity(0.2),
                      boxShadow: state.isProtected ? [
                        BoxShadow(
                          color: AppTheme.accentTeal.withOpacity(0.2),
                          blurRadius: 40,
                          spreadRadius: 10,
                        )
                      ] : [],
                    ),
                    child: Icon(
                      state.isProtected ? Icons.shield : Icons.shield_outlined,
                      size: 120,
                      color: state.isProtected ? AppTheme.accentTeal : AppTheme.errorRed,
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 32),
            Text(
              state.isProtected ? 'You are Protected' : 'Protection Disabled',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: state.isProtected ? AppTheme.accentTeal : AppTheme.errorRed,
                fontSize: 28,
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Text(
                'SECURE-it is actively monitoring your transactions in the background.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 18),
              ),
            ),
            const SizedBox(height: 64),
            ElevatedButton.icon(
              icon: const Icon(Icons.warning_amber),
              label: const Text('Test Warning UI'),
              onPressed: () => _showTestWarning(context),
            )
          ],
        ),
      ),
    );
  }
}
