module arbitro(

    
    input clk,    // CPU's master-input clk <required for multi-cycle>
    input reset,  // CPU's master asynchronous reset <required for multi-cycle>
    input clk_en, // Clock-qualifier <required for multi-cycle>
    input start,  // True when this instr. issues <required for multi-cycle>
    input [31:0] dataa,  // operand A <always required>
    
    input rx,  //Barramento
    output reg tx, //Barramento
    
    
    output reg [31:0] result, // result <always required>
    output reg done,   // True when instr. completes <required for variable muli-cycle>
	 output reg        [3:0]stateReceptor, //4 bits para 12 em decimal
	 output reg [3:0]stateVerificador,
	 output reg [3:0]stateEnvio,
	 output reg  [15:0]pacotes
	 
    
    
);


    //Estados da m�quina de estados que recebe os pacotes
    parameter Start = 0, bit0 = 1, bit1 = 2, bit2 = 3, bit3 = 4, bit4 = 5, bit5 = 6, bit6 = 7, bit7 = 8, stop = 9, verificacaoAlarme = 10, alarme1 = 11;
    

    
    //Estados da m�quina de estados do �rbitro
    parameter checkTamanho = 0, checksum = 1, enviarNIOS = 2, limparRegs = 3, verificarAlarme = 4, alarme2 = 5;
    
    
	 
	

	 integer travaReceptor = 0;
	 integer travaEnvio = 0;
		
    
    //basico
    
    integer i=0;
    //integer cancelaAlarme 0;
    integer desbloqueiaAlarme=0;
    integer numPacotes=0;
    
    //Arbitro
    wire  [7:0]chave;
    reg  [7:0]resultadoXOR;
	 wire [7:0]checkPacote;

	 
	 
    
	 assign chave = 8'b00110111; //Valor da chave   /// adicionei o assign
	 
	 
	 initial begin
	 
		 stateReceptor = Start;
		 stateVerificador = checkTamanho;
		 stateEnvio = Start;
		 
		 done <= 0;
		 
	 
	 
	 end 
	

    
    
    
														
	 always @(posedge clk)begin // n pode colocar sequencial junto com uma entrada comum // tirei o rx
    
		if(travaReceptor)begin //Só funciona se não estiver enviando
			 //maquina receptora de bits
				  case (stateReceptor)
				  
							 Start:
								  begin
							 
										stateReceptor <= bit0;
										
										
								  end
								  
							 bit0:
								  begin
										
										if(numPacotes == 0)begin
											pacotes[0] <= rx; //Atualiza o bit com o valor recebido
											stateReceptor <= bit1;
										end
										else if(numPacotes == 1)begin //Formar segundo pacote
											pacotes[8] <= rx; //Atualiza o bit com o valor recebido
											stateReceptor <= bit1;					
										end
										
								  end
				  
							  bit1:
									begin
									
										if(numPacotes == 0)begin
											pacotes[1] <= rx; //Atualiza o  bit com o valor recebido
											stateReceptor <= bit2;
										end
										else if(numPacotes == 1)begin//Formar segundo pacote
											pacotes[9] <= rx; //Atualiza o  bit com o valor recebido
											stateReceptor <= bit2;
										
										end
										
									end
										
							  bit2:
								  begin
							  
										if(numPacotes == 0)begin
											pacotes[2] <= rx; //Atualiza o bit com o valor recebido    
											stateReceptor <= bit3;
										end
										else if(numPacotes == 1)begin//Formar segundo pacote
											pacotes[10] <= rx; //Atualiza o  bit com o valor recebido
											stateReceptor <= bit3;
										end
										
								  end
							  bit3:
							  
								  begin
								  
								  
										if(numPacotes == 0)begin
											pacotes[3] <= rx; //Atualiza o bit com o valor recebido
											stateReceptor <= bit4;
										end
										else if(numPacotes ==1 )begin
											pacotes[11] <= rx; //Atualiza o bit com o valor recebido
											stateReceptor <= bit4;
										end
										
								  end
							  bit4:
							 
								  begin
								  
								  
										if(numPacotes == 0)begin
											pacotes[4] <= rx; //Atualiza o bit com o valor recebido
											stateReceptor <= bit5;
										end
										else if(numPacotes == 1)begin
											pacotes[12] <= rx; //Atualiza o bit com o valor recebido
											stateReceptor <= bit5;
										end
										
								  end
							  bit5:
							  
								  begin
								  
										if(numPacotes == 0)begin
											pacotes[5] <= rx; //Atualiza o  bit com o valor recebido
											stateReceptor <= bit6;
										end
										else if(numPacotes == 1)begin
											pacotes[13] <= rx; //Atualiza o  bit com o valor recebido
											stateReceptor <= bit6;
										end
										
								  end
							  bit6:
								  begin
								  
										if(numPacotes == 0)begin
											pacotes[6] <= rx; //Atualiza o  bit com o valor recebido
											stateReceptor <= bit7;
										end
										else if(numPacotes == 1)begin
											pacotes[14] <= rx; //Atualiza o  bit com o valor recebido
											stateReceptor <= bit7;
										end
										
								  end
							  bit7:
								  begin
								  
								  
										if(numPacotes == 0)begin
											pacotes[7] <= rx; //Atualiza o  bit com o valor recebido
											stateReceptor <= stop;
										end
										else if(numPacotes == 1)begin
											pacotes[15] <= rx; //Atualiza o  bit com o valor recebido
											stateReceptor <= stop;
										end
										
								  end
								  
							  stop:
								  begin
										numPacotes = numPacotes +1;
										stateReceptor <= verificacaoAlarme;
										if(numPacotes == 2)begin
										
											travaReceptor = 0; //Trava recepção de bits se tiver 2 pacotes
											stateReceptor <= Start;
										end
										
								  end        
								  
							  verificacaoAlarme:
							  
										begin
										
											 
											 
											 if(pacotes == 16'b0011011100000000)begin //Verifica se recebeu alarme
											 
												  stateReceptor <= alarme1;
												  
											 end
											 else begin //
											 
												  stateReceptor <= Start;
											 
											 end
											 
											 
										end
							  alarme1: //Espera a outra m�quina desbloquear o alarme
							  
										if(desbloqueiaAlarme == 1)begin
										
											 stateReceptor <= Start;    
										
										end
										
							 
											 
						
							 default:
									begin
									end
							 
						endcase
				  
				  
				  
				 end
				 
				  //MAQUINA DE ESTADOS DO ARBITRO
				  case (stateVerificador)
						
								  checkTamanho:
										begin
										
											 if(numPacotes == 2)begin
											 
												  stateVerificador <= checksum;
											 
											 end
											 
											 
										end
										
								  checksum:
								  
										begin
									
								
											if(pacotes == 16'b0011011100000000)begin
											 // se nao for alarme puro ele faz checagem
												
												stateVerificador <= alarme2;
												
											end
											else begin
											 
												 
												 resultadoXOR = pacotes[15:8] ^ chave;
												  
												 
												 if(resultadoXOR == 8'b00000000)begin //Pacote correto
												 
													  stateVerificador <= enviarNIOS;
												 
												 end
												 else begin //Houve alarme ou erro
												 
													  stateVerificador <= verificarAlarme;
													  numPacotes = 0; //Limpa pacotes
												 
												 end
												 
											 end
														
											 
										end
						
									enviarNIOS:
										 begin
										 
											 done <= 1;
											 result[7:0] <= pacotes[7:0]; //Coloca na saida da instru��o o pacote
											 result[31:8] <= 24'b000000000000000000000000;
											 
											 
											 stateVerificador <= limparRegs;
											 
										 end
											 
									limparRegs:
										begin
									
											 pacotes <= 16'b1111111111111111;
											 numPacotes = 0;
											 done <=0;
											 
											 
											 stateVerificador <= checkTamanho;
											 
											 
										
										end
										
									verificarAlarme:
										begin
										
												 
												travaReceptor = 1; //Liga maquina de recepção
												if(numPacotes == 2)begin
												
													travaReceptor = 0; //Trava recepção
													
													if( pacotes == 16'b0011011100000000)begin
														//So muda estado se achar um alarme
														stateVerificador <= alarme2;
										
													end
													else begin //Nao recebi o alarme
													
														stateVerificador <= limparRegs;
													
													end
																	
												end
										
										
											 
											 
										end
										
									alarme2:
										begin
									
											 stateVerificador <= enviarNIOS;
											 
										end
										
										
								  default:
									  begin
									  end
										
						endcase
				  
				  
				
    
    
    
    end
    
    
    
    //M�quina de estados do �rbitro
    always @(dataa)begin ///////// tirei o rx
    
        travaReceptor = 0; //trava maquina receptora
		  travaEnvio = 1; //liga maquina de envio
		  
		  //Coloca todas as máquinas no inicio
		  stateVerificador <= checkTamanho; 
		  stateReceptor <= Start;
		  numPacotes = 0;
		  
		  

    
    end
	 
	 
	 //Enviar para barramento
	 always @(posedge clk)begin
	 
	 
		if(travaEnvio)begin
		
				case (stateEnvio)
							
							Start:
								begin
										stateEnvio <= bit0;
								
								end
				
				
							 bit0:
								  begin
								  
										tx <= dataa[0];
										stateEnvio <= bit1;
										
								  end
				  
							  bit1:
									begin
									
										tx <= dataa[1];
										stateEnvio <= bit2;
										
									end
										
							  bit2:
								  begin
							  
										tx <= dataa[2];
										stateEnvio <= bit3;
										
								  end
							  bit3:
							  
								  begin
								  
										tx <= dataa[3];
										stateEnvio <= bit4;
										
								  end
							  bit4:
							 
								  begin
										tx <= dataa[4];
										stateEnvio <= bit5;
										
								  end
							  bit5:
							  
								  begin
										tx <= dataa[5];
										stateEnvio <= bit6;
										
								  end
							  bit6:
								  begin
								  
										tx <= dataa[6];
										stateEnvio <= bit7;
										
								  end
							  bit7:
								  begin
								  
										tx <= dataa[7];
										stateEnvio <= bit0;
										travaEnvio = 0;//trava maquina de env

										if(dataa != 32'b00000000000000000000000000000000)begin
											
											travaReceptor = 1; //liga maquina receptora										
										end
										
								  end
		
		
							default:
							begin
							end
		
				endcase
		
		
		end
		
	 
	 
	 end
    
    
    








endmodule