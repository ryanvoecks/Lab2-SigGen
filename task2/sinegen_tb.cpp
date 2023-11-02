#include "Vsinegen.h"
#include "verilated.h"
#include "verilated_vcd_c.h"
#include "vbuddy.cpp"

int main(int argc, char **argv, char **env) {
    int i;
    int clk;

    Verilated::commandArgs(argc, argv);
    // init top verilog instance
    Vsinegen *top = new Vsinegen;
    // init trace dump
    Verilated::traceEverOn(true);
    VerilatedVcdC *tfp = new VerilatedVcdC;
    top->trace (tfp, 99);
    tfp->open ("singen.vcd");

    // init Vbuddy
    if (!vbdOpen()) return (-1);
    vbdHeader("Lab 2: sinegen");

    // initialize simulation inputs
    top->clk = 1;
    top->rst = 0;
    top->en = 0;
    top->incr = 1;

    // run simulation for many clock cycles
    for (i = 0; i < 1000000; i++) {
        top->offset = vbdValue();

        // dump variables into VCD file and toggle clock
        for (clk = 0; clk < 2; clk++) {
            tfp->dump(2 * i + clk);
            top->clk = !top->clk;
            top->eval();
        }

        vbdPlot(int(top->dout1), 0, 255);
        vbdPlot(int(top->dout2), 0, 255);

        if (Verilated::gotFinish() || (vbdGetkey() == 'q'))
            exit(0);
    }
    vbdClose();
    tfp->close();
    exit(0);
}
