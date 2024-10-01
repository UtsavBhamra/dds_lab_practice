module test();

wire [3:0] sum;
wire cout;
reg cin;
reg [3:0] a;
reg [3:0] b;

four_bit_adder uut(sum,cout,a,b,cin);

initial begin
    $dumpfile("visualize.vcd");
    $dumpvars(0,test);
end

initial begin
    $display("A | B | cin | sum | cout");
    $monitor("%b %b %b | %b %b",a,b,cin,sum,cout);
    for(integer i=0;i<15;i=i+1)begin
        a=i;b=i;cin=0;
        #10;
    end
    $finish;
end

endmodule