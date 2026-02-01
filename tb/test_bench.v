`timescale 1ns/1ns
module test_bench;
// Register Address Parameters
parameter ADDR_TCR   = 12'h0;    // Timer Control Register
parameter ADDR_TDR0  = 12'h4;    // Timer Data Register Low (32 LSBs of reload value)
parameter ADDR_TDR1  = 12'h8;    // Timer Data Register High (32 MSBs of reload value)
parameter ADDR_TCMP0 = 12'h0C;   // Timer Compare Register 0
parameter ADDR_TCMP1 = 12'h10;   // Timer Compare Register 1
parameter ADDR_TIER  = 12'h14;   // Timer Interrupt Enable Register
parameter ADDR_TISR  = 12'h18;   // Timer Interrupt Status Register
parameter ADDR_THCSR = 12'h1C;   // Timer Halt/Control Status Register (Hypothetical)
// Data Constants
parameter D0 = 32'h0000_0000; 
parameter D1 = 32'h1111_1111;
parameter D2 = 32'h2222_2222; 
parameter D3 = 32'h3333_3333; 
parameter D4 = 32'h4444_4444; 
parameter D5 = 32'h5555_5555; 
parameter D6 = 32'h6666_6666;
parameter D7 = 32'h7777_7777; 
parameter D8 = 32'h8888_8888; 
parameter D9 = 32'h9999_9999; 
parameter DA = 32'haaaa_aaaa;
parameter DF = 32'hffff_ffff;
 
// Testbench and APB Interface Signal Declaration
reg clk,  rst_n;
reg psel, pwrite, penable;
reg [3:0] pstrb; 
reg [11:0] paddr; 
reg [31:0] pwdata;
reg dbg_mode; 
wire pready;
wire pslverr;
wire tim_int;
wire [31:0] prdata;

reg pslverr_high; // Temporary variable to check pslverr
integer  err_num;  // Error count
// DUT (Device Under Test) Declaration and Connection
timer_top timer_top_dut(
	.sys_clk(clk),
	.sys_rst_n(rst_n),
	.tim_psel(psel),
	.tim_pwrite(pwrite), 
	.tim_penable(penable),
	.tim_pstrb(pstrb), 
	.tim_paddr(paddr), 
	.tim_pwdata(pwdata), 
	.dbg_mode(dbg_mode),
	.tim_pready(pready),
	.tim_pslverr(pslverr),
	.tim_int(tim_int), 
	.tim_prdata(prdata)
);

// Include file containing main test scenarios
`include "run_test.v"

// Clock generation block
initial begin 
	clk = 0;
	forever #10 clk = ~clk;
end

// Reset signal generation block
initial begin
	rst_n = 1'b0;
	#10 rst_n = 1'b1;
end

// Initial block for signal initialization and test execution
initial begin
	// Initialize all APB signals to IDLE state
	psel = 1'b0;
	pwrite = 1'b0;
	penable = 1'b0;
	pstrb = 4'h0;
	dbg_mode = 1'b0;
	paddr = 12'h0;
	pwdata = 32'h0;
	err_num = 0;

	// Wait for reset process to complete
	#100 
	// Run test scenario
	run_test();
	
	// Finish simulation
	#100
	$display("-------------------------------------------------------------------------------------");
	$display("[ t = %10t ] TEST COMPLETE. Total Errors: %0d", $time, err_num);
	$display("-------------------------------------------------------------------------------------");
	$finish;
end

// APB Write Task: Executes the APB write cycle
task apb_write(	input [11:0] addr, input [31:0] data, input [3:0] strb );
begin
	$display("[ t = %10t ] WRITE data=32'h%h to addr=12'h%h with strb=4'b%b ", $time, data, addr, strb);
	pslverr_high = 0;
	
	// Set Up Phase 
	@(posedge clk);
		#1 
		psel = 1'b1;
		pwrite = 1'b1;
		penable = 1'b0;
		paddr = addr; 
		pwdata = data;
		pstrb = strb;

	// Access Phase
	@(posedge clk);
		#1
		penable = 1'b1;
		wait(pready == 1);
		#1;
		if(pslverr == 1) pslverr_high = 1; // Acknowledge Slave error
		
	// IDLE
	@(posedge clk); 
		#1 
		psel = 1'b0;
		pwrite = 1'b0;
		penable = 1'b0;
		paddr = 12'h0;
		pwdata = 32'h0; 
		pstrb = 4'h0;
end
endtask

// APB Read Task: Executes the APB read cycle
task apb_read(input [11:0] addr, output [31:0] out_data);
begin
	// Set Up Phase 
	@(posedge clk);
		#1 
		psel = 1'b1;
		pwrite = 1'b0;
		penable = 1'b0;
		paddr = addr; 

	// Access Phase
	@(posedge clk);
		#1
		penable = 1'b1;
		wait(pready == 1);
		#1 
		out_data = prdata; // Capture the read data (PRDATA)

	// IDLE
	@(posedge clk); 
		#1 
		psel = 1'b0;
		pwrite = 1'b0;
		penable = 1'b0;
		paddr = 12'h0;
		$display("[ t = %10t ] READ at addr = 12'h%h , the rdata actual = 32'h%h ", $time,  addr, out_data);
end
endtask

// Compare Data Task: Compares the read data with the expected data
task compare_data( input [11:0] addr, input [31:0] exp_data, input [31:0] actual, input [31:0] mask);
begin
	if( (exp_data & mask)  == (actual & mask)) begin
		$display("[ t = %10t ] expect that rdata at addr=12'h%h is 32'h%h ", $time,  addr, exp_data); 
		$display("[ t = %10t ]    >>>  PASS <<<     |   rdata actual =32'h%h   =  rdata expect =32'h%h ", $time, actual,  exp_data);
		$display("-------------------------------------------------------------------------------------");
	end else begin
		$display("[ t = %10t ] expect that rdata at addr=12'h%h is 32'h%h ", $time,  addr, exp_data); 
		$display("[ t = %10t ]    >>>  FAIL <<<     |   rdata actual =32'h%h   !=  rdata expect =32'h%h ", $time, actual,  exp_data);
		$display("-------------------------------------------------------------------------------------");
		err_num = err_num + 1; // Increment error counter
	end
end
endtask

// Run Timer Task: Configures and runs the counter with given parameters
task run_timer(
	input [63:0] cnt,          // reload CNT64 -> used for TDR0/TDR1
	input [3:0]  in_div_val,   // div_val is located at [11:8]
	input        in_div_en,    // div_en is located at bit [1]
	input integer n_clk_wait,  // number of clock cycles to wait
	output reg [63:0] cnt_after_n_clk
);
reg [31:0] tcr;
begin
	$display("-------------------------------------------------------------------------------------");
	$display("----------------   1: STOP TIMER (timer_en=0)      ----------------------------------");
	// Write 0 to TCR to stop the timer
	apb_write(ADDR_TCR, 32'h0, 4'hf);
	repeat(3) @(posedge clk); // Wait a few cycles to ensure stop
	$display("---------     2: WRITE RELOAD (split from cnt[63:0] -> TDR0/TDR1    -----------------");
	apb_write(ADDR_TDR0, cnt[31:0],  4'b1111);  // TDR0
	apb_write(ADDR_TDR1, cnt[63:32], 4'b1111);  // TDR1
	$display("[ t = %10t ] SETUP COUNTER INIT = 64'h%h ", $time, cnt);

	$display("---------       3: WRITE DIV_VAL + DIV_EN WHILE TIMER OFF     -----------------");
	apb_write(ADDR_TCR, {20'h0, in_div_val, 6'h0, in_div_en, 1'b0}, 4'hf);
	apb_read(ADDR_TCR,tcr);
	compare_data(ADDR_TCR,{20'h0, in_div_val, 6'h0, in_div_en, 1'b0} , tcr , 32'hffff_ffff );
	$display("[ t = %10t ] SETUP DIV_VAL = 4'b%b & DIV_EN = 1'b%b ", $time, in_div_val, in_div_en);

	$display("----------------  4: START TIMER (timer_en=1)      ----------------------------------");
	apb_write(ADDR_TCR, {20'h0, in_div_val, 6'h0, in_div_en, 1'b1}, 4'hf);

	$display("----------------     5: AFTER %d CYCLE      ----------------------------------", n_clk_wait);
	repeat(n_clk_wait ) @(posedge clk) check_cnt_en();
	
	// Read current counter value via hierarchical reference
	// (Note: this read method is only for the testbench, not an APB read)
	cnt_after_n_clk = timer_top_dut.u_apb_reg_cnt.cnt_64b;
	$display("[ t = %10t ] COUNTER VAL NOW = 64'h%h ", $time, cnt_after_n_clk);
	$display("-------------------------------------------------------------------------------------");
end
endtask


// Check CNT64 Task: Compares the 64-bit counter value
task check_cnt64(
	input [63:0] actual_cnt,
	input [63:0] exp_cnt
);
begin
    $display("EXPECTED CNT64 = %0d (0x%016h)", exp_cnt, exp_cnt);
    $display("ACTUAL   CNT64 = %0d (0x%016h)", actual_cnt, actual_cnt);

    if(exp_cnt === actual_cnt)
         $display("   >>> PASS <<<");
    else begin
         $display("   >>> FAIL <<<");
         err_num = err_num + 1;
    end
    $display("-----------------------------------------");
end
endtask

// Check CNT_EN: Displays CNT_EN status and counter value
task check_cnt_en;
begin
	// Using hierarchical reference (assuming internal module structure)
	if(timer_top_dut.u_apb_reg_cnt.cnt_en == 1'b1) begin
		$display("[t=%10t] CNT_EN = 1 -> CNT64 = %0d (0x%016h)",$time, timer_top_dut.u_apb_reg_cnt.cnt_64b,  timer_top_dut.u_apb_reg_cnt.cnt_64b);	
	end else begin
		$display("[t=%10t] CNT_EN = 0 -> CNT64 = %0d (0x%016h)",$time, timer_top_dut.u_apb_reg_cnt.cnt_64b,  timer_top_dut.u_apb_reg_cnt.cnt_64b);	
	end
end
endtask


// Set DBG_MODE Task: Sets the debug mode
task set_dbg_mode(input mode);
begin
@(posedge clk);
	dbg_mode = mode;
	$display("--------------                       -----------");
	$display("[%0t] >>>>>>>>>>>>> SET DBG_MODE <<<<<<<<<<<<<",mode);
	if(mode == 1) $display("[%0t] >>>>>>           DBG_MODE IS ON          <<<<<<", $time);
	else $display("[%0t] >>>>>>           DBG_MODE IS OFF          <<<<<<",$time);
	$display("-------                             -------------------");

end
endtask
endmodule
