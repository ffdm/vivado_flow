# Basic Init Thing
set_property CFGBVS VCCO [current_design]
set_property CONFIG_VOLTAGE 3.3 [current_design]
set_property BITSTREAM.GENERAL.COMPRESS True [current_design]

# Clock
set_property -dict { IOSTANDARD LVDS_25 PACKAGE_PIN K4 } [get_ports {sys_clk_p}]
set_property -dict { IOSTANDARD LVDS_25 PACKAGE_PIN J4 } [get_ports {sys_clk_n}]

# Led
set_property -dict { IOSTANDARD LVCMOS33 PACKAGE_PIN N13 } [get_ports {led}]
