module RF_Stage(Iword, mem_pipe_stall, flush1, PCupdate, EXE_targetPC,
							MEM_Wr_id, MEM_Fmask, MEM_Result, MEM_Flags, CLK, RST, 
							opcode_help, Imm, Wr_id, Fmask, EOI, 
							Rd_data0, Rd0_id, Rd_data1, Rd1_id, seqNPC, pipe_stall, targetPC, bubble, EOI_RF_stage);


//inputs from translator
input [38:0] Iword;
input mem_pipe_stall;

//inputs from exe_stage
input flush1;
input PCupdate;
input [15:0] EXE_targetPC;
//input [5:0] EXE_opcode;
//input [4:0] EXE_Wr_id;
//input [7:0] EXE_Fmask;

//inputs from mem stage
input [4:0] MEM_Wr_id;
input [7:0] MEM_Fmask;		
input [15:0] MEM_Result;
input [7:0] MEM_Flags; 

//other inputs
input CLK;
input RST;

//outputs through exe_stage latch
output [5:0] opcode_help;
output [15:0] Imm;
output [4:0] Wr_id;
output [7:0] Fmask;
output EOI;

output [15:0] Rd_data0;
output [4:0] Rd0_id;

output [15:0] Rd_data1;
output [4:0] Rd1_id;

output [15:0] seqNPC;

//outputs to translator
output pipe_stall;
output [15:0] targetPC;

//outputs to exe_stage
output bubble;
output EOI_RF_stage;

//internal wires
wire [15:0] Imm_in;
wire [4:0] Wr_id_in;
wire [4:0] Rd0_id_in;
wire [4:0] Rd1_id_in;
wire [15:0] Rd_data0_in;
wire [15:0] Rd_data1_in;
//wire pipe_stall_in;
//wire [15:0] seqNPC_in;
wire flush_in;
wire [5:0] opcode_help;

//module instanciation
//fields_decoder, PC_update, RF, dep_check, RF_stage_latch

fields_decoder fd(Iword, Rd0_id_in, Rd1_id_in, Imm_in, Wr_id_in);

or or1(pipe_stall, mem_pipe_stall, bubble);

wire [15:0] NULL;
PC_update pc_up(CLK, RST, Iword[38:36], NULL, targetPC, EXE_targetPC, PCupdate, pipe_stall);

RF r_file(CLK, RST, Rd0_id_in, Rd1_id_in, Rd_data0_in, Rd_data1_in, MEM_Wr_id, MEM_Result, MEM_Fmask, MEM_Flags);

dep_check dpchk(opcode_help, Wr_id, Fmask, Rd0_id_in, Rd1_id_in, bubble);

or or2(flush_in, bubble, flush1);

RF_stage_latch latch1(CLK,RST,
                      Iword[26:21],Wr_id_in,Iword[35:28],Imm_in,
                      Iword[27],Rd_data0_in,Rd0_id_in,
                      Rd_data1_in,Rd1_id_in,targetPC,
                      flush_in,mem_pipe_stall,
                      opcode_help,Wr_id,Fmask,Imm,
                      EOI,Rd_data0,Rd0_id,
                      Rd_data1,Rd1_id,seqNPC);


buf buff1(EOI_RF_stage, Iword[27]);



endmodule
