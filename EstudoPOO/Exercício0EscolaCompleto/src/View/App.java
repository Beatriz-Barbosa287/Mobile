package View;

import java.util.Scanner;

import Controller.Cursos;
import Model.Professor;

public class App {
    public static void main(String[] args) throws Exception {
       Scanner sc = new Scanner(System.in);
       Professor professor = new Professor(
       "José Pereira", 
       "477.964.768-56",
       15000.00);
       Cursos curso = new Cursos("Curso POO", professor);
       int operacao;
       boolean continuar=true;
       while (continuar) {
        System.out.println("Escolha a opção desejada:");
        System.out.println("1.Cadastrar Aluno");
        System.out.println("2.Informações do Curso");
        System.out.println("3.Sair");
        System.out.println("=========================");
       }
    }


}
