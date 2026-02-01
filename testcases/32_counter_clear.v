task run_test;
reg [63:0] reg_cnt;
begin 
	$display("====================================================");
	$display("[              Pat name: COUNTER CLEAR             ]");
	$display("====================================================");
	$display("============[      COUNTER COUNT      ]=============");
	$display("====================================================");

	test_bench.run_timer(64'h0000_0000_0000_0000 , 4'h1 , 1'b0 , 8 , reg_cnt );
	test_bench.check_cnt64(reg_cnt , 64'h0000_0000_0000_0008 );

	$display("===================================================");
	$display("==========[ WRITE TIMER_EN = 0 TO CLEAR  ]=========");
	$display("===================================================");

	test_bench.apb_write(ADDR_TCR, 32'h0, 4'h1);
	test_bench.apb_read(ADDR_TDR0, reg_cnt[31:0]);
	test_bench.apb_read(ADDR_TDR1, reg_cnt[63:32]);
	
	test_bench.check_cnt64(reg_cnt , 64'h0 );
	repeat (100) @(posedge test_bench.clk); 

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

