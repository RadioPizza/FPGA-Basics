# Clock signal
set_property PACKAGE_PIN W5 [get_ports CLK100MHZ]
set_property IOSTANDARD LVCMOS33 [get_ports CLK100MHZ]

# Reset button
set_property PACKAGE_PIN U18 [get_ports BTNC]
set_property IOSTANDARD LVCMOS33 [get_ports BTNC]

# Switches
set_property PACKAGE_PIN V15 [get_ports {SW[5]}]
set_property PACKAGE_PIN W15 [get_ports {SW[4]}]
set_property PACKAGE_PIN W17 [get_ports {SW[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {SW[*]}]

# 7-segment display anodes
set_property PACKAGE_PIN U2 [get_ports {AN[0]}]
set_property PACKAGE_PIN U4 [get_ports {AN[1]}]
set_property PACKAGE_PIN V4 [get_ports {AN[2]}]
set_property PACKAGE_PIN W4 [get_ports {AN[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {AN[*]}]

# 7-segment display cathodes
set_property PACKAGE_PIN W7 [get_ports {HEX[0]}]
set_property PACKAGE_PIN W6 [get_ports {HEX[1]}]
set_property PACKAGE_PIN U8 [get_ports {HEX[2]}]
set_property PACKAGE_PIN V8 [get_ports {HEX[3]}]
set_property PACKAGE_PIN U5 [get_ports {HEX[4]}]
set_property PACKAGE_PIN V5 [get_ports {HEX[5]}]
set_property PACKAGE_PIN U7 [get_ports {HEX[6]}]
set_property PACKAGE_PIN V7 [get_ports {HEX[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {HEX[*]}]