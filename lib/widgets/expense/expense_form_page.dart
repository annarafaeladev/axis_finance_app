import 'package:axis_finance_app/core/enum/form_action.dart';
import 'package:axis_finance_app/features/finance/domain/entities/saida.dart';
import 'package:axis_finance_app/widgets/common/base_form_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// ===============================
/// PÁGINA DE FORMULÁRIO DE SAÍDA
/// ===============================
class SaidaFormPage extends StatefulWidget {
  final Saida? entry;

  const SaidaFormPage({super.key, this.entry});

  @override
  State<SaidaFormPage> createState() => _SaidaFormPageState();
}

class _SaidaFormPageState extends State<SaidaFormPage> {
  final _formKey = GlobalKey<FormState>();

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

  bool get isEditing => widget.entry != null;

  @override
  void initState() {
    super.initState();

    if (widget.entry != null) {
      _dataSelecionada = widget.entry!.data;
      _descricaoController.text = widget.entry!.descricao;
      _categoriaSelecionado = widget.entry!.categoria;
      _pagamentoSelecionado = widget.entry!.metodoPagamento;
      _statusSelecionado = widget.entry!.status;
      _valorController.text = widget.entry!.valor
          .toStringAsFixed(2)
          .replaceAll('.', ',');
    }
  }

  @override
  void dispose() {
    _descricaoController.dispose();
    _valorController.dispose();
    super.dispose();
  }

  Future<void> _selecionarData() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _dataSelecionada ?? DateTime.now(),
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

    final saida = Saida(
      data: _dataSelecionada!,
      descricao: _descricaoController.text.trim(),
      categoria: _categoriaSelecionado,
      valor: double.parse(_valorController.text.replaceAll(',', '.')),
      metodoPagamento: _pagamentoSelecionado,
      status: _statusSelecionado,
      indexRow: widget.entry?.indexRow ?? -1,
    );

    Navigator.pop(
      context,
      isEditing
          ? FormResult<Saida>.update(saida)
          : FormResult<Saida>.create(saida),
    );
  }

  void _excluir() {
    Navigator.pop(context, FormResult<Saida>.delete(widget.entry!.indexRow));
  }

  @override
  Widget build(BuildContext context) {
    return BaseFormPage(
      title: isEditing ? 'Editar Saída' : 'Nova Saída',
      isEditing: isEditing,
      onSave: _salvar,
      onDelete: isEditing ? _excluir : null,
      saveLabel: isEditing ? 'Salvar Alterações' : 'Salvar Saída',
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// 🟢 TÍTULO DENTRO DO CARD
            Text(
              isEditing
                  ? "Editar informações da saída"
                  : "Preencha os dados da saída",
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
            ),

            const SizedBox(height: 20),

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
                final parsed = double.tryParse(v.replaceAll(',', '.'));
                if (parsed == null) return 'Valor inválido';
                if (parsed > 999999.99) {
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

            DropdownButtonFormField<String>(
              value: _pagamentoSelecionado,
              items: tipoPagamento
                  .map((t) => DropdownMenuItem(value: t, child: Text(t)))
                  .toList(),
              onChanged: (v) => setState(() => _pagamentoSelecionado = v!),
              decoration: const InputDecoration(
                labelText: 'Método Pagamento',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                ),
              ),
            ),
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
          ],
        ),
      ),
    );
  }
}
