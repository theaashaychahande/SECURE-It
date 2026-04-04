import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class WarningOverlayCard extends StatelessWidget {
  final int riskScore;
  final String title;
  final String description;
  final VoidCallback onCancel;
  final VoidCallback onContinue;

  const WarningOverlayCard({
    Key? key,
    required this.riskScore,
    required this.title,
    required this.description,
    required this.onCancel,
    required this.onContinue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isHighRisk = riskScore > 70;
    final bannerColor = isHighRisk ? AppTheme.errorRed : AppTheme.warningYellow;
    final iconData = isHighRisk ? Icons.block : Icons.warning_amber_rounded;

    return Center(
      child: Material(
        color: Colors.transparent,
        child: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          padding: const EdgeInsets.all(24.0),
          decoration: BoxDecoration(
            color: AppTheme.surfaceColor,
            borderRadius: BorderRadius.circular(16.0),
            border: Border.all(color: bannerColor, width: 2.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                blurRadius: 20,
                spreadRadius: 5,
              )
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(iconData, color: bannerColor, size: 64),
              const SizedBox(height: 16),
              Text(
                title,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(color: bannerColor),
              ),
              const SizedBox(height: 16),
              Text(
                description,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 8),
              Text(
                'Risk Score: $riskScore/100',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: isHighRisk ? AppTheme.errorRed : AppTheme.warningYellow,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: onCancel,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: bannerColor,
                    foregroundColor: isHighRisk ? Colors.white : AppTheme.primaryNavy,
                  ),
                  child: const Text('Go Back Safely', style: TextStyle(fontSize: 20)),
                ),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: onContinue,
                child: Text(
                  'I Understand, Continue',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white54,
                    decoration: TextDecoration.underline,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
