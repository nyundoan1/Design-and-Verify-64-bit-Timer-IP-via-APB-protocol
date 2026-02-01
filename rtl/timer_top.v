module timer_top (
input wire sys_clk,
input wire sys_rst_n,
input wire dbg_mode,
input wire [11:0] tim_paddr,
input wire tim_psel,
input wire tim_penable,
input wire tim_pwrite,
input wire [31:0] tim_pwdata,
input wire [3:0] tim_pstrb,

//output
output wire [31:0] tim_prdata,
output wire tim_pready,
output wire tim_pslverr,
output wire tim_int
);

wire [63:0] cnt_64b;


//apb_reg_cnt ------ cnt_ctrl
wire timer_en;
wire div_en;
wire [3:0] div_val;
wire halt_req;

wire cnt_en;


//apb_reg_cnt   ---  interrupt 
wire int_en;
wire int_st;



//instance module apb_register_counter
apb_reg_cnt u_apb_reg_cnt(
	.clk(sys_clk), 
	.rst_n(sys_rst_n),

	//APB//
	.paddr(tim_paddr),
	.pstrb(tim_pstrb),
	.pwdata(tim_pwdata),
	.psel(tim_psel),
	.pwrite(tim_pwrite),
	.penable(tim_penable),
	.pready(tim_pready),
	.prdata(tim_prdata),
	.pslverr(tim_pslverr),

	//CNT
	.cnt_en(cnt_en),
	.timer_en(timer_en),
	.div_en(div_en),
	.div_val(div_val),
	.halt_req(halt_req),
	.cnt_64b(cnt_64b),

	//INTERRUPT
	.int_en(int_en),
	.int_st(int_st),
	.dbg_mode(dbg_mode)
);



//instance module counter control
cnt_ctrl u_cnt_ctrl(
	.clk(sys_clk),
	.rst_n(sys_rst_n),

	.timer_en(timer_en),
	.div_en(div_en),
	.div_val(div_val),
	.dbg_mode(dbg_mode),
	.halt_req(halt_req),

	.cnt_en(cnt_en)
);

//instance module register
interrupt u_interrupt(
      .int_en(int_en),
      .int_st(int_st),
      .interrupt(tim_int)
);

endmodule





