class Usuario {
  final String nome;
  final String cpf;
  final String email;
  final String telefone;
  final String senha;

  Usuario(this.nome, this.cpf, this.email, this.telefone, this.senha);


  @override
  String toString() {
    return "Usuário(Nome: $nome, CPF: $cpf, e-mail: $email, telefone: $telefone)";
  }

  Map<String, dynamic> toMap() {
    return {
      'nome': nome,
      'cpf': cpf,
      'email': email,
      'telefone': telefone,
      'senha': senha,
    };
  }

  static Usuario unMap(Map<String, dynamic> usuario) {
    return Usuario(usuario['nome'], usuario['cpf'], usuario['email'], usuario['telefone'], usuario['senha']);
  }

}
