task run_test();
reg [31:0] reg_rdata;
reg [63:0] cnt_before;
reg [63:0] cnt_after;
reg [63:0] cnt_after2;
integer div;
integer safe_wait;
begin
	$display("===============================================");
	$display("[             Pat name: HALT CHECK            ]");
	$display("===============================================");
	$display("========== A. NORMAL MODE (div_en=0) ==========");

	$display("[A1] =====> no halt when dbg_mode = 0, halt_req = 1  <========");
	set_dbg_mode(0);

	apb_write(ADDR_TCR, 32'h1, 4'b0001); // timer_en = 1
	apb_write(ADDR_THCSR, 32'h1, 4'b0001);
	cnt_before = test_bench.timer_top_dut.u_apb_reg_cnt.cnt_64b;#1;
	$display("CNT before halt: %d (64'h%h)",cnt_before,cnt_before);
	repeat (80) @(posedge clk);
	$display("Wait for some cycle  ............................................. ");
	cnt_after = test_bench.timer_top_dut.u_apb_reg_cnt.cnt_64b;#1;
	$display("CNT after halt: %d (64'h%h)",cnt_after,cnt_after);
	
	if (cnt_after != cnt_before) begin
		$display("PASS: Counter continued running (halt ignored in dbg_mode=0)");
	end else begin
		$display("FAIL: Counter STOPPED in dbg_mode=0");
		err_num = err_num + 1;
	end




	$display("\n[A2] ====> halt_req = 1 & dbg_mode = 1  <=======");
	// Reset states
	apb_write(ADDR_TCR, 32'h0, 4'b0001);
	apb_write(ADDR_THCSR, 32'h0, 4'b0001);
	set_dbg_mode(1);
	apb_write(ADDR_TCR, 32'h1, 4'b0001); // timer_en=1, div_en=0
	@(posedge clk);apb_write(ADDR_THCSR, 32'h1, 4'b0001);

	cnt_before = test_bench.timer_top_dut.u_apb_reg_cnt.cnt_64b;#1;
	$display("CNT before halt: %d (64'h%h)",cnt_before,cnt_before);
	
	repeat (60) @(posedge clk);
	$display("Wait for some cycle  ............................................. ");

	cnt_after = test_bench.timer_top_dut.u_apb_reg_cnt.cnt_64b;#1;
	$display("CNT after halt: %d (64'h%h)",cnt_after,cnt_after);

	if (cnt_after === cnt_before) begin
	$display("PASS: Counter HALTED correctly in dbg_mode=1");
	end else begin
	$display("FAIL: Counter still incrementing in dbg_mode=1!");
	err_num = err_num + 1;
	end


	$display("\n[A3] ======> Clear halt_req → counter resumes  <======");

	apb_write(ADDR_THCSR, 32'h0, 4'b0001); // clear halt
	repeat (50) @(posedge clk);
	$display("Wait for some cycle  ............................................. ");
	cnt_after2 = test_bench.timer_top_dut.u_apb_reg_cnt.cnt_64b;#1;
	$display("CNT after clear THCSR.halt_req a few cycle: %d (64'h%h)",cnt_after2,cnt_after2);
	if (cnt_after2 > cnt_after) begin
		$display("PASS: Counter RESUMED correctly\n");	
	end else begin
		$display("FAIL: Counter did NOT resume\n");
		err_num = err_num + 1;
	end

	// --------------------------------------------------------
	//  PART B — DIV MODE (div_en = 1, div_val = 0..8)
	// --------------------------------------------------------
	$display("\n========== B. DIV MODE============");

	for (div = 0; div < 9; div = div + 1) begin
	$display("----------------------------------------------------------------------------");


		$display("\n RESET THE STATUS \n", div);		
		set_dbg_mode(0);
		apb_write(ADDR_TCR, 32'h0, 4'b0001);
		apb_write(ADDR_THCSR, 32'h0, 4'b0001);

		apb_write(ADDR_TCR, (div << 8) | 32'h2, 4'b0011);
		apb_write(ADDR_TCR, (div << 8) | 32'h3, 4'b0001);

		$display("[B1]  =====> no halt when dbg_mode = 0 <=========");
		$display("===== DIV MODE TEST: div_val = %0d =====\n", div);

		apb_write(ADDR_THCSR, 32'h1, 4'b0001); 
		cnt_before = test_bench.timer_top_dut.u_apb_reg_cnt.cnt_64b;#1;
		$display("CNT before halt: %d (64'h%h)",cnt_before,cnt_before);
		safe_wait = (div + 1) * 259;
		repeat (safe_wait) @(posedge clk);
		$display("Wait for some cycle  ............................................. ");
		cnt_after = test_bench.timer_top_dut.u_apb_reg_cnt.cnt_64b;#1;
		$display("CNT after halt: %d (64'h%h)\n",cnt_after,cnt_after);

		if (cnt_after != cnt_before) begin
			$display("PASS: Counter keeps running in DBG=0 (div mode)");
		end else begin
			$display("FAIL: Counter STOPS in DBG=0 (div mode)");
			err_num = err_num + 1;
		end



		$display("\n[B2]  =====> counter halt when dbg_mode = 1 & halt_req = 1  <=========");
		apb_write(ADDR_TCR, 32'h0, 4'b0001);
		apb_write(ADDR_THCSR, 32'h0, 4'b0001);
		set_dbg_mode(1);

		apb_write(ADDR_TDR0, 32'h55667788, 4'b1111);
		apb_write(ADDR_TDR1, 32'h11223344, 4'b1111);

		apb_write(ADDR_TCR, (div << 8) | 32'h3, 4'b0011);

		@(posedge clk);
		apb_write(ADDR_THCSR, 32'h1, 4'b0001);
		cnt_before = test_bench.timer_top_dut.u_apb_reg_cnt.cnt_64b;#1;
		$display("CNT before halt: %d (64'h%h)\n",cnt_before,cnt_before);

		safe_wait = (div + 1) * 400;
		repeat (safe_wait) @(posedge clk);

		$display("Wait for some cycle  ............................................. ");
		cnt_after = test_bench.timer_top_dut.u_apb_reg_cnt.cnt_64b;#1;
		$display("CNT after halt: %d (64'h%h)",cnt_after,cnt_after);

		if (cnt_after === cnt_before) begin
			$display("PASS: Counter HALTED (div_mode)");
		end else begin
			$display("FAIL: Counter NOT halted (div_mode)");
			err_num = err_num + 1;
		end


		$display("\n[B3]  =====> clear halt_req → resume counter  <=========");
		apb_write(ADDR_THCSR, 32'h0, 4'b0001);

		// wait resume margin
		repeat ((div + 1) * 400) @(posedge clk);

		$display("Wait for some cycle  ............................................. ");
		cnt_after2 = test_bench.timer_top_dut.u_apb_reg_cnt.cnt_64b;#1;
		$display("CNT after halt: %d (64'h%h)\n",cnt_after2,cnt_after2);

		if (cnt_after2 > cnt_after) begin
			$display("PASS: Counter resumed (div mode)");
		end else begin
			$display("FAIL: Counter did NOT resume (div mode)");
			err_num = err_num + 1;
		end

	$display("----------------------------------------------------------------------------");
	end 

	if(test_bench.err_num == 0 ) begin
		$display("=====================================================================================");
		$display("=========[                        TEST : PASS ALL                       ]============");
		$display("=====================================================================================");
	end else begin 
		$display("=====================================================================================");
		$display("=========[                         TEST : FAIL****                      ]============");
		$display("=====================================================================================");
	end
end
endtask

