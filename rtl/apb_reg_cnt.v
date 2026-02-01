module apb_reg_cnt
(
//sys signal
input wire clk,
input wire rst_n,

//APB signal
input wire [11:0] paddr,
input wire [3:0]  pstrb,
input wire [31:0] pwdata,
input wire psel,
input wire pwrite,
input wire penable,
output reg pready,
output reg [31:0] prdata,
output wire pslverr,

//COUNTER CONTROL
input reg cnt_en,
output reg timer_en,
output reg div_en,
output reg [3:0] div_val,
output reg halt_req,
output wire [63:0] cnt_64b,

//INTERRUPT
output reg int_en,
output reg int_st,
input wire dbg_mode
);

//======================================================================//
//=====================     ADDR REGISTER    ==========================//
//====================================================================//
localparam TCR     = 12'h00;
localparam TDR0    = 12'h04;
localparam TDR1    = 12'h08;
localparam TCMP0   = 12'h0C;
localparam TCMP1   = 12'h10;
localparam TIER    = 12'h14;
localparam TISR    = 12'h18;
localparam THCSR   = 12'h1C;


//======================================================================//
//=====================  WRITE_EN & READ_EN  ==========================//
//====================================================================//
reg wr_en, rd_en;

always @(posedge clk or negedge rst_n) begin
	if(!rst_n) begin
		wr_en <= 1'b0;
	end else begin
		wr_en <= psel & pwrite & penable & (!wr_en);
	end
end

always @(posedge clk or negedge rst_n) begin
	if(!rst_n) begin
		rd_en <= 1'b0;
	end else begin
		rd_en <= psel & (!pwrite) & penable & (!rd_en);
	end
end

//======================================================================//
//=================== 1. REGISTER WRITE PATH ==========================//
//====================================================================//

//===================== 1.1 TCR REGISTER WRITE ======================//
// TIMER EN
wire tcr_sel;
assign tcr_sel = (paddr == TCR) && (wr_en == 1)  ;
//timer_en
wire timer_en_pre,timer_en_pre_pre;
wire pwdata_timer_en_check1,pwdata_timer_en_check2;
wire pwdata_timer_en_check1_reset;
wire timer_en_clr;
wire check;

always @(posedge clk or negedge rst_n) begin
	if(!rst_n) begin
		timer_en <= 1'b0;
	end else begin
		timer_en <= timer_en_pre;
	end
end


assign timer_en_pre = timer_en_clr ? 1'b0 : timer_en_pre_pre;
assign timer_en_pre_pre = (tcr_sel && (pstrb[0]==1)) ? pwdata_timer_en_check1 : timer_en;
assign pwdata_timer_en_check1 = (pwdata_timer_en_check1_reset  )? timer_en: pwdata_timer_en_check2; 
assign pwdata_timer_en_check2 = ( check )? timer_en : pwdata[0] ; 
assign pwdata_timer_en_check1_reset =  (pstrb[1] == 1)  &  ( pwdata[11:8] > 8 | ( (pwdata[11:8]<9)&&(timer_en==1) ) );

assign timer_en_clr =     ( (pstrb[1:0]== 2'b11) && (pwdata ==32'h0)   &&                                           (wr_en == 1) && (paddr == TCR))
		  	| ( (pstrb[0] == 1)      && (timer_en == 1)    && (div_en==0) && (pwdata[1:0] == 2'b00)  && (wr_en == 1) && (paddr == TCR) && (pwdata[11:8] == div_val))     
		  	| ( (pstrb[0] == 1)      && (timer_en == 1)    && (div_en==1) && (pwdata[1:0] == 2'b10)  && (wr_en == 1) && (paddr == TCR) && (pwdata[11:8] == div_val) );

assign check = ( ((pstrb[0] == 1) && (timer_en == 1) && (div_en==0) && ((pwdata[1:0] == 2'b10)|(pwdata[1:0] == 2'b11) )  )   ) | ((pstrb[0] == 1) && (timer_en == 1) && (div_en==1) && ((pwdata[1:0] == 2'b00)|(pwdata[1:0] == 2'b01) )  )  ;
//DIV EN
//reg div_val;
wire div_en_pre;
wire pwdata_div_en_check;


always @(posedge clk or negedge rst_n) begin
	if(!rst_n) begin
		div_en <= 1'b0;
	end else begin
		div_en <= div_en_pre;
	end
end

assign div_en_pre = (tcr_sel && (pstrb[0]==1) && (timer_en == 0))  ? pwdata_div_en_check : div_en;
assign pwdata_div_en_check= ((pwdata[11:8] > 8) && (pstrb[1]==1) ) ? div_en : pwdata[1];

//DIV VAL
//reg div_val;
wire [3:0] div_val_pre;
wire [3:0] pwdata_div_val_check;

always @(posedge clk or negedge rst_n) begin
	if(!rst_n) begin
		div_val <= 4'b0001;
	end else begin
		div_val <= div_val_pre;
	end
end

assign div_val_pre =  (tcr_sel && (pstrb[1]==1) && (timer_en==0)) ? pwdata_div_val_check  : div_val;
assign pwdata_div_val_check= (pwdata[11:8] < 9) ? pwdata[11:8] : div_val;




//===================== 1.2. TDR0/1  + COUNTER  ===========================//
reg [31:0] tdr0, tdr1;
wire [31:0] tdr0_pre , tdr1_pre;
wire tdr0_sel, tdr1_sel;

always @(posedge clk or negedge rst_n) begin
	if(!rst_n) begin
		tdr0 <= 32'b0;
		tdr1 <= 32'b0;
	end else if( (timer_en==1) && (timer_en_pre==0)) begin
		tdr0 <= 32'b0;
		tdr1 <= 32'b0;
	end else begin
		tdr0 <= tdr0_pre;
		tdr1 <= tdr1_pre;
	end
end


//TDR0, TDR1 Logic
    assign tdr0_sel =  (paddr == 12'h4) && wr_en;
    assign tdr0_pre[7:0] = (tdr0_sel && pstrb[0]) ? pwdata[7:0] : cnt_64b[7:0]; 
    assign tdr0_pre[15:8] = (tdr0_sel && pstrb[1]) ? pwdata[15:8] : cnt_64b[15:8]; 
    assign tdr0_pre[23:16] = (tdr0_sel && pstrb[2]) ? pwdata[23:16] : cnt_64b[23:16]; 
    assign tdr0_pre[31:24] = (tdr0_sel && pstrb[3]) ? pwdata[31:24] : cnt_64b[31:24]; 

    assign tdr1_sel =  (paddr == 12'h8) && wr_en;
   assign tdr1_pre[7:0] = (tdr1_sel && pstrb[0]) ? pwdata[7:0] : cnt_64b[39:32]; 
    assign tdr1_pre[15:8] = (tdr1_sel && pstrb[1]) ? pwdata[15:8] : cnt_64b[47:40]; 
    assign tdr1_pre[23:16] = (tdr1_sel && pstrb[2]) ? pwdata[23:16] : cnt_64b[55:48]; 
    assign tdr1_pre[31:24] = (tdr1_sel && pstrb[3]) ? pwdata[31:24] : cnt_64b[63:56]; 

assign cnt_64b = cnt_en ?  ( {tdr1,tdr0} + 1 ) : {tdr1,tdr0};
 
 //===================== 1.3. TCMPO/1 REGISTER ===========================//

reg [31:0] tcmp0, tcmp1;
wire [31:0] tcmp0_pre , tcmp1_pre;
wire tcmp0_sel, tcmp1_sel;
reg [63:0] cmp_64b;

always @(posedge clk or negedge rst_n) begin
	if(!rst_n) begin
		tcmp0 <= 32'hffff_ffff;
	end else begin
		tcmp0 <= tcmp0_pre;
	end
end

assign tcmp0_sel = (paddr == TCMP0) && (wr_en == 1) ;
assign tcmp0_pre[7:0]   = (tcmp0_sel && (pstrb[0]==1)) ? pwdata[7:0] : tcmp0[7:0];
assign tcmp0_pre[15:8]  = (tcmp0_sel && (pstrb[1]==1)) ? pwdata[15:8] : tcmp0[15:8];
assign tcmp0_pre[23:16] = (tcmp0_sel && (pstrb[2]==1)) ? pwdata[23:16] : tcmp0[23:16];
assign tcmp0_pre[31:24] = (tcmp0_sel && (pstrb[3]==1)) ? pwdata[31:24] : tcmp0[31:24];

always @(posedge clk or negedge rst_n) begin
	if(!rst_n) begin
		tcmp1 <= 32'hffff_ffff;
	end else begin
		tcmp1 <= tcmp1_pre;
	end
end

assign tcmp1_sel = (paddr == TCMP1) && (wr_en == 1) ;
assign tcmp1_pre[7:0]   = (tcmp1_sel && (pstrb[0]==1)) ? pwdata[7:0] : tcmp1[7:0];
assign tcmp1_pre[15:8]  = (tcmp1_sel && (pstrb[1]==1)) ? pwdata[15:8] : tcmp1[15:8];
assign tcmp1_pre[23:16] = (tcmp1_sel && (pstrb[2]==1)) ? pwdata[23:16] : tcmp1[23:16];
assign tcmp1_pre[31:24] = (tcmp1_sel && (pstrb[3]==1)) ? pwdata[31:24] : tcmp1[31:24];

always @(*) begin
	cmp_64b = { tcmp1,tcmp0 };
end

//===================== 1.4. TIER REGISTER ===========================//
wire int_en_pre;
wire int_en_sel;

always @(posedge clk or negedge rst_n) begin
	if(!rst_n) begin
		int_en <= 1'b0;
	end else begin
		int_en <= int_en_pre;
	end
end

assign int_en_sel = (paddr == TIER) && (wr_en == 1) && (pstrb[0] == 1'b1);
assign int_en_pre = int_en_sel ? pwdata[0] : int_en;
//===================== 1.5. TISR REGISTER ===========================//
wire int_st_pre;
wire int_st_clr;
wire int_st_back;

always @(posedge clk or negedge rst_n) begin
	if(!rst_n) begin
		int_st <= 1'b0;
	end else begin
		int_st <= int_st_pre;
	end
end

assign int_st_clr = (paddr == TISR) && (wr_en == 1) && (pstrb[0] == 1'b1) && (pwdata[0] == 1);
assign int_st_pre = int_st_clr ? 1'b0 : int_st_back;
assign int_st_back = (cnt_64b == cmp_64b) ? 1'b1 : int_st;

//===================== 1.6. THCSR REGISTER ===========================//
//reg halt_req
reg halt_ack;
wire  halt_req_pre , halt_ack_pre;
wire thcsr_sel;


always @(posedge clk or negedge rst_n) begin
	if(!rst_n) begin
		halt_req <= 1'b0;
	end else begin
		halt_req <= halt_req_pre;
	end
end
assign thcsr_sel = (paddr == THCSR) && (wr_en == 1) && (pstrb[0] == 1'b1);
assign halt_req_pre = thcsr_sel ? pwdata[0] : halt_req;

always @(posedge clk or negedge rst_n) begin
	if(!rst_n) begin
		halt_ack <= 1'b0;
	end else begin
		halt_ack <= halt_ack_pre;
	end
end
assign halt_ack_pre = dbg_mode ? halt_req : 1'b0;

//======================================================================//
//=====================    2. PSLVERR PATH    ===========================//
//====================================================================//
wire tmp20, tmp21, tmp22, tmp23;
assign pslverr = (tmp20 == 1) && (tcr_sel==1); 
assign tmp20 = tmp21 | tmp22 | tmp23;
assign tmp21 = (timer_en == 1) && (pstrb[1] == 1'b1) && ( pwdata[11:8] != div_val );
assign tmp22 = (timer_en == 1) && (pstrb[0] == 1'b1) && ( pwdata[1] != div_en );
assign tmp23 = (pwdata[11:8] > 4'h8) && (pstrb[1] == 1'b1);
 
//======================================================================//
//=====================   3. PREADY PATH      =========================//
//====================================================================//
always @(*) begin
	pready = wr_en | rd_en;
end

//======================================================================//
//====================== 4. REGISTER READ PATH ========================//
//====================================================================//
always @(*) begin
	case(rd_en)
		0: prdata = 32'h0;
		1: case(paddr)
			  TCR   : prdata = {20'b0, div_val, 6'b0, div_en, timer_en};
			  TDR0  : prdata = cnt_64b[31:0];
			  TDR1  : prdata = cnt_64b[63:32];
			  TCMP0 : prdata = cmp_64b[31:0];
			  TCMP1 : prdata = cmp_64b[63:32];
			  TIER  : prdata = {31'b0, int_en};
			  TISR  : prdata = {31'b0, int_st};
			  THCSR : prdata = {30'b0, halt_ack, halt_req};
			  default    : prdata = 32'h0000_0000;
		  endcase
	endcase
end

endmodule


