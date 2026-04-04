import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_state_provider.dart';
import '../theme/app_theme.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<AppStateProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          SwitchListTile(
            title: const Text('Active Protection', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
            subtitle: const Text('Monitor screen for risky payments', style: TextStyle(fontSize: 16, color: Colors.white70)),
            value: state.isProtected,
            onChanged: (val) => state.toggleProtection(),
            activeColor: AppTheme.accentTeal,
          ),
          const Divider(color: Colors.white24, height: 32),
          ListTile(
            title: const Text('Language', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
            subtitle: Text(state.language, style: const TextStyle(fontSize: 16, color: Colors.white70)),
            trailing: const Icon(Icons.language, color: AppTheme.accentTeal, size: 28),
            onTap: () {
              // Future: Language selection dialog
            },
          ),
          const Divider(color: Colors.white24, height: 32),
          ListTile(
            title: const Text('Trusted Contact', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
            subtitle: Text(
              state.hasTrustedContact ? '${state.trustedContactName} (${state.trustedContactNumber})' : 'Not set',
              style: const TextStyle(fontSize: 16, color: Colors.white70)
            ),
            trailing: const Icon(Icons.contact_phone, color: AppTheme.accentTeal, size: 28),
            onTap: () {
               Navigator.pushNamed(context, '/onboarding'); 
            },
          ),
        ],
      ),
    );
  }
}
