module tb();

	import "DPI-C" function byte get_input(input int id);
	import "DPI-C" function void process_output(input byte vga);
	import "DPI-C" function int c_init();
	import "DPI-C" function int c_update();

	reg clk;
	reg [7:0] vga;
	

	task progress_clk(integer cycles);
		integer i;
		for (i = 0; i < cycles; i = i + 1) begin
			#10; clk = ~clk;
		end
	endtask

	integer index;
	byte input_byte;
	integer ret;
	initial begin
		clk = 0;
		ret = c_init();
		progress_clk(10);
		for (index = 0; index < 10; index = index + 1) begin
			input_byte = get_input(index);
			progress_clk(5);
			$display("SV received %d", input_byte);
		end

		
		vga = 'hF3;
		$display("SV sent %d", vga); 
		process_output(vga);
	end
endmodule
