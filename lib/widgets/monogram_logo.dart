import 'package:flutter/material.dart';

class MonogramLogo extends StatelessWidget {
  final double size;
  final bool showShadow;
  final String assetPath;

  const MonogramLogo({
    super.key,
    this.size = 100,
    this.showShadow = true,
    this.assetPath = 'assets/images/emerald_logo_card.png',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(size * 0.22),
        boxShadow: showShadow
            ? [
                BoxShadow(
                  color: const Color(0xFF059669).withValues(alpha: 0.18),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ]
            : null,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(size * 0.22),
        child: Image.asset(
          assetPath,
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              color: Colors.white,
              child: Center(
                child: Text(
                  'CK',
                  style: TextStyle(
                    fontSize: size * 0.4,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF059669),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
