// cla4.v
// Gate-level 4-bit carry-lookahead adder, matching the lecture circuit.
// Every gate needs an explicit delay (constant is fine here, e.g. #(2)) --
// this is the default from Task 2 onward, not a special step.
//
// TODO -- Step 1: generate/propagate signals (one xor + one and per bit)
//   p[i] = a[i] ^ b[i]
//   g[i] = a[i] & b[i]
//
// TODO -- Step 2: direct (non-recursive) carry equations. Verilog's and/or
// primitives accept more than 2 inputs directly, e.g.:
//   and #(2) (t2, p1, p0, g0);
// so you do not need to manually chain 2-input gates.
//   c1 = g0 + p0.cin
//   c2 = g1 + p1.g0 + p1.p0.cin
//   c3 = g2 + p2.g1 + p2.p1.g0 + p2.p1.p0.cin
//   c4 = g3 + p3.g2 + p3.p2.g1 + p3.p2.p1.g0 + p3.p2.p1.p0.cin
//
// TODO -- Step 3: sum bits
//   sum[i] = p[i] ^ c[i]     (c0 = cin)




module FA_Gate(
    input a,
    input b,
    input cin,
    output sum,
    output cout
);

    wire ps, pc1, pc2;

    xor #(2)(ps, a, b);
    and #(2)(pc1, a, b);
    xor #(2)(sum, cin, ps);
    and #(2)(pc2, cin, ps);
    or  #(2)(cout, pc1, pc2);

endmodule


module cla4(
  input  [3:0] a,
  input  [3:0] b,
  input        cin,
  output [3:0] sum,
  output       cout
);

  wire p0, p1, p2, p3;
  wire g0, g1, g2, g3;
  wire c1, c2, c3;

  // TODO: your gate-level P/G, carry, and sum logic goes here.
  // (cout should be connected to c4.) Remember the delay on every gate.

wire t1,t2,t3,t4,t5,t6,t7,t8,t9,t10;

and #(2)(g0,a[0],b[0]);
xor #(2)(p0,a[0],b[0]);



xor(p1,a[1],b[1]);
and(g1,a[1],b[1]);


 xor(p2,a[2],b[2]);
and(g2,a[2],b[2]);


 xor(p3,a[3],b[3]);
and(g3,a[3],b[3]);

and(t1,p0,cin);
or(c1,t1,g0);
and(t2,p1,g0);
and(t3,p1,p0,cin);
or(c2,g1,t2,t3);
and(t4,p2,g1);
and(t5,p2,p1,g0);
and(t6,p2,p1,p0,cin);
or(c3,g2,t4,t5,t6);
and(t7,p3,g2);
and(t8,p3,p2,g1);
and(t9,p3,p2,p1,g0);
and(t10,p3,p2,p1,p0,cin);
or(cout,g3,t7,t8,t9,t10);

xor #(2)(sum[0], p0, cin);
xor #(2)(sum[1], p1, c1);
xor #(2)(sum[2], p2, c2);
xor #(2)(sum[3], p3, c3);


endmodule

