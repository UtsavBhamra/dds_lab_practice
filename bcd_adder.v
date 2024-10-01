module full_adder(output sum,output cout,input a,input b,input c);

assign sum = a^b^c;
assign cout = (a&b) | (b&c) | (c&a);

endmodule


module four_bit_adder(output [3:0] sum,output cout,input [3:0] a,input [3:0] b,input cin);

wire [3:0] carry;

full_adder c1(sum[0],carry[0],a[0],b[0],cin);
full_adder c2(sum[1],carry[1],a[1],b[1],carry[0]);
full_adder c3(sum[2],carry[2],a[2],b[2],carry[1]);
full_adder c4(sum[3],cout,a[3],b[3],carry[2]);

endmodule


module bcd(output [3:0] sum,output c_out,input [3:0] a,input [3:0] b,input cin);

wire [3:0] w1;
wire cout;
wire [3:0] w2;
wire temp;

four_bit_adder c1(w1,cout,a,b,cin);

assign w2[1] = (w1[3]&w1[2]) || (w1[3]&w1[1]) || (cout);
assign w2[2] = (w1[3]&w1[2]) || (w1[3]&w1[1]) || (cout);
assign w2[0] = 0;
assign w2[3] = 0;

assign temp=0;

four_bit_adder c2(sum,c_out,w2,w1,temp); //use 4 and 5 bit adder


endmodule