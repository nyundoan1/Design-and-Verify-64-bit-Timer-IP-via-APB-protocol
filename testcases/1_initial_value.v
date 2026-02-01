task run_test;
reg [31:0] reg_data;
	begin 
		$display("================================================");
		$display("[       Pat name: Check reset value            ]");
		$display("================================================");



		$display("====== > TDR0 Register < ========="); 
		test_bench.apb_read(ADDR_TDR0, reg_data);
		test_bench.compare_data(ADDR_TDR0, 32'h0000_0000, reg_data, 32'hFFFF_FFFF);

		$display("====== > TDR1 Register < ========="); 
		test_bench.apb_read(ADDR_TDR1, reg_data);
		test_bench.compare_data(ADDR_TDR1, 32'h0000_0000, reg_data, 32'hFFFF_FFFF);

		$display("====== > TCMP0 Register < ========="); 
		test_bench.apb_read(ADDR_TCMP0, reg_data);
		test_bench.compare_data(ADDR_TCMP0, 32'hffff_ffff, reg_data, 32'hFFFF_FFFF); 

		$display("====== > TCMP1 Register < ========="); 
		test_bench.apb_read(ADDR_TCMP1, reg_data);
		test_bench.compare_data(ADDR_TCMP1, 32'hffff_ffff, reg_data, 32'hFFFF_FFFF); 

		$display("====== > TIER Register < ========="); 
		test_bench.apb_read(ADDR_TIER, reg_data);
		test_bench.compare_data(ADDR_TIER, 32'h0000_0000, reg_data, 32'hFFFF_FFFF); 

		$display("====== > TISR Register < ========="); 
		test_bench.apb_read(ADDR_TISR, reg_data);
		test_bench.compare_data(ADDR_TISR, 32'h0000_0000, reg_data, 32'hFFFF_FFFF); 

		$display("====== > THCSR Register < =========");
		test_bench.apb_read(ADDR_THCSR, reg_data);
		test_bench.compare_data(ADDR_THCSR, 32'h0000_0000, reg_data, 32'hFFFF_FFFF); 

		$display("====== > TCR Register < ========="); 
		test_bench.apb_read(ADDR_TCR, reg_data);
		test_bench.compare_data(ADDR_TCR, 32'h0000_0100, reg_data, 32'hFFFF_FFFF);
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


