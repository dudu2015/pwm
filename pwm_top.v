`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   15:23:25 07/27/2015
// Design Name:   pwm_top
// Module Name:   D:/altera/tg/pwm_top.v
// Project Name:  tg
// Target Device:  
// Tool versions:  
// Description: 
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module pwm_top(
	i_sys_clk,
	
	i_duty_en,//1 duty CONFIG enable; 0 disable
	i_duty,//duty CONFIG 0~127/128
	
	o_pwm_wave,
	
	i_direction,//1 clockwise; 0 counterclockwise
	
	i_on_off,//1 on; 0 off
	
	i_rst
);

input i_sys_clk;

input i_duty_en;
input [6:0] i_duty;
output [1:0] o_pwm_wave;

input i_direction;
input i_on_off;
input i_rst;

//ON/OFF 
wire [1:0] pwm_wave;
assign o_pwm_wave = i_on_off?pwm_wave:1'b0;

//DIRECTION
wire pwm_valid;
assign pwm_wave = i_direction?{pwm_valid, 1'b0}:{1'b0, pwm_valid};

//WAVE GENERATION
reg [6:0] duty_r;
pwm_wave_gen u0_pwm_wave_inst(//U0_PWM_WAVE_INST
	.i_clk(i_sys_clk),//clk_100m
	.i_rst(i_rst),
	.i_duty(duty_r),
	.i_en(i_on_off),
	.o_pwm(pwm_valid)
);

//DUTY SET
always@(posedge i_sys_clk or negedge i_rst)
begin
	if(!i_rst)
		begin
			duty_r <= 7'h0;//0 or 50 by default
		end 
	else
		begin
			if(i_duty_en)
				begin
					duty_r <= i_duty;
				end
			else
				begin
					duty_r <= duty_r;
				end
		end
end 

//CLK PLL
//to be instantiated...

endmodule
