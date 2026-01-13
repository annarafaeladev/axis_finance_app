import 'package:flutter/material.dart';

class FinanceHeader extends StatelessWidget {
  const FinanceHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      elevation: 4, // 👈 controla a sombra
      shadowColor: Colors.black12,
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "Saldo Atual",
                  style: TextStyle(fontSize: 14, color: Colors.black54),
                ),
                SizedBox(height: 4),
                Text(
                  "R\$ 0.000,00",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),

            const Spacer(),

            Row(
              children: const [
                _FilterChip(label: "Janeiro"),
                SizedBox(width: 12),
                _FilterChip(label: "2026"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;

  const _FilterChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFF2F2F2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(width: 12),
          const Icon(Icons.keyboard_arrow_down, size: 18),
        ],
      ),
    );
  }
}
