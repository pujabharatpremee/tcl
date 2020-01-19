/*
 * Author : Puja Kumari
 * soft data is of 8 bit. 6 bit corresponding
	 * to integer part and remaining 2 bit to decimal part.
	 * -31.75 : 10000001 map to 1b0
	 *  31.75 : 01111111 map to 1b1
 * hard_data_width : 1024 ; 8 packets of 128 bit; one transaction : 8 iteration
 * soft_data_width : 8192; 64 packets of 128 bit; one transaction : 64 iteration
 */


#include "/home/puja/Documents/decoder/custom_ip/llr_subfunction/llr.h"
using namespace hls;
using namespace std;

int bit2llr(axi128_stream &soft_data, axi128_stream &hard_data){

#pragma HLS INTERFACE axis port=soft_data
#pragma HLS INTERFACE axis port=hard_data
#pragma HLS PIPELINE
//#pragma HLS DATAFLOW

	ap_uint<AP_INT_MAX> soft_data_t;
	axi soft_data_t1;
	axi hard_data_t;
	ap_uint<1> tlast_t;
	data_bus data1;
	int k;

	for (int i = 0; i<hard_transaction; i++){
		hard_data_t = hard_data.read();
		data1 = hard_data_t.data.range(127,0);
		tlast_t = hard_data_t.tlast;

	//if(!tlast_t){
		for (int j = 0; j<128; j++){
			if(data1.bit(j) == 1)
				soft_data_t.range(((8*j)+7),8*j) = 0x7f;
			else
				soft_data_t.range(((8*j)+7),8*j) = 0x81;
		} //for loop; each 128 bit packet of hard data

		for (int j = 0; j<8; j++){

			k = j*128;
			soft_data_t1.data.range(127,0) = soft_data_t.range(k+127,k);

			if (soft_data_packet == soft_transaction){
				soft_data_t1.tlast = 1;
				soft_data_packet = 1;
			} //for loop

			else
				soft_data_t1.tlast = 0;

			soft_data.write(soft_data_t1);   /// pushing each 128 bit over soft data bus
			soft_data_packet = soft_data_packet + 1;

		} // for loop; for each 1024 bit of soft data corresponding to  128 hard data


	//} // if loop

	}


	return 0;
}
