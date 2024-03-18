module aes_main(clk,data_out,out,clk_out);
input clk;
output reg out,clk_out;
output  [127:0] data_out;

reg [31:0]count,pointer;
initial pointer=0;

 wire [127:0]r_data_out,r0_data_out,r1_data_out,r2_data_out,r3_data_out,r4_data_out,r5_data_out,r6_data_out,r7_data_out,r8_data_out,r9_data_out;

// reg [127:0]data_in=128'h0123456789ABCDEF0123456789ABCDEF;
//reg [127:0]key=128'h63530493046353049304635304930463;
reg [127:0]data_in=128'h3243F6A8885A308D313198A2E0370734;
reg [127:0]key=128'h2B7E151628AED2A6ABF7158809CF4F3C;

wire[127:0] key_s,key_s0,key_s1,key_s2,key_s3,key_s4,key_s5,key_s6,key_s7,key_s8,key_s9;
assign r_data_out=data_in^key_s;
aes_key_expand_128 a0( clk,key,key_s,key_s0,key_s1,key_s2,key_s3,key_s4,key_s5,key_s6,key_s7,key_s8,key_s9);
round r0(clk,r_data_out,key_s0,r0_data_out);
round r1(clk,r0_data_out,key_s1,r1_data_out);
round r2(clk,r1_data_out,key_s2,r2_data_out);
round r3(clk,r2_data_out,key_s3,r3_data_out);
round r4(clk,r3_data_out,key_s4,r4_data_out);
round r5(clk,r4_data_out,key_s5,r5_data_out);
round r6(clk,r5_data_out,key_s6,r6_data_out);
round r7(clk,r6_data_out,key_s7,r7_data_out);
round r8(clk,r7_data_out,key_s8,r8_data_out);
last_round r9(clk,r8_data_out,key_s9,r9_data_out);

assign data_out=r9_data_out;





always @(posedge clk & data_out)
begin
if(count == 50000000) begin 
    count <= 0;	 
	 if(pointer<129)
	 begin
	 clk_out=~clk_out;
    out=data_out[pointer];
	 pointer=pointer+1;
	 end
end 
else begin
    count <= count + 1;     
    end
end

/*
always @(data_out)
begin

for(i=0;i<=31;i++)
begin

if(data_out[4*i+4 : 4*i]<=4'b1001)
lcd_data[8*i + 8:8*i] <= data_out[4*i+4 : 4*i] +8'h30 ;
else
lcd_data[8*i + 8:8*i] <= data_out[4*i+4 : 4*i] +8'h40 ;
end
end
*/
endmodule
