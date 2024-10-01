module test();

wire [3:0] sum;
wire cout;
reg [3:0] a;
reg [3:0] b;
reg cin;

cla uut(sum,cout,a,b,cin);

initial begin
    $dumpfile("visualize.vcd");
    $dumpvars(0,test);
end

initial begin
    $monitor("%b %b %b | %b %b",a,b,cin,sum,cout);
    for(integer i=0;i<16;i=i+1)begin
        a=i;b=i;cin=0;
        #10;
    end
    $finish;
end

endmodule