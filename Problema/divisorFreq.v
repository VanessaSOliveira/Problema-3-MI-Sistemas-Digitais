module divisorFreq(

	input clk50MH,
	output reg clk_out9600,
	output  [12:0] cont
	

);


parameter clk_acc_max =  50000000 / (9600 * 16);
parameter clk_max_width = 13;

reg [clk_max_width - 1:0] clk_acc = 0; 

assign cont = clk_acc;


initial begin

clk_out9600 = 0;

end


always @(posedge clk50MH)begin
	if(clk_acc[clk_max_width-1] == 1) begin 
		clk_out9600 = ~clk_out9600;
		clk_acc <= 13'b0000000000000;
	end
	else begin
	
		clk_acc <= clk_acc + 1'b1;
	
	end

end


endmodule