import java.util.Scanner;

public class CalculadoraSimples {
    // atributos(características)
    double numero1, numero2;
    double resultado;
    int operacao;
    boolean continuar = true;
    // construtor (Instânciamento)-Padrão=vazio

    // métodos (ações)-
    // soma
    public double soma(double a, double b) { // parâmetros do método soma somente
        return a + b;
    }

    // subtracao
    public double sub(double a, double b) { // parâmetros do método sub. somente
        return a - b;
    }

    // multiplicacao
    public double multip(double a, double b) { // parâmetros do método multip. somente
        return a * b;
    }

    // divisao
    public double divisao(double a, double b) { // parâmetros do método divisao somente
        return a / b;
    }

    // menu
    public void menu() {
        Scanner sc = new Scanner(System.in);

        do {
            System.out.println("======CALCULADORA SIMPLES======");
            System.out.println("Escolha a Operação Desejada");
            System.out.println("1. Adição");
            System.out.println("2. Subtração");
            System.out.println("3. Multiplicação");
            System.out.println("4. Divisão");
            System.out.println("5. Sair");
            System.out.println("===============================");
            operacao = sc.nextInt();
            switch (operacao) {
                case 1:
                    System.out.println("Informe o 1º Número:");
                    numero1 = sc.nextInt();
                    System.out.println("Informe o 2º Número:");
                    numero2 = sc.nextInt();
                    resultado = soma(numero1, numero2);
                    System.out.println("O resultado é:" + resultado);
                    break;
                case 2:
                    System.out.println("Informe o 1º Número:");
                    numero1 = sc.nextInt();
                    System.out.println("Informe o 2º Número:");
                    numero2 = sc.nextInt();
                    resultado = sub(numero1, numero2);
                    System.out.println("O resultado é:" + resultado);
                    break;
                case 3:
                    System.out.println("Informe o 1º Número:");
                    numero1 = sc.nextInt();
                    System.out.println("Informe o 2º Número:");
                    numero2 = sc.nextInt();
                    resultado = multip(numero1, numero2);
                    System.out.println("O resultado é:" + resultado);
                    break;
                case 4:
                    System.out.println("Informe o 1º Número:");
                    numero1 = sc.nextInt();
                    System.out.println("Informe o 2º Número:");
                    numero2 = sc.nextInt();
                    if (numero2 == 0) {
                        System.out.println("NÃO DIVIDIRÁS POR ZERO!");
                    } else {
                        resultado = divisao(numero1, numero2);
                        System.out.println("O resultado é:" + resultado);
                    }
                    break;
                case 5:
                    System.out.println("Saindo... BYE");
                    continuar = false;
                    break;
                default:
                    System.out.println("Escolha uma Operação Válida!");
                    break;
            }

        } while (continuar);
        sc.close();
    }
}
