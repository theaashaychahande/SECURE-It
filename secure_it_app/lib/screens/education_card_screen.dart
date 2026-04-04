import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class EducationCardScreen extends StatelessWidget {
  const EducationCardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scam Education'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const Icon(Icons.school, size: 100, color: AppTheme.accentTeal),
            const SizedBox(height: 24),
            Text(
              'What just happened?',
              style: Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 32),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                color: AppTheme.surfaceColor,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.white12),
              ),
              child: const Text(
                'A scammer tried to trick you into making a "Lottery Validation" transfer. Legitimate companies will NEVER ask you to make a UPI payment to receive a prize.',
                style: TextStyle(fontSize: 20, height: 1.5, color: Colors.white),
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.popUntil(context, ModalRoute.withName('/home')),
                child: const Text('Back to Safety', style: TextStyle(fontSize: 22)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
