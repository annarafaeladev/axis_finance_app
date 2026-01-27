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
    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FC),
      appBar: AppBar(
        title: Text(title),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              "Cancelar",

              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Expanded(
                flex: 0,
                child: Card(
                  color: Colors.white,
                  elevation: 1,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 32, 16, 48),
                    child: child,
                  ),
                ),
              ),


              Spacer(),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: onSave,
                  child: Text(saveLabel),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF16A28C),
                    foregroundColor: Colors.white,
                    elevation: 0,

                  ),
                ),
              ),

              /// 🔹 BOTÃO EXCLUIR (somente edição)
              if (isEditing && onDelete != null) ...[
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: onDelete,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Theme.of(context).colorScheme.error,
                      elevation: 0,
                      side: BorderSide(
                        color: Theme.of(context).colorScheme.error,
                      ),
                    ),
                    child: const Text("Excluir"),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
