class Usuario {
  String nome;
  String cpf;
  String email;
  String telefone;

  Usuario(this.nome, this.cpf, this.email, this.telefone);

  @override
  String toString() {
    return "Usuário(Nome: $nome, CPF: $cpf, e-mail: $email, telefone: $telefone)";
  }
}
