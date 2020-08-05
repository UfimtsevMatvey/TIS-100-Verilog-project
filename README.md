# TIS-100-Verilog-project
This Verilog-model processor from  game "TIS-100".
ISA data comands:
  {Command type xxxx}{sourse xxx}{destination xxx}{immediate - 8bit value}
  
Commands type:
      mov: 0000 (move data)
      swp: 0001 (swap acc <-> bak)
      sub: 0010
      add: 0011
      neg: 1001 (acc -> -acc)
  
Control instruction:
  {Command type xxxx}{bit sourse for jmp acc or imm}{not use xxxxx}{immediate - 8bit value}
  if sourse = acc then bit sourse = "1"
  if sourse = imm then bit sourse = "0"
   
  Command type:
      jmp: 0100 (uncondition jump)
      jez: 0101 (if acc = 0)
      jnz: 0110 (if acc != 0)
      jgz: 0111 (if acc > 0)
      jlz: 1000 (if acc < 0)
