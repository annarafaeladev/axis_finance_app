import 'package:axis_finance_app/core/enum/form_action.dart';
import 'package:axis_finance_app/features/finance/domain/entities/entrada.dart';
import 'package:axis_finance_app/widgets/common/base_form_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EntradaFormPage extends StatefulWidget {
  final Entrada? entry;

  const EntradaFormPage({super.key, this.entry});

  @override
  State<EntradaFormPage> createState() => _EntradaFormPageState();
}

class _EntradaFormPageState extends State<EntradaFormPage> {
  final _formKey = GlobalKey<FormState>();

  final _descricaoController = TextEditingController();
  final _valorController = TextEditingController();

  DateTime? _dataSelecionada;
  String _tipoSelecionado = 'Salário';

  final List<String> tipos = [
    'Salário',
    'Investimento',
    '13° Salário',
    'Outros',
  ];

  final DateFormat _dateFormat = DateFormat('dd/MM/yyyy');

  bool get isEditing => widget.entry != null;

  @override
  void initState() {
    super.initState();

    if (isEditing) {
      _dataSelecionada = widget.entry!.data;
      _descricaoController.text = widget.entry!.descricao;
      _valorController.text =
          widget.entry!.valor.toStringAsFixed(2).replaceAll('.', ',');
      _tipoSelecionado = widget.entry!.tipo;
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
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Selecione a data')),
      );
      return;
    }

    final entrada = Entrada(
      data: _dataSelecionada!,
      descricao: _descricaoController.text.trim(),
      valor: double.parse(_valorController.text.replaceAll(',', '.')),
      tipo: _tipoSelecionado,
      indexRow: widget.entry?.indexRow ?? -1,
    );

    Navigator.pop(
      context,
      isEditing
          ? FormResult<Entrada>.update(entrada)
          : FormResult<Entrada>.create(entrada),
    );
  }

  void _excluir() {
    Navigator.pop(
      context,
      FormResult<Entrada>.delete(widget.entry!.indexRow),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseFormPage(
      title: isEditing ? 'Editar Entrada' : 'Nova Entrada',
      isEditing: isEditing,
      onSave: _salvar,
      onDelete: isEditing ? _excluir : null,
      saveLabel: isEditing ? 'Salvar Alterações' : 'Salvar Entrada',

      /// 🔽 CONTEÚDO DO FORMULÁRIO
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// 🟢 TÍTULO INTERNO DO CARD
            Text(
              isEditing
                  ? "Atualize os dados da entrada"
                  : "Preencha as informações da entrada",
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),

            const SizedBox(height: 32),

            /// 📅 DATA
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

            /// 📝 DESCRIÇÃO
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

            /// 💰 VALOR
            TextFormField(
              controller: _valorController,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
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

            /// 🏷 TIPO
            DropdownButtonFormField<String>(
              value: _tipoSelecionado,
              items: tipos
                  .map((t) => DropdownMenuItem(value: t, child: Text(t)))
                  .toList(),
              onChanged: (v) => setState(() => _tipoSelecionado = v!),
              decoration: const InputDecoration(
                labelText: 'Tipo de entrada',
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
