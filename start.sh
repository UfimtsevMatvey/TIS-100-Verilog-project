
#rem recreate a temp folder for all the simulation files
#rd /s /q sim
mkdir sim
cd sim

#rem compile verilog files for simulation
iverilog -g2012 -s testbench ../*.sv ../*.v

#rem run the simulation
vvp -l a.lst -n a.out -vcd

#rem show the simulation results in GTKwave
gtkwave dump.vcd

#rem return to the parent folder
cd ..
