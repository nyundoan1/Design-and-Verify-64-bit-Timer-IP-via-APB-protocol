task run_test;
reg [63:0] reg_cnt;
integer i;
begin 
	$display("=============================================");
	$display("[              Pat name: COUNTER             ]");
	$display("==============================================");
	$display("==========[  COUNTER DEFAULT MODE   ]=========");
	$display("==============================================");

	test_bench.run_timer(64'h0000_0000_0000_0000 , 4'h3 , 1'b0 , 5 , reg_cnt ); //run_timer( init_cnt, in_div_val, in_div_en, n clk , cnt_after_n_clk )
	test_bench.check_cnt64(reg_cnt , 64'h0000_0000_0000_0005 );

	test_bench.run_timer(64'h0000_0000_0000_0003 , 4'h0 , 1'b1 , 3 , reg_cnt );
	test_bench.check_cnt64(reg_cnt , 64'h0000_0000_0000_0006 );


	test_bench.run_timer(64'h1234_1234_1234_1230 , 4'h0 , 1'b0 , 7 , reg_cnt );
	test_bench.check_cnt64(reg_cnt , 64'h1234_1234_1234_1237 );

	$display("==============================================");
	$display("==========[     COUNTER DIV MODE    ]=========");
	$display("==============================================");
	
	test_bench.run_timer(64'h0000_0000_0000_0000 , 4'h1 , 1'b1 , 2 , reg_cnt );
	test_bench.check_cnt64(reg_cnt , 64'h0000_0000_0000_0001 );

	test_bench.run_timer(64'h0000_0000_0000_0000 , 4'h2 , 1'b1 , 4 , reg_cnt );
	test_bench.check_cnt64(reg_cnt , 64'h0000_0000_0000_0001 );

	test_bench.run_timer(64'h0000_0000_0000_0000 , 4'h3 , 1'b1 , 8 , reg_cnt );
	test_bench.check_cnt64(reg_cnt , 64'h0000_0000_0000_0001 );

	test_bench.run_timer(64'h0000_0000_0000_0000 , 4'h4 , 1'b1 , 16 , reg_cnt );
	test_bench.check_cnt64(reg_cnt , 64'h0000_0000_0000_0001 );

	test_bench.run_timer(64'h0000_0000_0000_0000 , 4'h5 , 1'b1 , 32 , reg_cnt );
	test_bench.check_cnt64(reg_cnt , 64'h0000_0000_0000_0001 );

	test_bench.run_timer(64'h0000_0000_0000_0000 , 4'h6 , 1'b1 , 64 , reg_cnt );
	test_bench.check_cnt64(reg_cnt , 64'h0000_0000_0000_0001 );

	test_bench.run_timer(64'h0000_0000_0000_0000 , 4'h7 , 1'b1 , 128 , reg_cnt );
	test_bench.check_cnt64(reg_cnt , 64'h0000_0000_0000_0001 );

	test_bench.run_timer(64'h0000_0000_0000_0000 , 4'h8 , 1'b1 , 256 , reg_cnt );
	test_bench.check_cnt64(reg_cnt , 64'h0000_0000_0000_0001 );


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


