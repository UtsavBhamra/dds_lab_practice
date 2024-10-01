module cla(output [3:0] sum,output cout,input [3:0] a,input [3:0] b,input cin);

wire [3:0] p;
wire [3:0] g;
wire [3:0] carry;

assign p = a^b;
assign g = a&b;

assign carry[0] = g[0] || (cin&&p[0]);
assign carry[1] = g[1] || (carry[0] && p[1]);
assign carry[2] = g[2] || (carry[1]&& p[2]);
assign cout = g[3] || (carry[2] && p[3]);

assign sum[0] = a[0] ^ b[0] ^ cin;
assign sum[1] = a[1] ^ b[1] ^ carry[0];
assign sum[2] = a[2] ^ b[2] ^ carry[1];
assign sum[3] = a[3] ^ b[3] ^ carry[2];

endmodule