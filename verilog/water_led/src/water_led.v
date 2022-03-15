module water_led #(
    parameter   CNT_MAX = 25'd11_999_999) (
    input   wire            clk     ,
    input   wire            rst_n   ,     
    // input   wire            start   ,//解决办法2
    
    output  reg    [3:0]    led_out   //1号方案
    // output  wire   [3:0]    led_out     //解决办法2
);

reg     [24:0]  cnt;
reg             cnt_flag;
// reg     [3:0]   led_out_reg;//解决办法2

always@(posedge clk or negedge rst_n)
    if (rst_n == 1'b0)
        cnt <= 25'd0;
    else if(cnt == (CNT_MAX))
        cnt <= 25'd0;
    else
        cnt <= cnt + 25'd1;

always@(posedge clk or negedge rst_n)
    if (rst_n == 1'b0)
        cnt_flag <= 1'b0;
    else if(cnt == (CNT_MAX - 25'd1))
        cnt_flag <= 1'b1;
    else
        cnt_flag <= 1'b0;
    
always@(posedge clk or negedge rst_n)//1号方案
    if (rst_n == 1'b0)
        led_out <= 4'b1111;
    else if((led_out == 4'b0111) && (cnt_flag == 1'b1))
        led_out <= 4'b0001;
    else if(cnt_flag == 1'b1)
        led_out <= led_out << 1;
    else
        led_out <= led_out;
       
        
// always@(posedge clk or negedge rst_n)       //解决方案2
    // if (rst_n == 1'b0)
        // led_out_reg <= 4'b1111;
    // else if((led_out_reg == 4'b1000 && cnt_flag == 1'b1)|| start == 1'b0 )
        // led_out_reg <= 4'b0001;
    // else if(cnt_flag == 1'b1)
        // led_out_reg <= led_out_reg << 1;
    // else
        // led_out_reg <= led_out_reg;

// assign led_out = led_out_reg;
 
endmodule