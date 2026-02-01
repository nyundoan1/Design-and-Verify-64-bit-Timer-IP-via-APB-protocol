module interrupt 
(
input wire int_en,
input wire int_st,
output wire interrupt
);
assign interrupt = int_en & int_st;
endmodule




