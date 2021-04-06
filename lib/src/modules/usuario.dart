class Usuario {
  int id;
  String nome;
  String cpf;
  String email;
  String telefone;
  String senha;

  Usuario(this.nome, this.cpf, this.email, this.telefone, this.senha);


  @override
  String toString() {
    return "Usuário(Nome: $nome, CPF: $cpf, e-mail: $email, telefone: $telefone)";
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'cpf': cpf,
      'email': email,
      'telefone': telefone,
      'senha': senha
    };
  }
}
