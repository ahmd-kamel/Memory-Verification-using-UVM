puts "Hello, World!"
puts $argc

set X 1
set Y 2
if {$X > $Y} then {puts incr($X)} else {puts {pow(2,$Y)}}