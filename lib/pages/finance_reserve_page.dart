import 'package:flutter/material.dart';
import 'package:axis_finance_app/widgets/common/card_list_dynamic.dart';
import 'package:axis_finance_app/widgets/card_reserve.dart';
import 'package:axis_finance_app/widgets/common/content_page_header.dart';

class FinanceReservePage extends StatelessWidget {
  const FinanceReservePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ContentPageHeader(
            title: "Reserva de Emergência",
            subtitle: "Gerencie sua reserva fiananceira",
            buttonText: "Novo aporte",
            color: Color(0xFF16A28C),
            onPressed: () {
              // abrir modal ou navegar
            },
          ),

          const SizedBox(height: 20),

          CardReserve(
            title: "",
            label: "6 meses de renda",
            metaTotal: 1000,
            totalAcumulado: 900,
          ),

          const SizedBox(height: 20),

      
          const SizedBox(height: 16),
          CardListDynamic(
            titulo: "Evolução da Reserva",
            emptyMessage: "Nenhum aporte registrado",
            items: [],
          ),
          const SizedBox(height: 16),
          CardListDynamic(
            titulo: "Histórico de Aportes",
            emptyMessage: "Nenhum aporte registrado",
            items: [],
          ),
        ],
      ),
    );
  }
}
