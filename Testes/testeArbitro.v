
`timescale 1ns / 1ps

module testeArbitro();

 parameter Halfcycle = 5; //half period is 5ns
    
 localparam Cycle = 2*Halfcycle;
 
 localparam loops = 50;
 
 //entradas
  reg [31:0]dataa;
  reg rx;
  reg Clock;
  reg reset;
  reg clk_en;
  reg start;
 
 //wire saidas
  wire tx;
  wire [31:0]result;
  wire done;
  wire [3:0]stateReceptor;
  wire [3:0]stateVerificador;
  wire [3:0]stateEnvio;
  wire [15:0]pacotes;
  wire saidaDiv;
  

 initial begin 
	Clock = 0; 
	dataa <= 32'b0000000000000000000000000000101;
	reset <= 0;
	clk_en <= 1;
	start <= 1;
 
 end
	 
 arbitro TESTE(.clk(Clock),
	  .saidaDiv(saidaDiv),
	  .reset(reset),
	  .clk_en(clk_en),
	  .start(start),
	  .dataa(dataa),
	  .rx(rx),
	  .tx(tx),
	  .result(result),
	  .done(done),
	  .stateReceptor(stateReceptor),
	  .stateVerificador(stateVerificador),
	  .stateEnvio(stateEnvio),
	  .pacotes(pacotes));

 
 integer i = 0;
 reg [15:0] alarme = 16'b0011011100000000;
 reg [15:0] infoSensor = 16'b0011001000000101;
 
 
  always @(posedge Clock)begin
	if(stateVerificador == 4'b0100 )begin
		if(i == 0 & stateReceptor == 4'b0000)begin
			rx <= 1'b0; //start bit
		end
		else if(i == 16)begin
			rx <= 1'b1; //stop bit
			i=0;
		end
		else begin
			rx = alarme[i]; //Teste de alarme
			i = i +1;
		end
	end
	else begin
		rx = $urandom_range(1'b1,1'b0); //Teste normal
		i=0;
	end
 end

initial begin

		#20;
		repeat (50) @ (posedge Clock);
	   
		dataa <= 32'b00000000000000000000000000000010;
	
end




endmodule