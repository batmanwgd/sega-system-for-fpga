module rotate_shift(data_in, op8, flags, data_out,flags_out);

input [7:0] data_in, op8;
input [7:0]flags;
output [15:0] data_out;
output [7:0] flags_out;


wire [7:0] data_in, op8;
wire [7:0] flags;

reg [15:0] data_out;
reg [7:0] flags_out;
reg par,zero;






	always@(data_in or flags or op8)  
	begin
	case(op8[3:0])
		4'b0: begin//RLC
					data_out= {{8{data_in[6]}},data_in[6:0],data_in[7]};
					zero=~|({data_in[6:0],data_in[7]});
					par=~^({data_in[6:0],data_in[7]});
					flags_out= {data_in[6],zero,flags[5],1'b0,flags[3],par,1'b0,data_in[7]};
					end					
		4'h1: begin//RLCA
					data_out={{8{data_in[6]}},data_in[6:0],data_in[7]};
					flags_out= {flags[7],flags[6],flags[5],1'b0,flags[3],flags[2],1'b0,data_in[7]};
					end
		4'h2: begin//RRC
					data_out={{8{data_in[0]}},data_in[0],data_in[7:1]};
					zero=~|({data_in[0],data_in[7:1]});
					par=~^({data_in[0],data_in[7:1]});
					flags_out= {data_in[0],zero,flags[5],1'b0,flags[3],par,1'b0,data_in[0]};
					end
		4'h3: begin//RRCA
					data_out={{8{data_in[0]}},data_in[0],data_in[7:1]};
					flags_out= {flags[7],flags[6],flags[5],1'b0,flags[3],flags[2],1'b0,data_in[0]};
					end
		4'h4: begin//RL
					data_out= {{8{data_in[6]}},data_in[6:0],flags[0]};
					zero=~|({data_in[6:0],flags[0]});
					par=~^({data_in[6:0],flags[0]});
					flags_out= {data_in[6],zero,flags[5],1'b0,flags[3],par,1'b0,data_in[7]};
					end	
		4'h5: begin//RLA
					data_out= {{8{data_in[6]}},data_in[6:0],flags[0]};
					flags_out= {flags[7],flags[6],flags[5],1'b0,flags[3],flags[2],1'b0,data_in[7]};
					end	
		4'h6: begin//RR
					data_out={{8{flags[0]}},flags[0],data_in[7:1]};
					zero=~|({flags[0],data_in[7:1]});
					par=~^({flags[0],data_in[7:1]});
					flags_out= {flags[0],zero,flags[5],1'b0,flags[3],par,1'b0,data_in[0]};
					end
		4'h7: begin//RRA
					data_out={{8{flags[0]}},flags[0],data_in[7:1]};
					flags_out= {flags[7],flags[6],flags[5],1'b0,flags[3],flags[2],1'b0,data_in[0]};
					end
		4'h8: begin//SLA
					data_out= {{8{data_in[6]}},data_in[6:0],1'b0};
					zero=~|( {data_in[6:0],1'b0});
					par=~^({data_in[6:0],1'b0});
					flags_out= {data_in[6],zero,flags[5],1'b0,flags[3],par,1'b0,data_in[7]};
					end
		4'h9: begin//SRA
					data_out={{8{data_in[7]}},data_in[7],data_in[7:1]};
					zero=~|({data_in[7],data_in[7:1]});
					par=~^({data_in[7],data_in[7:1]});
					flags_out= {data_in[7],zero,flags[5],1'b0,flags[3],par,1'b0,data_in[0]};
					end
		4'hA: begin//SRL
					data_out={{8{1'b0}},1'b0,data_in[7:1]};
					zero=~|({1'b0,data_in[7:1]});
					par=~^({1'b0,data_in[7:1]});
					flags_out= {1'b0,zero,flags[5],1'b0,flags[3],par,1'b0,data_in[0]};
					end
		4'hB: begin//SLL
					data_out= {{8{data_in[6]}},data_in[6:0],1'b1};
					zero=~|({data_in[6:0],1'b0});
					par=~^({data_in[6:0],1'b0});
					flags_out= {data_in[6],zero,flags[5],1'b0,flags[3],par,1'b0,data_in[7]};
					end
		
		default:  begin
						data_out= 8'b0;
						zero=1'b0;
						par=1'b0;
						flags_out=8'b0;
						end

		endcase		
	end//always
endmodule
