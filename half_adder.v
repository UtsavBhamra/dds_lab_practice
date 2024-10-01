module half_adder(
    output o,output cout,
    input a,input b
);

assign o = a^b;
assign cout = (a&&b); 

endmodule