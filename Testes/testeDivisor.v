module testeDivisor();

//Entradas
reg clk_in;

//Saida
wire clk_out;
wire [12:0]cont;

	divisorFreq divisor(
		.clk50MH(clk_in),
		.clk_out9600(clk_out),
		.cont(cont)
	);
	

endmodule