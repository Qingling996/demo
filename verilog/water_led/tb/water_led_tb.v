`timescale 1ns/1ns
module water_led_tb();

reg     clk;
reg     rst_n;

wire    [3:0]   led_out;//输出信号引出

initial
    begin
        clk = 1'b1;
        rst_n <= 1'b0;
        #20
        rst_n <= 1'b1;
		#5000;
		$stop;
    end
    
always #10 clk = ~clk;

water_led #(.CNT_MAX(25'd24))water_led_inst (   
    .clk     (clk),
    .rst_n   (rst_n),

    .led_out (led_out)
);  
endmodule 