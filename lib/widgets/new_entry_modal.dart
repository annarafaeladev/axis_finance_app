import 'package:axis_finance_app/features/finance/domain/entities/entrada.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewEntryModal extends StatefulWidget {
  final Entrada? entry;

  final void Function({
    required DateTime data,
    required String descricao,
    required double valor,
    required String tipo,
  })
  onSave;

  const NewEntryModal({super.key, this.entry, required this.onSave});

  @override
  State<NewEntryModal> createState() => _NewEntryModalState();

  
}

class _NewEntryModalState extends State<NewEntryModal> {
  final _formKey = GlobalKey<FormState>();

  final _descricaoController = TextEditingController();
  final _valorController = TextEditingController();

  DateTime? _dataSelecionada;
  String _tipoSelecionado = 'Salário';

  final List<String> tipos = ['Salário', 'Investimento', 'Outros'];

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
      _dataSelecionada = widget.entry!.data;
      _descricaoController.text = widget.entry!.descricao;
      _valorController.text = widget.entry!.valor
          .toStringAsFixed(2)
          .replaceAll('.', ',');
      _tipoSelecionado = widget.entry!.tipo;
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
      ).showSnackBar(const SnackBar(content: Text('Selecione a data')));
      return;
    }

    widget.onSave(
      data: _dataSelecionada!,
      descricao: _descricaoController.text.trim(),
      valor: double.parse(_valorController.text.replaceAll(',', '.')),
      tipo: _tipoSelecionado,
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
              widget.entry == null ? 'Nova Entrada' : 'Editar Entrada',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 16),

            /// 📅 Data
            InkWell(
              onTap: _selecionarData,
              child: InputDecorator(
                decoration: const InputDecoration(
                  labelText: 'Data',
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
                return null;
              },
            ),

            const SizedBox(height: 12),

            /// 🏷 Tipo
            DropdownButtonFormField<String>(
              value: _tipoSelecionado,
              items: tipos
                  .map((t) => DropdownMenuItem(value: t, child: Text(t)))
                  .toList(),
              onChanged: (v) => setState(() => _tipoSelecionado = v!),
              decoration: const InputDecoration(
                labelText: 'Tipo entrada',
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
                  'Salvar Entrada',
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
