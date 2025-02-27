package Controller;

import java.util.ArrayList;
import java.util.List;

import Model.Aluno;
import Model.Professor;

public class Cursos {
    // atributos
    private String nomeCurso;
    private Professor professor;
    private List<Aluno> alunos;

    public Cursos(String nomeCurso, Professor professor) {
        this.nomeCurso = nomeCurso;
        this.professor = professor;
        this.alunos = new ArrayList<>();
    }

    // método para adicionar alunos

    public void adicionarAluno(Aluno aluno) {
        alunos.add(aluno);
    }

    public void exibirinformacoesCurso() {
        System.out.println("Nome do Curso:" + nomeCurso);
        System.out.println("Nome do Professor:" + professor.getNome());
        System.out.println("Lista de Alunos:");
        int i = 1;
        for (Aluno aluno : alunos) {
            System.out.println(i + ".  " + aluno.getNome());
            i++;
        }
    }
}
