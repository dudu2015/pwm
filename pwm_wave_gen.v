`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   15:23:25 07/27/2015
// Design Name:   pwm_top
// Module Name:   D:/altera/tg/pwm_wave_gen.v
// Project Name:  tg
// Target Device:  
// Tool versions:  
// Description: 
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module pwm_wave_gen(
i_clk,
i_rst,
i_duty,
i_en,
o_pwm
);
input i_clk;
input i_rst;
input [6:0] i_duty;
input i_en;
output o_pwm;

parameter FCNT = 100000000;//100 MHz
parameter PF = 20000;//20 KHz
parameter THCNT = FCNT/PF;

reg [12:0] cnt;
always@(posedge i_clk or negedge i_rst)
begin
	if(!i_rst)
		begin
			cnt <= 13'h0;
		end
	else
		begin
			if(cnt >= THCNT)
				begin
					cnt <= 13'h0;
				end
			else
				begin
					cnt <= cnt + 1'b1;
				end
		end
end

reg pwm_wave;
assign o_pwm = pwm_wave;

always@(*)
begin
	if(!i_rst || !i_en)
		begin
			pwm_wave = 1'b0;
		end
	else
		begin
			if(cnt <= (THCNT*i_duty>>7))
				begin
					pwm_wave = 1'b1;
				end
			else
				begin
					pwm_wave = 1'b0;
				end
		end
end


endmodule
