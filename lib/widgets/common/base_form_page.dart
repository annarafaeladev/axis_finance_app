import 'package:flutter/material.dart';

class BaseFormPage extends StatelessWidget {
  final String title;
  final Widget child;
  final VoidCallback onSave;
  final VoidCallback? onDelete;
  final bool isEditing;
  final String saveLabel;

  const BaseFormPage({
    super.key,
    required this.title,
    required this.child,
    required this.onSave,
    this.onDelete,
    this.isEditing = false,
    this.saveLabel = 'Salvar',
  });

  @override
  Widget build(BuildContext context) {
    void cancel() {
      Navigator.pop(context);
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FC),
      appBar: AppBar(
        title: Text(title),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            onPressed: () => isEditing ? onDelete?.call() : onSave(),
            icon: isEditing ? Icon(Icons.delete) : Icon(Icons.add_circle_outline),
            color: isEditing ? Colors.red : Color(0xFF16A28C),
          ),
        ],
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                color: Colors.white,
                elevation: 1,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 32, 16, 32),
                  child: child, // 🔹 Seu formulário
                ),
              ),

              const SizedBox(height: 24),

              /// 🔹 BOTÃO SALVAR (AGORA ROLA)
              SizedBox(
                height: 48,
                child: ElevatedButton(
                  onPressed: onSave,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF16A28C),
                    foregroundColor: Colors.white,
                    elevation: 0,
                  ),
                  child: Text(saveLabel),
                ),
              ),

              /// 🔹 BOTÃO EXCLUIR (AGORA ROLA)
              if (isEditing && onDelete != null) ...[
                const SizedBox(height: 12),
                SizedBox(
                  height: 48,
                  child: ElevatedButton(
                    onPressed: cancel,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Theme.of(context).colorScheme.error,
                      elevation: 0,
                      side: BorderSide(
                        color: Theme.of(context).colorScheme.error,
                      ),
                    ),
                    child: const Text("Cancelar"),
                  ),
                ),
              ],

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
