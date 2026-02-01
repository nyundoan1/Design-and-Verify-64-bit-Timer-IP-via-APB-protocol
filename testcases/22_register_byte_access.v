task run_test;
reg [31:0] reg_rdata;
begin 
	$display("=============================================");
	$display("[   Pat name: Check Register Byte Access    ]");
	$display("=============================================");


	$display("==============================================");
	$display("============[   TDR0 Register   ]=============");
	$display("==============================================");

	$display(">> [ TDR0 Byte 0 - PSTRB = 0001 ] <<");
	test_bench.apb_write(ADDR_TDR0, DF, 4'h1);
	test_bench.apb_read(ADDR_TDR0, reg_rdata);
	test_bench.compare_data(ADDR_TDR0, 32'h0000_00ff, reg_rdata, 32'h000000FF);

	$display(">> [ TDR0 Byte 1 - PSTRB = 0010 ] <<");
	test_bench.apb_write(ADDR_TDR0, DF, 4'h2);
	test_bench.apb_read(ADDR_TDR0, reg_rdata);
	test_bench.compare_data(ADDR_TDR0, 32'h0000_ff00, reg_rdata, 32'h0000FF00);

	$display(">> [ TDR0 Byte 2 - PSTRB = 0100 ] <<");
	test_bench.apb_write(ADDR_TDR0, DF, 4'h4);
	test_bench.apb_read(ADDR_TDR0, reg_rdata);
	test_bench.compare_data(ADDR_TDR0, 32'h00ff_0000, reg_rdata, 32'h00FF0000);

	$display(">> [ TDR0 Byte 3 - PSTRB = 1000 ] <<");
	test_bench.apb_write(ADDR_TDR0, DF, 4'h8);
	test_bench.apb_read(ADDR_TDR0, reg_rdata);
	test_bench.compare_data(ADDR_TDR0, 32'hff00_0000, reg_rdata, 32'hFF000000);

	$display(">> [ TDR0 Byte 0&1 - PSTRB = 0011 ] <<");
	test_bench.apb_write(ADDR_TDR0, DF, 4'h3);
	test_bench.apb_read(ADDR_TDR0, reg_rdata);
	test_bench.compare_data(ADDR_TDR0, 32'h0000_ffff, reg_rdata, 32'h0000FFFF);

	$display(">> [ TDR0 Byte 2&3 - PSTRB = 1100 ] <<");
	test_bench.apb_write(ADDR_TDR0, DF, 4'hC);
	test_bench.apb_read(ADDR_TDR0, reg_rdata);
	test_bench.compare_data(ADDR_TDR0, 32'hffff_0000, reg_rdata, 32'hFFFF0000);

	$display("==============================================");
	$display("============[   TDR1 Register   ]=============");
	$display("==============================================");

	$display(">> [ TDR1 Byte 0 - PSTRB = 0001 ] <<");
	test_bench.apb_write(ADDR_TDR1, DF, 4'h1);
	test_bench.apb_read(ADDR_TDR1, reg_rdata);
	test_bench.compare_data(ADDR_TDR1, 32'h0000_00ff, reg_rdata, 32'h000000FF);

	$display(">> [ TDR1 Byte 1 - PSTRB = 0010 ] <<");
	test_bench.apb_write(ADDR_TDR1, DF, 4'h2);
	test_bench.apb_read(ADDR_TDR1, reg_rdata);
	test_bench.compare_data(ADDR_TDR1, 32'h0000_ff00, reg_rdata, 32'h0000FF00);

	$display(">> [ TDR1 Byte 2 - PSTRB = 0100 ] <<");
	test_bench.apb_write(ADDR_TDR1, DF, 4'h4);
	test_bench.apb_read(ADDR_TDR1, reg_rdata);
	test_bench.compare_data(ADDR_TDR1, 32'h00ff_0000, reg_rdata, 32'h00FF0000);

	$display(">> [ TDR1 Byte 3 - PSTRB = 1000 ] <<");
	test_bench.apb_write(ADDR_TDR1, DF, 4'h8);
	test_bench.apb_read(ADDR_TDR1, reg_rdata);
	test_bench.compare_data(ADDR_TDR1, 32'hff00_0000, reg_rdata, 32'hFF000000);

	$display(">> [ TDR1 Byte 0&1 - PSTRB = 0011 ] <<");
	test_bench.apb_write(ADDR_TDR1, DF, 4'h3);
	test_bench.apb_read(ADDR_TDR1, reg_rdata);
	test_bench.compare_data(ADDR_TDR1, 32'h0000_ffff, reg_rdata, 32'h0000FFFF);

	$display(">> [ TDR1 Byte 2&3 - PSTRB = 1100 ] <<");
	test_bench.apb_write(ADDR_TDR1, DF, 4'hC);
	test_bench.apb_read(ADDR_TDR1, reg_rdata);
	test_bench.compare_data(ADDR_TDR1, 32'hffff_0000, reg_rdata, 32'hFFFF0000);


	$display("==============================================");
	$display("============[   TCMP0 Register   ]=============");
	$display("==============================================");

	$display(">> [ TCMP0 Byte 0 - PSTRB = 0001 ] <<");
	test_bench.apb_write(ADDR_TCMP0, DF, 4'h1);
	test_bench.apb_read(ADDR_TCMP0, reg_rdata);
	test_bench.compare_data(ADDR_TCMP0, 32'h0000_00ff, reg_rdata, 32'h000000FF);

	$display(">> [ TCMP0 Byte 1 - PSTRB = 0010 ] <<");
	test_bench.apb_write(ADDR_TCMP0, DF, 4'h2);
	test_bench.apb_read(ADDR_TCMP0, reg_rdata);
	test_bench.compare_data(ADDR_TCMP0, 32'h0000_ff00, reg_rdata, 32'h0000FF00);

	$display(">> [ TCMP0 Byte 2 - PSTRB = 0100 ] <<");
	test_bench.apb_write(ADDR_TCMP0, DF, 4'h4);
	test_bench.apb_read(ADDR_TCMP0, reg_rdata);
	test_bench.compare_data(ADDR_TCMP0, 32'h00ff_0000, reg_rdata, 32'h00FF0000);

	$display(">> [ TCMP0 Byte 3 - PSTRB = 1000 ] <<");
	test_bench.apb_write(ADDR_TCMP0, DF, 4'h8);
	test_bench.apb_read(ADDR_TCMP0, reg_rdata);
	test_bench.compare_data(ADDR_TCMP0, 32'hff00_0000, reg_rdata, 32'hFF000000);

	$display(">> [ TCMP0 Byte 0&1 - PSTRB = 0011 ] <<");
	test_bench.apb_write(ADDR_TCMP0, DF, 4'h3);
	test_bench.apb_read(ADDR_TCMP0, reg_rdata);
	test_bench.compare_data(ADDR_TCMP0, 32'h0000_ffff, reg_rdata, 32'h0000FFFF);

	$display(">> [ TCMP0 Byte 2&3 - PSTRB = 1100 ] <<");
	test_bench.apb_write(ADDR_TCMP0, DF, 4'hC);
	test_bench.apb_read(ADDR_TCMP0, reg_rdata);
	test_bench.compare_data(ADDR_TCMP0, 32'hffff_0000, reg_rdata, 32'hFFFF0000);


	$display("==============================================");
	$display("============[   TCMP1 Register   ]=============");
	$display("==============================================");

	$display(">> [ TCMP1 Byte 0 - PSTRB = 0001 ] <<");
	test_bench.apb_write(ADDR_TCMP1, DF, 4'h1);
	test_bench.apb_read(ADDR_TCMP1, reg_rdata);
	test_bench.compare_data(ADDR_TCMP1, 32'h0000_00ff, reg_rdata, 32'h000000FF);

	$display(">> [ TCMP1 Byte 1 - PSTRB = 0010 ] <<");
	test_bench.apb_write(ADDR_TCMP1, DF, 4'h2);
	test_bench.apb_read(ADDR_TCMP1, reg_rdata);
	test_bench.compare_data(ADDR_TCMP1, 32'h0000_ff00, reg_rdata, 32'h0000FF00);

	$display(">> [ TCMP1 Byte 2 - PSTRB = 0100 ] <<");
	test_bench.apb_write(ADDR_TCMP1, DF, 4'h4);
	test_bench.apb_read(ADDR_TCMP1, reg_rdata);
	test_bench.compare_data(ADDR_TCMP1, 32'h00ff_0000, reg_rdata, 32'h00FF0000);

	$display(">> [ TCMP1 Byte 3 - PSTRB = 1000 ] <<");
	test_bench.apb_write(ADDR_TCMP1, DF, 4'h8);
	test_bench.apb_read(ADDR_TCMP1, reg_rdata);
	test_bench.compare_data(ADDR_TCMP1, 32'hff00_0000, reg_rdata, 32'hFF000000);

	$display(">> [ TCMP1 Byte 0&1 - PSTRB = 0011 ] <<");
	test_bench.apb_write(ADDR_TCMP1, DF, 4'h3);
	test_bench.apb_read(ADDR_TCMP1, reg_rdata);

	test_bench.compare_data(ADDR_TCMP1, 32'h0000_ffff, reg_rdata, 32'h0000FFFF);

	$display(">> [ TCMP1 Byte 2&3 - PSTRB = 1100 ] <<");
	test_bench.apb_write(ADDR_TCMP1, DF, 4'hC);
	test_bench.apb_read(ADDR_TCMP1, reg_rdata);
	test_bench.compare_data(ADDR_TCMP1, 32'hffff_0000, reg_rdata, 32'hFFFF0000);

	$display("=============================================");
	$display("============[    TCR Register    ]=============");
	$display("=============================================");

	$display(">> [ TCR Access Byte 0 - PSTRB = 0001 ] <<");
	test_bench.apb_write(ADDR_TCR, D3, 4'h1);
	test_bench.apb_read(ADDR_TCR, reg_rdata);
	test_bench.compare_data(ADDR_TCR, 32'h0000_0103, reg_rdata, 32'h000000FF);

	$display(">> [ TCR Access Byte 1 - PSTRB = 0010 ] <<");
	test_bench.apb_write(ADDR_TCR, D3, 4'h2);
	test_bench.apb_read(ADDR_TCR, reg_rdata);
	test_bench.compare_data(ADDR_TCR, 32'h0000_0103, reg_rdata, 32'h0000FF00);

	$display(">> [ TCR Access Byte 2 - PSTRB = 0100 ] <<");
	test_bench.apb_write(ADDR_TCR, D3, 4'h4);
	test_bench.apb_read(ADDR_TCR, reg_rdata);
	test_bench.compare_data(ADDR_TCR, 32'h0000_0103, reg_rdata, 32'h00FF0000);

	$display(">> [ TCR Access Byte 3 - PSTRB = 1000 ] <<");
	test_bench.apb_write(ADDR_TCR, D3, 4'h8);
	test_bench.apb_read(ADDR_TCR, reg_rdata);
	test_bench.compare_data(ADDR_TCR, 32'h0000_0103, reg_rdata, 32'hFF000000);

	$display(">> [ TCR Access Byte 0 & 1 - PSTRB = 0011 ] <<");
	test_bench.apb_write(ADDR_TCR, D3, 4'h3);
	test_bench.apb_read(ADDR_TCR, reg_rdata);
	test_bench.compare_data(ADDR_TCR, 32'h0000_0103, reg_rdata, 32'h0000FFFF);

	$display(">> [ TCR Access Byte 2 & 3 - PSTRB = 1100 ] <<");
	test_bench.apb_write(ADDR_TCR, D5, 4'hC);
	test_bench.apb_read(ADDR_TCR, reg_rdata);
	test_bench.compare_data(ADDR_TCR, 32'h0000_0103, reg_rdata, 32'hFFFF0000);

	$display("==============================================");
	$display("=============[   TIER Register   ]=============");
	$display("==============================================");

	$display(">> [ TIER Access Byte 0 - PSTRB = 0001 ] <<");
	test_bench.apb_write(ADDR_TIER, D5, 4'h1);
	test_bench.apb_read(ADDR_TIER, reg_rdata);
	test_bench.compare_data(ADDR_TIER, 32'h0000_0001, reg_rdata, 32'h000000FF); 

	$display(">> [ TIER Access Byte 1 - PSTRB = 0010 ] <<");
	test_bench.apb_write(ADDR_TIER, DF, 4'h2);
	test_bench.apb_read(ADDR_TIER, reg_rdata);
	test_bench.compare_data(ADDR_TIER, 32'h0000_0000, reg_rdata, 32'h0000FF00); 

	$display(">> [ TIER Access Byte 2 - PSTRB = 0100 ] <<");
	test_bench.apb_write(ADDR_TIER, DF, 4'h4);
	test_bench.apb_read(ADDR_TIER, reg_rdata);
	test_bench.compare_data(ADDR_TIER, 32'h0000_0000, reg_rdata, 32'h00FF0000);

	$display(">> [ TIER Access Byte 3 - PSTRB = 1000 ] <<");
	test_bench.apb_write(ADDR_TIER, DF, 4'h8);
	test_bench.apb_read(ADDR_TIER, reg_rdata);
	test_bench.compare_data(ADDR_TIER, 32'h0000_0000, reg_rdata, 32'hFF000000);

	$display(">> [ TIER Access Byte 0&1 - PSTRB = 0011 ] <<");
	test_bench.apb_write(ADDR_TIER, DF, 4'h3);
	test_bench.apb_read(ADDR_TIER, reg_rdata);
	test_bench.compare_data(ADDR_TIER, 32'h0000_0001, reg_rdata, 32'h0000FFFF);

	$display(">> [ TIER Access Byte 2&3 - PSTRB = 1100 ] <<");
	test_bench.apb_write(ADDR_TIER, DF, 4'h3);
	test_bench.apb_read(ADDR_TIER, reg_rdata);
	test_bench.compare_data(ADDR_TIER, 32'h0000_0001, reg_rdata, 32'hFFFF0000);

	$display("==============================================");
	$display("=============[   TISR Register   ]=============");
	$display("==============================================");

	$display(">> [ TISR Access Byte 0 - PSTRB = 0001 ] <<");
	test_bench.apb_write(ADDR_TISR, DF, 4'h1);
	test_bench.apb_read(ADDR_TISR, reg_rdata);
	test_bench.compare_data(ADDR_TISR, 32'h0000_0000, reg_rdata, 32'h000000FF);

	$display(">> [ TISR Access Byte 1 - PSTRB = 0010 ] <<");
	test_bench.apb_write(ADDR_TISR, DF, 4'h2);
	test_bench.apb_read(ADDR_TISR, reg_rdata);
	test_bench.compare_data(ADDR_TISR, 32'h0000_0000, reg_rdata, 32'h0000FF00);

	$display(">> [ TISR Access Byte 2 - PSTRB = 0100 ] <<");
	test_bench.apb_write(ADDR_TISR, DF, 4'h4);
	test_bench.apb_read(ADDR_TISR, reg_rdata);
	test_bench.compare_data(ADDR_TISR, 32'h0000_0000, reg_rdata, 32'h00FF0000);

	$display(">> [ TISR Access Byte 3 - PSTRB = 1000 ] <<");
	test_bench.apb_write(ADDR_TISR, DF, 4'h8);
	test_bench.apb_read(ADDR_TISR, reg_rdata);
	test_bench.compare_data(ADDR_TISR, 32'h0000_0000, reg_rdata, 32'hFF000000);

	$display(">> [ TISR Access Byte 0 & 1 - PSTRB = 0011 ] <<");
	test_bench.apb_write(ADDR_TISR, DF, 4'h3);
	test_bench.apb_read(ADDR_TISR, reg_rdata);
	test_bench.compare_data(ADDR_TISR, 32'h0000_0000, reg_rdata, 32'h0000FFFF);

	$display(">> [ TISR Access Byte 2 & 3 - PSTRB = 1100 ] <<");
	test_bench.apb_write(ADDR_TISR, DF, 4'h3);
	test_bench.apb_read(ADDR_TISR, reg_rdata);
	test_bench.compare_data(ADDR_TISR, 32'h0000_0000, reg_rdata, 32'h0000FFFF);

	$display("==============================================");
	$display("============[   THCSR Register   ]=============");
	$display("==============================================");

	$display(">> [ THCSR Access Byte 0 - PSTRB = 0001 ] <<");
	test_bench.apb_write(ADDR_THCSR, D5, 4'h1);
	test_bench.apb_read(ADDR_THCSR, reg_rdata);
	test_bench.compare_data(ADDR_THCSR, 32'h0000_0001, reg_rdata, 32'h000000FF);

	$display(">> [ THCSR Access Byte 1 - PSTRB = 0010 ] <<");
	test_bench.apb_write(ADDR_THCSR, DF, 4'h2);
	test_bench.apb_read(ADDR_THCSR, reg_rdata);
	test_bench.compare_data(ADDR_THCSR, 32'h0000_0000, reg_rdata, 32'h0000FF00);

	$display(">> [ THCSR Access Byte 2 - PSTRB = 0100 ] <<");
	test_bench.apb_write(ADDR_THCSR, DF, 4'h4);
	test_bench.apb_read(ADDR_THCSR, reg_rdata);
	test_bench.compare_data(ADDR_THCSR, 32'h0000_0000, reg_rdata, 32'h00FF0000);

	$display(">> [ THCSR Access Byte 3 - PSTRB = 1000 ] <<");
	test_bench.apb_write(ADDR_THCSR, DF, 4'h8);
	test_bench.apb_read(ADDR_THCSR, reg_rdata);
	test_bench.compare_data(ADDR_THCSR, 32'h0000_0000, reg_rdata, 32'hFF000000);

	$display(">> [ THCSR Access Byte 0 & 1 - PSTRB = 0011 ] <<");
	test_bench.apb_write(ADDR_THCSR, DF, 4'h3);
	test_bench.apb_read(ADDR_THCSR, reg_rdata);
	test_bench.compare_data(ADDR_THCSR, 32'h0000_0001, reg_rdata, 32'h0000FFFF);

	$display(">> [ THCSR Access Byte 2 & 3 - PSTRB = 1100 ] <<");
	test_bench.apb_write(ADDR_THCSR, DF, 4'h3);
	test_bench.apb_read(ADDR_THCSR, reg_rdata);
	test_bench.compare_data(ADDR_THCSR, 32'h0000_0001, reg_rdata, 32'hFFFF0000);

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

