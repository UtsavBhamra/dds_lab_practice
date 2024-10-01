module test();

wire [3:0] sum;
wire cout;
reg [3:0] a;
reg [3:0] b;
reg c;

bcd uut(sum,cout,a,b,c);

initial begin
    $dumpfile("visualize.vcd");
    $dumpvars(0,test);
end

initial begin
    $display("a b cin | cout sum");
    $monitor("%b %b %b | %b %b",a,b,c,cout,sum);
    for(integer i=0;i<10;i=i+1)begin
        a=i;b=i-2;c=0;
        #10;
    end
end

endmodule