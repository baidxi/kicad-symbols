** XSPICE models for KiCad Simulation_XSPICE library **

.subckt D_nand13 in1 in2 in3 in4 in5 in6 in7 in8 in9 in10 in111 in12 in13 out params: rd=0.5e-9 fd=0.3e-9
anand8 [in1 in2 in3 in4 in5 in6 in7 in8 in9 in10 in111 in12 in13] out nand1
.model nand1 d_nand(rise_delay = {rd} fall_delay = {fd}
+ input_load = 0.5e-12)
.ends

.subckt D_nand8 in1 in2 in3 in4 in5 in6 in7 in8 out params: rd=0.5e-9 fd=0.3e-9
anand8 [in1 in2 in3 in4 in5 in6 in7 in8] out nand1
.model nand1 d_nand(rise_delay = {rd} fall_delay = {fd}
+ input_load = 0.5e-12)
.ends

.subckt D_nand4 in1 in2 in3 in4 out params: rd=0.5e-9 fd=0.3e-9
anand4 [in1 in2 in3 in4] out nand1
.model nand1 d_nand(rise_delay = {rd} fall_delay = {fd}
+ input_load = 0.5e-12)
.ends

.subckt D_nand3 in1 in2 in3 out params: rd=0.5e-9 fd=0.3e-9
anand3 [in1 in2 in3] out nand1
.model nand1 d_nand(rise_delay = {rd} fall_delay = {fd}
+ input_load = 0.5e-12)
.ends

.subckt D_nand2 in1 in2 out params: rd = 0.5e-9 fd = 0.3e-9
anand2 [in1 in2] out nand1
.model nand1 d_nand(rise_delay = {rd} fall_delay = {fd}
+ input_load = 0.5e-12)
.ends

.subckt D_DFF1 reset in clk set out nout params: clkd=10e-9
+ setd=2.0e-9 rsetd=2e-9 rd=10e-9 fd=10e-9 ic=0
adff in clk ~set ~reset out nout flop1
.model flop1 d_dff (clk_delay = {clkd} set_delay = {setd}
+ reset_delay = {rsetd} ic = {ic} rise_delay = {rd}
+ fall_delay = {fd})
.ends

.subckt D_buffer in out params: rd=0.5e-9 fd=0.3e-9
abuffer in out buff1
.model buff1 d_buffer(rise_delay = {rd} fall_delay = {fd}
+ input_load = 0.5e-12)
.ends

.subckt D_inv in out params: rd=0.5e-9 fd=0.3e-9
ainv in out inv1
.model inv1 d_inverter(rise_delay = {rd} fall_delay = {fd}
+ input_load = 0.5e-12)
.ends

.subckt D_nor2 in1 in2 out params: rd = 0.5e-9 fd = 0.3e-9
anor2 [in1 in2] out nor1
.model nor1 d_nor(rise_delay = {rd} fall_delay = {fd}
+ input_load = 0.5e-12)
.ends

.subckt D_nor3 in1 in2 in3 out params: rd = 0.5e-9 fd = 0.3e-9
anor2 [in1 in2 in3] out nor1
.model nor1 d_nor(rise_delay = {rd} fall_delay = {fd}
+ input_load = 0.5e-12)
.ends

.subckt D_JKFFSR j k clk set reset out nout params: clkd=13e-9
+ setd=25.0e-9 rsetd=27e-9 rd=10e-9 fd=3e-9 ic=2
ajkffsr j k clk set reset out nout flop2
.model flop2 d_jkff(clk_delay = {clkd} set_delay = {setd}
+ reset_delay = {rsetd} ic = {ic} rise_delay = {rd}
+ fall_delay = {fd})
.ends

.subckt D_and2 in1 in2 out params: rd = 0.5e-9 fd = 0.3e-9
aand2 [in1 in2] out and1
.model and1 d_and(rise_delay = {rd} fall_delay = {fd}
+ input_load = 0.5e-12)
.ends

.subckt D_xor2 in1 in2 out params: rd = 0.5e-9 fd = 0.3e-9
axor2 [in1 in2] out xor1
.model xor1 d_xor(rise_delay = {rd} fall_delay = {fd}
+ input_load = 0.5e-12)
.ends

.subckt D_xnor2 in1 in2 out params: rd = 0.5e-9 fd = 0.3e-9
axnor2 [in1 in2] out xnor1
.model xnor1 d_xnor(rise_delay = {rd} fall_delay = {fd}
+ input_load = 0.5e-12)
.ends

.subckt D_tri in en out params: del=0.5e-9
atri in en out tri1
.model tri1 d_tristate(delay = {del} input_load = 0.5e-12
+ enable_load = 0.5e-12)
.ends

.subckt D_or2 in1 in2 out params: rd = 0.5e-9 fd = 0.3e-9
axor2 [in1 in2] out or1
.model or1 d_or(rise_delay = {rd} fall_delay = {fd}
+ input_load = 0.5e-12)
.ends

.subckt D_SRFF  s r clk as ar out nout params: clkd=13e-9
+ setd=25.0e-9 rsetd=27e-9 rd=10e-9 fd=3e-9 ic=2
asrff s r clk as ar out nout rsflop1
.model rsflop1 d_srff(clk_delay = {clkd} set_delay = {setd}
+ reset_delay = {rsetd} ic = {ic} rise_delay = {rd}
+ fall_delay = {fd})
.ends

.subckt D_DLATCH d en s r out nout params: dd=13e-9
+ end=22.0e-9 setd=25e-9 rsetd=27e-9 rd=10e-9 fd=3e-9 ic=2
adlatch d en s r out nout latch1
.model latch1 d_dlatch(data_delay = {dd} enable_delay = {end}
+ set_delay = {setd}
+ reset_delay = {rsetd} ic = {ic}
+ rise_delay = {rd} fall_delay = {fd})
.ends

.subckt D_DIVIDE in out params: n=5 hc=3 ico=4 rd=10e-9 fd=3e-9
adivide in out divider
.model divider d_fdiv(div_factor = 'n' high_cycles = 'hc'
+ i_count = 'ico' rise_delay = 'rd' fall_delay = 'fd')
.ends

.subckt H_VCO cntl+ cntl- out
+ params: c1=0 c2=1 f1=1e3 f2=2e3 dc=0.4 ip=180 rd=10e-9  fd=8e-9
avco %vd(cntl+ cntl-) out var_clock
.model var_clock d_osc(cntl_array = ['c1-1' 'c1' 'c2' 'c2+1']
+ freq_array = ['f1' 'f1' 'f2' 'f2']
+ duty_cycle = 'dc' init_phase = 'ip'
+ rise_delay = 'rd' fall_delay = 'fd')
.ends

.subckt H_PWM cntl+ cntl- out
+ params: c1=0.01 c2=0.99 dc1=0.01 dc2=0.99 freq = 5k ip=90 rd=10e-9  fd=8e-9
apwm %vd(cntl+ cntl-) out pwm_osc
.model pwm_osc d_pwm(cntl_array = ['c1-1' 'c1' 'c2' 'c2+1']
+ dc_array = ['dc1' 'dc1' 'dc2' 'dc2']
+ frequency = 'freq' init_phase = 'ip'
+ rise_delay = 'rd' fall_delay = 'fd')
.ends

.subckt H_DA din hi lo params: ohi=1 olo=0 tr=20e-9 tf=20e-9
.param ud='(ohi-olo)/2'
abridge1 [din] [%vd(hi lo)] dac1
.model dac1 dac_bridge(out_low = 'olo' out_high = 'ohi' out_undef = 'ud' )
+ input_load = 5.0e-12 t_rise = 'tr'
+ t_fall = 'tf')
.ends

.subckt H_AD in+ in- dout params: ihi=0.5 ilo=0.5 rd=2e-9 fd=2e-9
abridge2 [%vd(in+ in-)] [dout] adc_buff
.model adc_buff adc_bridge(in_low = 'ilo' in_high = 'ihi'
+ rise_delay = 'rd' fall_delay = 'fd')
.ends

.subckt A_sigain in out params: gain=5
asigain in out amp
.model amp gain(in_offset=0 gain='gain' out_offset=0)
.ends

.subckt A_diffgain in+ in- out params: gain=5
adgain %vd(in+ in-) out amp
.model amp gain(in_offset=0 gain='gain' out_offset=0)
.ends

.subckt A_int in+ in- out params: gain=1 out_ic=0.0
aint %vd(in+ in-) out time_count
.model time_count int(in_offset=0 gain='gain'
+ out_lower_limit=-1e12 out_upper_limit=1e12
+ limit_range=1e-9 out_ic='out_ic')
.ends

.subckt A_summer in1 in2 out params: gain=1
asum [in1 in2] out sum1
.model sum1 summer(in_offset=[0 0] in_gain=[1.0 1.0]
+ out_gain='gain' out_offset=0)
.ends

.subckt A_mult in1 in2 out params: gain=1
amult [in1 in2] out sigmult
.model sigmult mult(in_offset=[0 0]
+ in_gain=[1 1] out_gain='gain' out_offset=0)
.ends

.subckt A_schmitt in1 in2 out params: hyst=0.6 thresh=1.5 outl=0.5 outh=3.0
aschm in out schmitt1
.model schmitt1 hyst(in_low='thresh' in_high='thresh*1.0001' hyst='hyst'
+ out_lower_limit='outl' out_upper_limit='outh'
+ input_domain=0.01 fraction=TRUE)
.ends

.subckt A_VCO_SIN cntl+ cntl- out+ out- params: freq_min=1000 freq_max=2000 outlo=-1 outhi=1
asine %vd(cntl+ cntl-) %vd(out+ out-) in_sine
.model in_sine sine(cntl_array=[-1 0 1 2]
+ freq_array=[{freq_min} {freq_min} {freq_max} {freq_max}]
+ out_low={outlo} out_high={outhi})
.ends

.subckt A_VCO_TRI cntl+ cntl- out+ out- params: freq_min=1000 freq_max=2000 outlo=-1 outhi=1 dc=0.5
asine %vd(cntl+ cntl-) %vd(out+ out-) in_tri
.model in_tri triangle(cntl_array=[-1 0 1 2]
+ freq_array=[{freq_min} {freq_min} {freq_max} {freq_max}]
+ out_low={outlo} out_high={outhi} duty_cycle={dc})
.ends

.subckt A_VCO_SQU cntl+ cntl- out+ out-
+ params: freq_min=1000 freq_max=2000 outlo=-1 outhi=1 dc=0.5 tr=1u tf=1u
asine %vd(cntl+ cntl-) %vd(out+ out-) in_square
.model in_square square(cntl_array=[-1 0 1 2]
+ freq_array=[{freq_min} {freq_min} {freq_max} {freq_max}]
+ out_low={outlo} out_high={outhi} duty_cycle={dc}
+ rise_time={tr} fall_time={tf})
.ends

* code model 'potentiometer'
.subckt A_POT rup wp rlo params: wpos=0.35 Rtot=1k log=FALSE log_multiplier=1
Apot rlo wp rup potmod
.model potmod potentiometer(position={wpos} r={Rtot} log={log} log_multiplier={log_multiplier})
.ends
