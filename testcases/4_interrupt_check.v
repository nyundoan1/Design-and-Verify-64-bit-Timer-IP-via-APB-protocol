task run_test;
reg [31:0] reg_rdata;
	begin 
		$display("=============================================");
		$display("[         Pat name: Check Interrupt          ]");
		$display("=============================================");


		$display("==============================================");
		$display("=====[ Interrupt assert & hold pending ]======");
		$display("==============================================");

		$display("===== Set Value To TDR0, TDR1 ====="); 
		test_bench.apb_write(ADDR_TDR0, 32'hffff_fff0,4'hf);
		test_bench.apb_write(ADDR_TDR1, 32'hffff_ffff,4'hf);
		test_bench.apb_read(ADDR_TDR0, reg_rdata);
		test_bench.apb_read(ADDR_TDR1, reg_rdata);
		$display("===== cnt_64b = ffff_ffff_ffff_fff0 ====="); 

		$display("===== Set Value To TCMP0, TCMP1 ====="); 
		test_bench.apb_write(ADDR_TCMP0, 32'hffff_fff0,4'hf);
		test_bench.apb_write(ADDR_TCMP1, 32'hffff_ffff,4'hf);
		test_bench.apb_read(ADDR_TCMP0, reg_rdata);
		test_bench.apb_read(ADDR_TCMP1, reg_rdata);
		$display("===== cmp_64b = ffff_ffff_ffff_ffff ====="); 



		$display("===== Enable Interrupt =====");
		test_bench.apb_write(ADDR_TIER, 32'h0000_0001,4'h1);

		$display("===== Enable Counter =====");
		test_bench.apb_write(ADDR_TCR, 32'h0000_0001,4'h1);

		$display("===== Wait 16 cycle Timer Interrupt Is Asserted ====="); 
		repeat(16) @(test_bench.clk); #1;
			if(test_bench.tim_int == 1) 
			$display(">>> PASS <<< ==== Interrupt is asserted 1'b%b =====",test_bench.tim_int);
			else 
			$display(">>> FAIL <<< ==== Interrupt is not asserted Exp: 1'b%b Actual: 1'b%b =====", 1'b1, test_bench.tim_int);

		$display("===== Wait for more cycles =====");
		repeat(10) @(test_bench.clk); #1;
			if(test_bench.tim_int == 1) 
			$display(">>> PASS <<< ==== Interrupt is still asserted 1'b%b =====",test_bench.tim_int);
			else 
			$display(">>> FAIL <<< ==== Interrupt is deassert Exp: 1'b%b Actual: 1'b%b =====", 1'b1, test_bench.tim_int);




		$display("==============================================");
		$display("=====[    Interrupt Masking by TIER    ]======");
		$display("==============================================");

		$display("===== Disable Interrupt =====");
		test_bench.apb_write(ADDR_TIER, 32'h0000_0000,4'h1);

		$display("===== Check Interrupt & Interrupt Status =====");
		@(test_bench.clk);#1;
			if(test_bench.tim_int == 0) 
			$display(">>> PASS <<< ==== Interrupt is deasserted => tim.int = 1'b%b =====",test_bench.tim_int);
			else 
			$display(">>> FAIL <<< ==== Interrupt is not deasserted | Exp: 1'b%b Actual: 1'b%b =====",1'b0, test_bench.tim_int);



		$display("===== Interrupt Status =====");
		test_bench.apb_read(ADDR_TISR, reg_rdata);
			if(reg_rdata == 32'h0000_0001) 
			$display(">>> PASS <<< ==== Interrupt status (TISR.int_st) is still = 1 =====");
			else 
			$display(">>> FAIL <<< ==== Interrupt status (TISR.int_st) is = 0 =======");




		$display("=================================================");
		$display("==[  RW1C clear both TISR.int_st & tim.int    ]==");
		$display("=================================================");


		$display("===== Set Value To TDR0, TDR1 ====="); 
		test_bench.apb_write(ADDR_TDR0, 32'h0000_0000,4'hf);
		test_bench.apb_write(ADDR_TDR1, 32'h0000_000f,4'hf);
		test_bench.apb_read(ADDR_TDR0, reg_rdata);
		test_bench.apb_read(ADDR_TDR1, reg_rdata);
		$display("===== cnt_64b = 0000_0000_0000_0000 ====="); 

		$display("===== Set Value To TCMP0, TCMP1 ====="); 
		test_bench.apb_write(ADDR_TCMP0, 32'hffff_fff0,4'hf);
		test_bench.apb_write(ADDR_TCMP1, 32'hffff_ffff,4'hf);
		test_bench.apb_read(ADDR_TCMP0, reg_rdata);
		test_bench.apb_read(ADDR_TCMP1, reg_rdata);
		$display("===== cmp_64b = 0000_0000_0000_000f ====="); 

		$display("===== Enable Interrupt =====");
		test_bench.apb_write(ADDR_TIER, 32'h0000_0001,4'h1);

		$display("===== Enable Counter =====");
		test_bench.apb_write(ADDR_TCR, 32'h0000_0001,4'h1);



		$display("===== Wait 18 cycle to check Timer Interrupt Is Asserted or not ====="); 
		repeat(18) @(test_bench.clk);#1
			if(test_bench.tim_int == 1) 
			$display(">>> PASS <<<==== Interrupt is asserted 1'b%b =====",test_bench.tim_int);
			else 
			$display(">>> FAIL <<< ==== Interrupt is not asserted Exp: 1'b%b Actual: 1'b%b =====", 1'b1, test_bench.tim_int);


		$display("===== Write 1 to clear TISR.int_st =====");
		test_bench.apb_write(ADDR_TISR, 32'h0000_0001,4'h1);

		$display("===== Check Interrupt = 0 ? & Interrupt Status = 0? =====");
			if(test_bench.tim_int == 0) 
			$display(">>> PASS <<<==== Interrupt is deasserted => tim.int = 1'b%b =====",test_bench.tim_int);
			else 
			$display(">>> FAIL <<< ==== Interrupt is not deasserted | Exp: 1'b%b Actual: 1'b%b =====", 1'b0, test_bench.tim_int);


		$display("===== Interrupt Status =====");
		test_bench.apb_read(ADDR_TISR, reg_rdata);
			@(test_bench.clk);#1;
			if(reg_rdata == 32'h0000_0000) 
			$display(">>> PASS <<< ==== Interrupt status (TISR.int_st) cleared to 0  =====");
			else 
			$display(">>> FAIL <<< ==== Interrupt status (TISR.int_st) is NOT cleared to 0 =======");


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


