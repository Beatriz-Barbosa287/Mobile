package Model;

public abstract class Pessoa {
    //atributos privados (encapsulamento-deixar os atributos privados e os métodos públicos)
    private String nome;
    private String cpf;

    //métodos
        //construtor
        public Pessoa(String nome, String cpf) {
            this.nome = nome;
            this.cpf = cpf;
}
    // getters (métodos publicos para "pegar" informações)
    

        public String getNome() {
            return nome;
        }

        public String getCpf() {
            return cpf;
        }
    //setters (métodos publicos para alterar informações)


        public void setNome(String nome) {
            this.nome = nome;
        }


        public void setCpf(String cpf) {
            this.cpf = cpf;
        }

    //encapsulamento tecnica:metodos publicos em privados para garantir a segurança do código

    //método exibir informações 
    public void exibirinformacoes(){
    System.out.println("nome" + nome);
    System.out.println("cpf:" + cpf);
    }
}
