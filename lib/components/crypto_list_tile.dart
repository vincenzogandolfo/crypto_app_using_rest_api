import 'package:flutter/material.dart';

class CryptoListTile extends StatelessWidget {
  final String symbol;
  final String name;
  final double price;
  final double variation24h;

  const CryptoListTile({
    super.key,
    required this.symbol,
    required this.name,
    required this.price,
    required this.variation24h,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        symbol,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(
        name,
        style: const TextStyle(
          color: Colors.white54,
        ),
      ),
      trailing: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '\$ ${price.toStringAsFixed(2)}',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            // Una sola cifra decimale
            '${variation24h.toStringAsFixed(1)} %',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              // Se la variazione è positiva (Verde), altrimenti (Rosso)
              color: variation24h >= 0 ? Colors.green : Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}
