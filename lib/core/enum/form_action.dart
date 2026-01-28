enum FormAction { create, update, delete }

class FormResult<T> {
  final FormAction action;
  final T? data;
  final int? index;

  FormResult.create(this.data)
      : action = FormAction.create,
        index = null;

  FormResult.update(this.data)
      : action = FormAction.update,
        index = null;

  FormResult.delete(this.index)
      : action = FormAction.delete,
        data = null;
}
