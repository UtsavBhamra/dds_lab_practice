module full_adder(output sum,cout,input a,b,c);

assign sum = a^b^c;
assign cout = (a&b) | (b&c) | (c&a);

endmodule