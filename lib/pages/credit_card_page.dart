import 'package:flutter/material.dart';
import 'package:axis_finance_app/widgets/common/card_list_dynamic.dart';
import 'package:axis_finance_app/widgets/card_resume_credit_card.dart';
import 'package:axis_finance_app/widgets/common/content_page_header.dart';

class CreditCardPage extends StatelessWidget {
  const CreditCardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ContentPageHeader(
            title: "Cartão de Crédito",
            subtitle: "Gerencie seus catões e compras",
            buttonText: "Novo Cartão",
            color: Color(0xFF16A28C),
            onPressed: () {
              // abrir modal ou navegar
            },
          ),

          const SizedBox(height: 20),

          CardResumeCreditCard(
            limiteTotal: 5000,
            utilizado: 1750,
            disponivel: 3250,
          ),
          const SizedBox(height: 16),
          CardListDynamic(
            titulo: "Cartão de Crédito",
            emptyMessage: "Nenhuma compra no crédito",
            items: [],
          ),
        ],
      ),
    );
  }
}
