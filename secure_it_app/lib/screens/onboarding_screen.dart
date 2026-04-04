import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_state_provider.dart';
import '../theme/app_theme.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _nameCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();

  void _completeSetup() {
    if (_nameCtrl.text.isNotEmpty && _phoneCtrl.text.isNotEmpty) {
      Provider.of<AppStateProvider>(context, listen: false)
          .setTrustedContact(_nameCtrl.text, _phoneCtrl.text);
    }
    // Navigate home if settings exist or skip
    Navigator.of(context).pushReplacementNamed('/home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 48),
              const Icon(Icons.security, size: 100, color: AppTheme.accentTeal),
              const SizedBox(height: 24),
              Text(
                'Welcome to SECURE-it',
                style: Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 32),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              const Text(
                'We need a trusted family member to notify in case of a scam attempt.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, color: Colors.white70),
              ),
              const SizedBox(height: 40),
              TextField(
                controller: _nameCtrl,
                style: const TextStyle(fontSize: 20),
                decoration: InputDecoration(
                  labelText: 'Family Member Name',
                  labelStyle: const TextStyle(fontSize: 18),
                  filled: true,
                  fillColor: Colors.white10,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
              const SizedBox(height: 24),
              TextField(
                controller: _phoneCtrl,
                keyboardType: TextInputType.phone,
                style: const TextStyle(fontSize: 20),
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                  labelStyle: const TextStyle(fontSize: 18),
                  filled: true,
                  fillColor: Colors.white10,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
              const SizedBox(height: 48),
              ElevatedButton(
                onPressed: _completeSetup,
                child: const Text('Enable Protection', style: TextStyle(fontSize: 22)),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: _completeSetup,
                child: const Text('Skip for now', style: TextStyle(fontSize: 18, color: Colors.white54)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
