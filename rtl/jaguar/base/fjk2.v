//`include "defs.v"

module fjk2
(
	output	q,
	output	qn,
	input		j,
	input		k,
	input		cp,
	input		cd,
	input	sys_clk
);

reg	data = 1'b0;

assign q = data;
assign qn = ~data;
reg old_cp, old_cd;

// always @(posedge cp or negedge cd)
always @(posedge sys_clk)
begin
	old_cp <= cp;
	old_cd <= cd;

	if ((~old_cp && cp) | (old_cd && ~cd)) begin
		if (~cd) begin
			data <= 1'b0;
		end else begin
			if (~j & k) begin
				data <= 1'b0;
			end else if (j & ~k) begin
				data <= 1'b1;
			end else if (j & k) begin
				data <= ~data;
			end
		end
	end
end

endmodule
