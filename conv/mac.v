//file: mac_manual.v
//note that this file has been modified after the addiion of fixed point arithmetic support
//this post has not been edited for the same keeping in mind first time readers. Do refer 
//to that post in this series.

module mac_manual #(
	parameter N = 18,
    parameter Q = 12
    )(
    input clk,sclr,
    input [N-1:0] a,
    input [N-1:0] b,
    input [N-1:0] c,
    output [10+N-1:0] p
    );
reg [N-1:0] q,cq; 
always@(posedge clk,posedge sclr)
 begin
    if(sclr)
    begin
        q <= 0;
        cq <=0;
    end
    else begin
        q <= a*b;                   //performs the multiply accumulate operation
        cq <= c;
    end
 end
 assign p = q + cq;
endmodule
