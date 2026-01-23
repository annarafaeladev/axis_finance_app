import 'package:axis_finance_app/features/finance/domain/entities/fixa.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewFixeExpenseModal extends StatefulWidget {
  final Fixa? entry;

  final void Function({
    required DateTime vencimento,
    required String descricao,
    required double valor,
    required String categoria,
    required bool pago
  })
  onSave;

  const NewFixeExpenseModal({super.key, this.entry, required this.onSave});

  @override
  State<NewFixeExpenseModal> createState() => _NewFixeExpenseModalState();
}

class _NewFixeExpenseModalState extends State<NewFixeExpenseModal> {
  final _formKey = GlobalKey<FormState>();

  final _categoriaController = TextEditingController();
  final _descricaoController = TextEditingController();
  final _valorController = TextEditingController();

  DateTime? _dataSelecionada;
  String _pagamentoSelecionado = 'Dinheiro';
  String _statusSelecionado = 'Pendente';
  String _categoriaSelecionado = 'Saúde';

  final List<String> tipoPagamento = ['Dinheiro', 'Pix', 'Crédito', 'Débito'];

  final List<String> status = ['Pendente', 'Pago'];

  final List<String> categoria = [
    'Beleza',
    'Roupa',
    'Saúde',
    'Alimentação',
    'Água',
    'Internet',
    'Pet',
    'Tecnologia',
    'Lazer',
    'Esportes',
    'Educação',
  ];

  final DateFormat _dateFormat = DateFormat('dd/MM/yyyy');

  @override
  void dispose() {
    _descricaoController.dispose();
    _valorController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    if (widget.entry != null) {
      _dataSelecionada = widget.entry!.vencimento;
      _descricaoController.text = widget.entry!.descricao;
      _categoriaController.text = widget.entry!.categoria;
      _statusSelecionado = widget.entry!.pago == "Pendente" ? "Pendente" : "Pago";
      _valorController.text = widget.entry!.valor
          .toStringAsFixed(2)
          .replaceAll('.', ',');
    }
  }

  Future<void> _selecionarData() async {
    final now = DateTime.now();

    final picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() => _dataSelecionada = picked);
    }
  }

  void _salvar() {
    if (!_formKey.currentState!.validate()) return;
    if (_dataSelecionada == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Selecione a data de vencimento')));
      return;
    }

    widget.onSave(
      vencimento: _dataSelecionada!,
      descricao: _descricaoController.text.trim(),
      categoria: _categoriaController.text.trim(),
      valor: double.parse(_valorController.text.replaceAll(',', '.')),
      pago: _statusSelecionado == "Pago",
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.entry == null ? 'Nova Saída Fixa' : 'Editar Saída Fixa',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 16),

        
            InkWell(
              onTap: _selecionarData,
              child: InputDecorator(
                decoration: const InputDecoration(
                  labelText: 'Data vencimento',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                  ),
                ),
                child: Text(
                  _dataSelecionada == null
                      ? 'dd/mm/yyyy'
                      : _dateFormat.format(_dataSelecionada!),
                ),
              ),
            ),

            const SizedBox(height: 12),

            /// 📝 Descrição
            TextFormField(
              controller: _descricaoController,
              decoration: const InputDecoration(
                labelText: 'Descrição',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                ),
              ),
              validator: (v) =>
                  v == null || v.isEmpty ? 'Informe a descrição' : null,
            ),

            const SizedBox(height: 12),

            /// 💰 Valor
            TextFormField(
              controller: _valorController,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: const InputDecoration(
                labelText: 'Valor',
                prefixText: 'R\$ ',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                ),
              ),
              validator: (v) {
                if (v == null || v.isEmpty) return 'Informe o valor';
                if (double.tryParse(v.replaceAll(',', '.')) == null) {
                  return 'Valor inválido';
                }

                if (double.parse(v) > 999999.99) {
                  return 'Valor máximo permitido é R\$ 999.999,99';
                }

                return null;
              },
            ),

            const SizedBox(height: 12),

            DropdownButtonFormField<String>(
              value: _categoriaSelecionado,
              items: categoria
                  .map((t) => DropdownMenuItem(value: t, child: Text(t)))
                  .toList(),
              onChanged: (v) => setState(() => _categoriaSelecionado = v!),
              decoration: const InputDecoration(
                labelText: 'Categoria',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // DropdownButtonFormField<String>(
            //   value: _pagamentoSelecionado,
            //   items: tipoPagamento
            //       .map((t) => DropdownMenuItem(value: t, child: Text(t)))
            //       .toList(),
            //   onChanged: (v) => setState(() => _pagamentoSelecionado = v!),
            //   decoration: const InputDecoration(
            //     labelText: 'Método Pagamento',
            //     border: OutlineInputBorder(
            //       borderRadius: BorderRadius.all(Radius.circular(16)),
            //     ),
            //   ),
            // ),

            const SizedBox(height: 20),

            DropdownButtonFormField<String>(
              value: _statusSelecionado,
              items: status
                  .map((t) => DropdownMenuItem(value: t, child: Text(t)))
                  .toList(),
              onChanged: (v) => setState(() => _statusSelecionado = v!),
              decoration: const InputDecoration(
                labelText: 'Status',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                ),
              ),
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF16A28C),
                ),
                onPressed: _salvar,
                child: const Text(
                  'Salvar Saída Fixa',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
