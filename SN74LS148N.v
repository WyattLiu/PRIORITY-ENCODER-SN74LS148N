module SN74LS148N (
input EI, zero, one, two, three, four, five, six, seven, // EI, enable input, active low
output A2,A1,A0,
output reg GS,EO												// EO, enable output, active high, GS should be low until outputs are stable (implement experimentally)
);

wire [7:0] dataIn;
reg [2:0] dataOut;

assign dataIn[0] = zero;
assign dataIn[1] = one;
assign dataIn[2] = two;
assign dataIn[3] = three;
assign dataIn[4] = four;
assign dataIn[5] = five;
assign dataIn[6] = six;
assign dataIn[7] = seven;

assign A2=dataOut[2];
assign A1=dataOut[1];
assign A0=dataOut[0];

always@* begin
	if(EI) begin
		dataOut=3'b111;
		GS=1'b1;
		EO=1'b1;
	end
	else begin
		if(dataIn==8'b11111111) begin 
			dataOut=3'b111;
			GS=1'b1;
			EO=1'b0;
		end
		else begin
			GS=1'b0;
			EO=1'b1;
			casez(dataIn) 
				8'b???????0:dataOut=3'b000;
				8'b??????01:dataOut=3'b001;
				8'b?????011:dataOut=3'b010;
				8'b????0111:dataOut=3'b011;
				8'b???01111:dataOut=3'b100;
				8'b??011111:dataOut=3'b101;
				8'b?0111111:dataOut=3'b110;
				8'b01111111:dataOut=3'b111;
				default: begin
					dataOut=3'b000;
					GS = 1'b1;
					EO = 1'b1;
				end
			endcase
		end
		
	end
end


endmodule