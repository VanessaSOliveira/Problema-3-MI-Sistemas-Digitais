# TCL File Generated by Component Editor 18.1
# Mon Feb 11 09:13:45 BRST 2019
# DO NOT MODIFY


# 
# arbitro "arbitro" v1.0
#  2019.02.11.09:13:45
# 
# 

# 
# request TCL package from ACDS 16.1
# 
package require -exact qsys 16.1


# 
# module arbitro
# 
set_module_property DESCRIPTION ""
set_module_property NAME arbitro
set_module_property VERSION 1.0
set_module_property INTERNAL false
set_module_property OPAQUE_ADDRESS_MAP true
set_module_property AUTHOR ""
set_module_property DISPLAY_NAME arbitro
set_module_property INSTANTIATE_IN_SYSTEM_MODULE true
set_module_property EDITABLE true
set_module_property REPORT_TO_TALKBACK false
set_module_property ALLOW_GREYBOX_GENERATION false
set_module_property REPORT_HIERARCHY false


# 
# file sets
# 
add_fileset QUARTUS_SYNTH QUARTUS_SYNTH "" ""
set_fileset_property QUARTUS_SYNTH TOP_LEVEL arbitro
set_fileset_property QUARTUS_SYNTH ENABLE_RELATIVE_INCLUDE_PATHS false
set_fileset_property QUARTUS_SYNTH ENABLE_FILE_OVERWRITE_MODE false
add_fileset_file arbitro.v VERILOG PATH arbitro.v TOP_LEVEL_FILE


# 
# parameters
# 
add_parameter Start INTEGER 0
set_parameter_property Start DEFAULT_VALUE 0
set_parameter_property Start DISPLAY_NAME Start
set_parameter_property Start TYPE INTEGER
set_parameter_property Start UNITS None
set_parameter_property Start ALLOWED_RANGES -2147483648:2147483647
set_parameter_property Start HDL_PARAMETER true
add_parameter bit0 INTEGER 1
set_parameter_property bit0 DEFAULT_VALUE 1
set_parameter_property bit0 DISPLAY_NAME bit0
set_parameter_property bit0 TYPE INTEGER
set_parameter_property bit0 UNITS None
set_parameter_property bit0 ALLOWED_RANGES -2147483648:2147483647
set_parameter_property bit0 HDL_PARAMETER true
add_parameter bit1 INTEGER 2
set_parameter_property bit1 DEFAULT_VALUE 2
set_parameter_property bit1 DISPLAY_NAME bit1
set_parameter_property bit1 TYPE INTEGER
set_parameter_property bit1 UNITS None
set_parameter_property bit1 ALLOWED_RANGES -2147483648:2147483647
set_parameter_property bit1 HDL_PARAMETER true
add_parameter bit2 INTEGER 3
set_parameter_property bit2 DEFAULT_VALUE 3
set_parameter_property bit2 DISPLAY_NAME bit2
set_parameter_property bit2 TYPE INTEGER
set_parameter_property bit2 UNITS None
set_parameter_property bit2 ALLOWED_RANGES -2147483648:2147483647
set_parameter_property bit2 HDL_PARAMETER true
add_parameter bit3 INTEGER 4
set_parameter_property bit3 DEFAULT_VALUE 4
set_parameter_property bit3 DISPLAY_NAME bit3
set_parameter_property bit3 TYPE INTEGER
set_parameter_property bit3 UNITS None
set_parameter_property bit3 ALLOWED_RANGES -2147483648:2147483647
set_parameter_property bit3 HDL_PARAMETER true
add_parameter bit4 INTEGER 5
set_parameter_property bit4 DEFAULT_VALUE 5
set_parameter_property bit4 DISPLAY_NAME bit4
set_parameter_property bit4 TYPE INTEGER
set_parameter_property bit4 UNITS None
set_parameter_property bit4 ALLOWED_RANGES -2147483648:2147483647
set_parameter_property bit4 HDL_PARAMETER true
add_parameter bit5 INTEGER 6
set_parameter_property bit5 DEFAULT_VALUE 6
set_parameter_property bit5 DISPLAY_NAME bit5
set_parameter_property bit5 TYPE INTEGER
set_parameter_property bit5 UNITS None
set_parameter_property bit5 ALLOWED_RANGES -2147483648:2147483647
set_parameter_property bit5 HDL_PARAMETER true
add_parameter bit6 INTEGER 7
set_parameter_property bit6 DEFAULT_VALUE 7
set_parameter_property bit6 DISPLAY_NAME bit6
set_parameter_property bit6 TYPE INTEGER
set_parameter_property bit6 UNITS None
set_parameter_property bit6 ALLOWED_RANGES -2147483648:2147483647
set_parameter_property bit6 HDL_PARAMETER true
add_parameter bit7 INTEGER 8
set_parameter_property bit7 DEFAULT_VALUE 8
set_parameter_property bit7 DISPLAY_NAME bit7
set_parameter_property bit7 TYPE INTEGER
set_parameter_property bit7 UNITS None
set_parameter_property bit7 ALLOWED_RANGES -2147483648:2147483647
set_parameter_property bit7 HDL_PARAMETER true
add_parameter stop INTEGER 9
set_parameter_property stop DEFAULT_VALUE 9
set_parameter_property stop DISPLAY_NAME stop
set_parameter_property stop TYPE INTEGER
set_parameter_property stop UNITS None
set_parameter_property stop ALLOWED_RANGES -2147483648:2147483647
set_parameter_property stop HDL_PARAMETER true
add_parameter verificacaoAlarme INTEGER 10
set_parameter_property verificacaoAlarme DEFAULT_VALUE 10
set_parameter_property verificacaoAlarme DISPLAY_NAME verificacaoAlarme
set_parameter_property verificacaoAlarme TYPE INTEGER
set_parameter_property verificacaoAlarme UNITS None
set_parameter_property verificacaoAlarme ALLOWED_RANGES -2147483648:2147483647
set_parameter_property verificacaoAlarme HDL_PARAMETER true
add_parameter alarme1 INTEGER 11
set_parameter_property alarme1 DEFAULT_VALUE 11
set_parameter_property alarme1 DISPLAY_NAME alarme1
set_parameter_property alarme1 TYPE INTEGER
set_parameter_property alarme1 UNITS None
set_parameter_property alarme1 ALLOWED_RANGES -2147483648:2147483647
set_parameter_property alarme1 HDL_PARAMETER true
add_parameter checkTamanho INTEGER 0
set_parameter_property checkTamanho DEFAULT_VALUE 0
set_parameter_property checkTamanho DISPLAY_NAME checkTamanho
set_parameter_property checkTamanho TYPE INTEGER
set_parameter_property checkTamanho UNITS None
set_parameter_property checkTamanho ALLOWED_RANGES -2147483648:2147483647
set_parameter_property checkTamanho HDL_PARAMETER true
add_parameter checksum INTEGER 1
set_parameter_property checksum DEFAULT_VALUE 1
set_parameter_property checksum DISPLAY_NAME checksum
set_parameter_property checksum TYPE INTEGER
set_parameter_property checksum UNITS None
set_parameter_property checksum ALLOWED_RANGES -2147483648:2147483647
set_parameter_property checksum HDL_PARAMETER true
add_parameter enviarNIOS INTEGER 2
set_parameter_property enviarNIOS DEFAULT_VALUE 2
set_parameter_property enviarNIOS DISPLAY_NAME enviarNIOS
set_parameter_property enviarNIOS TYPE INTEGER
set_parameter_property enviarNIOS UNITS None
set_parameter_property enviarNIOS ALLOWED_RANGES -2147483648:2147483647
set_parameter_property enviarNIOS HDL_PARAMETER true
add_parameter limparRegs INTEGER 3
set_parameter_property limparRegs DEFAULT_VALUE 3
set_parameter_property limparRegs DISPLAY_NAME limparRegs
set_parameter_property limparRegs TYPE INTEGER
set_parameter_property limparRegs UNITS None
set_parameter_property limparRegs ALLOWED_RANGES -2147483648:2147483647
set_parameter_property limparRegs HDL_PARAMETER true
add_parameter verificarAlarme INTEGER 4
set_parameter_property verificarAlarme DEFAULT_VALUE 4
set_parameter_property verificarAlarme DISPLAY_NAME verificarAlarme
set_parameter_property verificarAlarme TYPE INTEGER
set_parameter_property verificarAlarme UNITS None
set_parameter_property verificarAlarme ALLOWED_RANGES -2147483648:2147483647
set_parameter_property verificarAlarme HDL_PARAMETER true
add_parameter alarme2 INTEGER 5
set_parameter_property alarme2 DEFAULT_VALUE 5
set_parameter_property alarme2 DISPLAY_NAME alarme2
set_parameter_property alarme2 TYPE INTEGER
set_parameter_property alarme2 UNITS None
set_parameter_property alarme2 ALLOWED_RANGES -2147483648:2147483647
set_parameter_property alarme2 HDL_PARAMETER true


# 
# display items
# 


# 
# connection point clock
# 
add_interface clock clock end
set_interface_property clock clockRate 0
set_interface_property clock ENABLED true
set_interface_property clock EXPORT_OF ""
set_interface_property clock PORT_NAME_MAP ""
set_interface_property clock CMSIS_SVD_VARIABLES ""
set_interface_property clock SVD_ADDRESS_GROUP ""

add_interface_port clock clk clk Input 1


# 
# connection point reset
# 
add_interface reset reset end
set_interface_property reset associatedClock clock
set_interface_property reset synchronousEdges DEASSERT
set_interface_property reset ENABLED true
set_interface_property reset EXPORT_OF ""
set_interface_property reset PORT_NAME_MAP ""
set_interface_property reset CMSIS_SVD_VARIABLES ""
set_interface_property reset SVD_ADDRESS_GROUP ""

add_interface_port reset reset reset Input 1


# 
# connection point nios_custom_instruction_slave
# 
add_interface nios_custom_instruction_slave nios_custom_instruction end
set_interface_property nios_custom_instruction_slave clockCycle 0
set_interface_property nios_custom_instruction_slave operands 2
set_interface_property nios_custom_instruction_slave ENABLED true
set_interface_property nios_custom_instruction_slave EXPORT_OF ""
set_interface_property nios_custom_instruction_slave PORT_NAME_MAP ""
set_interface_property nios_custom_instruction_slave CMSIS_SVD_VARIABLES ""
set_interface_property nios_custom_instruction_slave SVD_ADDRESS_GROUP ""

add_interface_port nios_custom_instruction_slave clk_en clk_en Input 1
add_interface_port nios_custom_instruction_slave start start Input 1
add_interface_port nios_custom_instruction_slave dataa dataa Input 32
add_interface_port nios_custom_instruction_slave result result Output 32
add_interface_port nios_custom_instruction_slave done done Output 1


# 
# connection point conduit_end
# 
add_interface conduit_end conduit end
set_interface_property conduit_end associatedClock clock
set_interface_property conduit_end associatedReset reset
set_interface_property conduit_end ENABLED true
set_interface_property conduit_end EXPORT_OF ""
set_interface_property conduit_end PORT_NAME_MAP ""
set_interface_property conduit_end CMSIS_SVD_VARIABLES ""
set_interface_property conduit_end SVD_ADDRESS_GROUP ""

add_interface_port conduit_end rx rx Input 1
add_interface_port conduit_end tx tx Output 1
