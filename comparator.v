module comparator(output g, output e,output l,input [3:0] a,input [3:0] b);

assign g = (a[3]&&~b[3]) || (~(a[3]^b[3])&&(a[2]&~b[2])) || (~(a[3]^b[3]) && ~(a[2]^b[2]) && (a[1]&&~b[1])) || (~(a[3]^b[3]) && ~(a[2]^b[2]) && ~(a[1]^b[1]) &&(a[0]&&~b[0]));
assign e = ~(a[3]^b[3]) && ~(a[2]^b[2]) && ~(a[1]^b[1]) && ~(a[0]^b[0]);
assign l = ~g & ~e;

endmodule

module comparator2(output reg g,output reg e,output reg l,input [3:0] a,input [3:0] b);

always @(*) begin
    g=0;
    e=0;
    l=0;
    if(a[2]>b[2])begin
        g=1;
    end
    else if(a[2]<b[2])begin
        l=1;
    end
    else begin
        if(a[1]>b[1])begin
            g=1;
        end
        else if(a[1]<b[1])begin
            l=1;
        end
        else begin
            if(a[0]>b[0])begin
                g=1;
            end
            else if(a[0]<b[0])begin
                l=1;
            end
            else begin
                e=1;
            end
        end
    end
end

endmodule