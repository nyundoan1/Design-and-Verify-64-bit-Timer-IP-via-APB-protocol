module cnt_ctrl
(
input wire clk,
input wire rst_n,
input wire halt_req,
input wire timer_en,
input wire div_en,
input wire [3:0] div_val,
input wire dbg_mode,
output wire cnt_en
);

//internal signal
reg [7:0] int_cnt;
wire [7:0] int_cnt_pre;
wire int_cnt_rst;
reg [7:0] max_val;
wire [7:0] tmp0;
wire [7:0] tmp1;
wire tmp3;
wire pulse;

//combinational logic left
assign int_cnt_pre = (halt_req & dbg_mode) ? int_cnt : tmp0;
assign tmp0 = int_cnt_rst ? 8'b0 : tmp1;
assign tmp1 = (timer_en && div_en && (div_val !=0)) ? (int_cnt + 1'b1) : int_cnt; 


always @(posedge clk or negedge rst_n) begin
	  if(!rst_n) begin
		int_cnt <= 8'b0;
	  end else begin
		int_cnt <= int_cnt_pre;
	end
end

//combinational logic below
assign int_cnt_rst = (!div_en) | (!timer_en) | pulse;
always @(*) begin
	max_val = (8'b1 << div_val) - 8'b1;  
end

//combinational logic right
assign cnt_en = (halt_req & dbg_mode ) ? 1'b0: tmp3;
assign tmp3 = (timer_en && div_en && (div_val == 4'h0) )  | (timer_en && (div_en == 1'b0) ) | ( (timer_en && div_en && ( div_val != 0)) & pulse ) ;
assign pulse = (int_cnt == max_val);

endmodule





























