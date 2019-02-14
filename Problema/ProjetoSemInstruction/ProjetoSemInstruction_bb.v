
module ProjetoSemInstruction (
	botaodescer_external_connection_export,
	botaoentrar_external_connection_export,
	botaosubir_external_connection_export,
	botaovoltar_external_connection_export,
	clk_clk,
	lcd_16207_0_external_RS,
	lcd_16207_0_external_RW,
	lcd_16207_0_external_data,
	lcd_16207_0_external_E,
	ledazul_external_connection_export,
	ledverde_external_connection_export,
	ledvermelho_external_connection_export,
	reset_reset_n,
	uart_0_external_connection_rxd,
	uart_0_external_connection_txd,
	arbitro_0_conduit_end_rx,
	arbitro_0_conduit_end_tx);	

	input		botaodescer_external_connection_export;
	input		botaoentrar_external_connection_export;
	input		botaosubir_external_connection_export;
	input		botaovoltar_external_connection_export;
	input		clk_clk;
	output		lcd_16207_0_external_RS;
	output		lcd_16207_0_external_RW;
	inout	[7:0]	lcd_16207_0_external_data;
	output		lcd_16207_0_external_E;
	output		ledazul_external_connection_export;
	output		ledverde_external_connection_export;
	output		ledvermelho_external_connection_export;
	input		reset_reset_n;
	input		uart_0_external_connection_rxd;
	output		uart_0_external_connection_txd;
	input		arbitro_0_conduit_end_rx;
	output		arbitro_0_conduit_end_tx;
endmodule
