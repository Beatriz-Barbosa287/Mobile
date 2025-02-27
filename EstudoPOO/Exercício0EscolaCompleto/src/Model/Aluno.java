package Model;

public class Aluno extends Pessoa implements Avaliavel {
    // atributos

    private String matricula;
    private Double nota;

    // construtor
    public Aluno(String nome, String cpf, String matricula, Double nota) {
        super(nome, cpf);
        this.matricula = matricula;
        this.nota = nota;
    }

    // getters
    public String getMatricula() {
        return matricula;
    }

    public Double getNota() {
        return nota;
    }

    // setters

    public void setMatricula(String matricula) {
        this.matricula = matricula;
    }

    public void setNota(Double nota) {
        this.nota = nota;
    }

    // exibir informações -SobreEscrita
    @Override
    public void exibirinformacoes() {
        super.exibirinformacoes();
        System.out.println("matricula:" + matricula);
        System.out.println("nota" + nota);
    }

    @Override
    public void avaliarDesempenho() {
        if (nota >= 6) {
            System.out.println("Aprovado");
        } else {
            System.out.println("Reprovado");
        }
    }
}
