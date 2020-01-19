/* This module receives information bits from packet generation module and sends out parameters necessary to configure polar encoder.
 */

#include "/home/puja/Downloads/finalcodes/ControlChannelEncoder.h"

using namespace std;


void config_encoder(strm_t &out, strm_32 &ctrl, strm_128 &din, strm_8 &dwords,strm_8 &doutwords)
{
#pragma HLS INTERFACE axis port = out
#pragma HLS INTERFACE axis port = ctrl
#pragma HLS INTERFACE axis port = din
#pragma HLS INTERFACE axis port = dwords
#pragma HLS INTERFACE axis port = doutwords
#pragma HLS DATAFLOW
	ap_uint<32> ctrl_t;
	ap_uint<128> din_t;
	ap_uint<8> dwords_t;
	ap_uint<8> doutwords_t;
	data_bus data;


	data = data_bus(out.read());

	din_t = data;

	ctrl_t.range(31,24) = 0x00;
     ctrl_t.range(23,8)  = 0x0000;
	ctrl_t.range(6,0)   = 0x00;

	dwords_t = 0x05;

	doutwords_t = 0x10;

	ctrl.write(ctrl_t);
	din.write(din_t);
	dwords.write(dwords_t);
	doutwords.write(doutwords_t);

}

