
#include <stdio.h>
#include "io.h"
#include "system.h"
#include <time.h>
#include <unistd.h>
#include <string.h>
#include "altera_avalon_pio_regs.h"
#include "altera_avalon_lcd_16207_regs.h"
#include "altera_avalon_lcd_16207.h"
#include "altera_avalon_uart_regs.h"
#include "altera_avalon_jtag_uart_regs.h"

int retornoArbitro = 99999;
int trava = 0;

main(){
    unsigned int bEntrar, bVoltar, bSubir, bDescer;
    int opcao =0;


    iniciaLCD();

    escreveLCD(0,0);

    /*Comando que coloca o modo como station*/
     comandoCWMode[] = "AT+CWMODE=1";
    mandeComando(strlen(comandoCWMode), comandoCWMode);

    /*Comando que conecta o roteador*/
    char comandoCWJAP[] = "AT+CWJAP=\"WLessLEDS\",\"HelloWorldMP31\"";
    mandeComando(strlen(comandoCWJAP), comandoCWJAP);

    /*Comando que faz a conexão TCP*/
    conectaTCP[] = "AT+CIPSTART=\"TCP\",\"192.168.1.103\",1883";
    mandeComando(strlen(conectaTCP), conectaTCP);

    /* Pacote de conexão:
     * Bits de controle (4 primeiros)
     *    1 - Tipo do pacote: conexão (0x10)
     *    2 - Tamanho do pacote após ele (0x12)
     *    3 e 4 - Tamanho do nome do pacote: 4 (0x00 e 0x04)
     * Os demais informam o nome do protocolo e o nome do dispositivo (MQTT e Nios 2)
     * */
    char pacoteConexao[] = {0x10, 0x12, 0x00, 0x04, 0x4D, 0x51, 0x54, 0x54,
                            0x04, 0x02, 0x00, 0x14, 0x00, 0x05, 0x4E, 0x69,
                            0x6F, 0x73, 0x20, 0x32};

    /*Comando que envia o pacote de conexão*/
    char comandoSendConexao[] = "AT+CIPSEND=20\r\n";
    mandeComandoSend(sizeof(comandoSendConexao), comandoSendConexao,sizeof(pacoteConexao), pacoteConexao);
    usleep(1000000);*/

    while(1){
    	trava = 0;

        bSubir = IORD(BOTAOSUBIR_BASE,0);   // botão que avança nas opções
        bDescer = IORD(BOTAODESCER_BASE,0); // botão que retorna nas opções
        bEntrar = IORD(BOTAOENTRAR_BASE,0); // botão que entra na opcao desejada
        bVoltar = IORD(BOTAOVOLTAR_BASE,0); // botão que retorna ao menu de opções

        if(bSubir){

            if(opcao == 4){
                opcao = 0;
            }
            else{
                opcao++;
            }
            escreveLCD(opcao,0);
            esperar();
        }
        else if(bDescer){
            if(opcao == 0){
                opcao = 4;
            }
            else{
                opcao--;
            }
            escreveLCD(opcao,0);
            esperar();
        }
        else if(bEntrar){
            montaEnviaPacoteMQTT(opcao); //Função utilizada para enviar as mensagens ao broker
            escreveLCD(opcao,1);
            acendeLed(opcao);
            esperar();


            enviaArbitro(opcao);


        }
        else if(bVoltar){
            escreveLCD(opcao,0);
            IOWR(LEDVERMELHO_BASE, 0, 0);
            IOWR(LEDVERDE_BASE, 0, 0);
            IOWR(LEDAZUL_BASE, 0, 0);
            usleep(900);
        }
    }
    return 0;
}

/*Função que envia requisição para o arbitro e recebe a resposta*/
void enviaArbitro(int posicao){ 

    switch(posicao){
            case 0:  //sensor 1 
                retornoArbitro = ALT_CI_ARBITRO_0(0x01,0x00);
            break;
            case 1: //sensor 2 
                retornoArbitro = ALT_CI_ARBITRO_0(0x02,0x00);
            break;
            case 2: // sensor 3 
                retornoArbitro = ALT_CI_ARBITRO_0(0x03,0x00);
            break;
            case 3://sensor 4  
                retornoArbitro = ALT_CI_ARBITRO_0(0x04,0x00);
            break;
            default:
                break;
            }


            if(retornoArbitro == 0){
                ALT_CI_ARBITRO_0(0x00,0x00); //Envia codigo do alarme
                montaEnviaPacoteMQTT(posicao);
            }
            else if(retornoArbitro != 99999){
             	montaEnviaPacoteMQTT(posicao);
            }

}


/*Função que monta o pacote a ser publicado*/
void montaEnviaPacoteMQTT(int posicao){ // tem que receber o valor do sensor p publicar

    //colocar aqui pra converter pra hexa o binario o receber o bin como parametro

    /* Pacote publish:
     * Bits de controle (4 primeiros)
     *    1 - Tipo de pacote: publish (0x30)
     *    2 - Tamanho do pacote após ele (0x19)
     *    3 - Tamanho do tópico: 11 (0x00 e 0x0B)
     * Os demais informam o nome do tópico e a mensagem:
     *   Nome do tópico: teste/teste
     *   Mensagem: SELECIONOU X (X pode ser 1,2,3,4 ou 5)
     * */
    char pacotePublish[] = {0x30, 0x19, 0x00, 0x0B, 0x74, 0x65, 0x73, 0x74, 0x65,
                            0x2f, 0x74, 0x65, 0x73, 0x74, 0x65, 0x53, 0x45, 0x4c,
                            0x45, 0x43, 0x49, 0x4f, 0x4e, 0x4f, 0x55, 0x20, 0x31};
    switch(posicao){
        case 0:
            ;
        break;
        case 1:
            pacotePublish[26] = 0x32; // Mensagem 2
        break;
        case 2:
            pacotePublish[26] = 0x33; // Mensagem 3
        break;
        case 3:
            pacotePublish[26] = 0x34; // Mensagem 4
        break;
        case 4:
            pacotePublish[26] = 0x35; // Mensagem 5
        break;
        default:
            break;
        }

    char comandoSendPublish[] = "AT+CIPSEND=27\r\n";
    usleep(1000000);
    mandeComandoSend(sizeof(comandoSendPublish), comandoSendPublish,sizeof(pacotePublish), pacotePublish);
    usleep(1000000);

}


/*Função que envia somente comandos do tipo AT+CIPSEND*/
void mandeComandoSend(int tamanhoComando, char* comando, int tamanhoPacote, char* pacote){

    alt_putstr(comando);

    char c ="";
    while(1){
        if((IORD_ALTERA_AVALON_UART_STATUS(UART_0_BASE) &(1<<7))){ //verifica se está pronto para ler
            c = IORD_ALTERA_AVALON_UART_RXDATA( UART_0_BASE );

            IOWR_ALTERA_AVALON_JTAG_UART_DATA(JTAG_UART_0_BASE,c);

            if(c == '>'){
                for(int i=0; i<tamanhoPacote; i++){
                    while(!(IORD_ALTERA_AVALON_UART_STATUS(UART_0_BASE) &(1<<6))); // verifica se está pronto para escrever
                    IOWR_ALTERA_AVALON_UART_TXDATA(UART_0_BASE, pacote[i]);
                }
                while(!(IORD_ALTERA_AVALON_UART_STATUS(UART_0_BASE) &(1<<6)));
                IOWR_ALTERA_AVALON_UART_TXDATA(UART_0_BASE, '\r');

                while(!(IORD_ALTERA_AVALON_UART_STATUS(UART_0_BASE) &(1<<6)));
                IOWR_ALTERA_AVALON_UART_TXDATA(UART_0_BASE, '\n');

                leituraUart();
                return;
            }
        }
    }*/
}

/*Função que lê o retorno dos comando AT enviados pelo esp*/
void leituraUart(){
    char c= "";
    while(1){
        if((IORD_ALTERA_AVALON_UART_STATUS(UART_0_BASE) &(1<<7))){
            c = IORD_ALTERA_AVALON_UART_RXDATA( UART_0_BASE );

            IOWR_ALTERA_AVALON_JTAG_UART_DATA(JTAG_UART_0_BASE,c);

            if(c == 'K'){
                return;
            }
        }
    }
}

/*Função que envia comandos de todos os tipos*/
void mandeComando(int tamanho, char* comando){
    alt_putstr(comando);
    alt_putstr("\r\n");

    char c ="";
    while(1){
        if((IORD_ALTERA_AVALON_UART_STATUS(UART_0_BASE) &(1<<7))){
            c = IORD_ALTERA_AVALON_UART_RXDATA( UART_0_BASE );
            IOWR_ALTERA_AVALON_JTAG_UART_DATA(JTAG_UART_0_BASE,c);

            if(c == 'K'){
                return;
            }
        }
    }
}

/*Função que acende os Leds correspondentes a opção desejada*/
void acendeLed(int opcao){
    switch(opcao){
        case 0:
            //verde
            IOWR(LEDVERMELHO_BASE, 0, 1);
            IOWR(LEDVERDE_BASE, 0, 0);
            IOWR(LEDAZUL_BASE, 0, 0);
            esperar();
            break;
        case 1:
            //vermelho
            IOWR(LEDVERMELHO_BASE, 0, 0);
            IOWR(LEDVERDE_BASE, 0, 1);
            IOWR(LEDAZUL_BASE, 0, 0);
            esperar();
            break;
        case 2:
            // azul
            IOWR(LEDVERMELHO_BASE, 0, 0);
            IOWR(LEDVERDE_BASE, 0, 0);
            IOWR(LEDAZUL_BASE, 0, 1);
            esperar();
            break;
        case 3:
            //branco
            IOWR(LEDVERMELHO_BASE, 0, 1);
            IOWR(LEDVERDE_BASE, 0, 1);
            IOWR(LEDAZUL_BASE, 0, 1);
            esperar();
            break;
        case 4:
            //magenta
            IOWR(LEDVERMELHO_BASE, 0, 0);
            IOWR(LEDVERDE_BASE, 0, 1);
            IOWR(LEDAZUL_BASE, 0, 1);
            esperar();
            break;
        default:
            break;
        }
}

void esperar(){
    usleep(100000);
}

void iniciaLCD(){
    usleep(15000);
    IOWR(LCD_16207_0_BASE, 0, 0x30);
    usleep(4100);
    IOWR(LCD_16207_0_BASE, 0, 0x30);
    usleep(100);
    IOWR(LCD_16207_0_BASE, 0, 0x30);
    usleep(5000);
    IOWR(LCD_16207_0_BASE, 0, 0x39);
    usleep(100);
    IOWR(LCD_16207_0_BASE, 0, 0x14);
    usleep(100);
    IOWR(LCD_16207_0_BASE, 0, 0x56);
    usleep(100);
    IOWR(LCD_16207_0_BASE, 0, 0x6D);
    usleep(100);
    IOWR(LCD_16207_0_BASE, 0, 0x70);
    usleep(2000);
    IOWR(LCD_16207_0_BASE, 0, 0x0C);
    usleep(2000);
    IOWR(LCD_16207_0_BASE, 0, 0x06);
    usleep(2000);
    IOWR(LCD_16207_0_BASE, 0, 0x01);
    usleep(2000);

}

/* Função que escreve a mensagem no LCD, recebendo
 * como parâmentos a posição correspondente a opção
 * desejada e um valor de seleção, podendo ser 0 ou 1
  */
void escreveLCD(int posicao, int selecao){

    char opcoes[5][15] = {"OPCAO 1", "OPCAO 2", "OPCAO 3","OPCAO 4", "OPCAO 5"} ;
    char entrar[5][15] = {"SELECIONOU 1", "SELECIONOU 2", "SELECIONOU 3", "SELECIONOU 4", "SELECIONOU 5"};
    usleep(100);

    IOWR(LCD_16207_0_BASE, 0, 0x02);//limpa display
    usleep(2000);
    IOWR(LCD_16207_0_BASE, 0, 0x01); // coloca cursor no inicio
    usleep(2000);

    if(selecao == 0){
        int i;

        for(i=0; i<strlen(opcoes);i++){
            IOWR(LCD_16207_0_BASE, 2, opcoes[posicao][i]);
            usleep(1000);
        }
    }
    else{
        int i;
        for(i=0; i<strlen(entrar);i++){
            IOWR(LCD_16207_0_BASE, 2, entrar[posicao][i]);
            usleep(1000);
        }
    }
}


