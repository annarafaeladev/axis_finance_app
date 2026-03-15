import 'package:axis_finance_app/features/finance/domain/entities/entrada.dart';
import 'package:flutter/material.dart';

class CardListDynamic extends StatelessWidget {
  final String titulo;
  final List<Entrada> items;
  final String emptyMessage;
  final void Function(Entrada item)? onPressed;
  final void Function(Entrada item)? onPressedUpdateItem;

  const CardListDynamic({
    super.key,
    required this.titulo,
    required this.items,
    this.emptyMessage = "Nenhuma entrada registrada",
    this.onPressed,
    this.onPressedUpdateItem,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Título
          Text(
            titulo,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 12),

          // Lista ou vazio
          if (items.isEmpty)
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 24),
                child: Text(
                  emptyMessage,
                  style: TextStyle(color: Colors.grey.shade500, fontSize: 14),
                ),
              ),
            )
          else
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: items.length,
              separatorBuilder: (_, __) => const Divider(height: 16),
              itemBuilder: (context, index) {
                final item = items[index];
                return _ItemRow(item: item, onPressed: onPressed, onPressedUpdateItem: onPressedUpdateItem,);
              },
            ),
        ],
      ),
    );
  }
}

class _ItemRow extends StatelessWidget {
  final Entrada item;
  final void Function(Entrada item)? onPressed;
  final void Function(Entrada item)? onPressedUpdateItem;
  
  const _ItemRow({required this.item, required this.onPressed, required this.onPressedUpdateItem});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          item.valor.toString(),
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 4),
        Text(
          item.descricao,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            Text(
              item.tipo,
              style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
            ),
            Spacer(),
            IconButton(
              icon: const Icon(Icons.edit),
              color: Colors.amber,
              onPressed: () {
                if (onPressedUpdateItem != null) {
                  onPressedUpdateItem!(item);
                }
              },
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              color: Colors.red,
              onPressed: () {
                if (onPressed != null) {
                  onPressed!(item);
                }
              },
            ),
          ],
        ),
      ],
    );
  }
}
