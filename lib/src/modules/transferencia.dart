class Transferencia {
  double valor;
  String conta;

  Transferencia(this.valor, this.conta);

  @override
  String toString() {
    return 'Transferência {valor: $valor, conta: $conta}';
  }
}
