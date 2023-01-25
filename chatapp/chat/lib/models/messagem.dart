class messagemod {
  final String message;
  final String id;
  messagemod(this.message, this.id);

  factory messagemod.formjson(jsondata) {
    return messagemod(jsondata['message'], jsondata['id']);
  }
}
