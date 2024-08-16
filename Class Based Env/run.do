vlog -f file.f
vsim -debugDB work.top
add wave -position end sim:/top/mem_intf/*
add wave -position end  sim:/top/memory_instance/mem_array
run -all

#vlog package.sv top.sv +cover
#vsim -batch top -coverage  
#run -all
#coverage report -codeAll -cvg -verbose