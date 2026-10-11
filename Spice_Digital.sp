****************************
** Digital.mod
** A model description for digital devices
** (2026) Sigurd Henriksen
****************************

****************************
** Open Drain Comparator
****************************
.subckt compod inp inn outp outn lgnd params: rin=1G cin=1p cout=1p ron=10 roff=100G trise=1n tfall=1n td=1p resr=10m

*Input nodes
rip inp lgnd {rin}
ripe inp ripesr {resr}
cip ripesr lgnd {cin}

rin inn lgnd {rin}
rine inn rinesr {resr}
cin rinesr lgnd {cin}

*Behavioural comparator
B1 compval 0 v='v(inp)>v(inn)? 1 : 0'

* Output Delay and Slew Rate
A1 compval compvald dctrl delay1
R2 dctrl 0 1G
A2 compvald compvalslew slew1
A3 compvalslew %gd(outn lgnd) switch1
B2 compvalslewn 0 v='1-v(compvalslew)'
A4 compvalslewn %gd(outp lgnd) switch1

*Output capacitance
rope outp ropesr {resr}
cop ropesr lgnd {cout}
rone outn ronesr {resr}
con ronesr lgnd {cout}

* Model Statements
.model delay1 delay(delay={td})
.model slew1 slew(rise_slope={1/trise} fall_slope={1/tfall})
.model switch1 aswitch(r_off={roff} r_on={ron} log=TRUE limit=TRUE)
.ends

****************************
** Push-Pull Drain Comparator
****************************
.subckt comppp inp inn outp outn lgnd params: rin=1G cin=1p cout=1p ron=30 roff=30 vhigh=1 vlow=0 trise=1n tfall=1n td=1p resr=10m

*Input nodes
rip inp lgnd {rin}
ripe inp ripesr {resr}
cip ripesr lgnd {cin}

rin inn lgnd {rin}
rine inn rinesr {resr} 
cin rinesr lgnd {cin}

* Behavioural evaluation
B1 compval 0 v='v(inp)>v(inn)? 1 : 0'

* Output Delay and Slew Rate
A1 compval compvald dctrl delay1
R2 dctrl 0 1G
A2 compvald compvalslew slew1

*Output Drive
B2 drivep lgnd v='{vlow}+v(compvalslew)*({vhigh}-{vlow})'
A3 compvalslew %gd(drivep outp) switch1
B3 driven lgnd v='{vhigh}+v(compvalslew)*({vlow}-{vhigh})'
A4 compvalslew %gd(driven outn) switch2

*Output capacitance
rope outp ropesr {resr}
cop ropesr lgnd {cout}
rone outn ronesr {resr}
con ronesr lgnd {cout}

* Model Statements
.model delay1 delay(delay={td})
.model slew1 slew(rise_slope={1/trise} fall_slope={1/tfall})
.model switch1 aswitch(r_off={roff} r_on={ron} log=TRUE limit=TRUE)
.model switch2 aswitch(r_off={ron} r_on={roff} log=TRUE limit=TRUE)
.ends


****************************
** Digital Buffer
****************************
.subckt buffer in outp outn lgnd params: rin=1G cin=1p cout=1p ron=30 roff=30 vhigh=1 vlow=0 trise=1n tfall=1n td=1p resr=10m vhys=0.01

*Input nodes
rip in lgnd {rin}
ripe in riesr {resr}
cip riesr lgnd {cin}

* Behavioural evaluation
B1 bufval 0 v='(v(in)-v(lgnd)+{vhys}*(v(bufval)-0.5))>(({vhigh}+{vlow})/2)? 1 : 0'

* Output Delay and Slew Rate
A1 bufval compvald dctrl delay1
R2 dctrl 0 1G
A2 compvald compvalslew slew1

*Output Drive
B2 drivep lgnd v='{vlow}+v(compvalslew)*({vhigh}-{vlow})'
A3 compvalslew %gd(drivep outp) switch1
B3 driven lgnd v='{vhigh}+v(compvalslew)*({vlow}-{vhigh})'
A4 compvalslew %gd(driven outn) switch1

*Output capacitance
rope outp ropesr {resr}
cop ropesr lgnd {cout}
rone outn ronesr {resr}
con ronesr lgnd {cout}

.model delay1 delay(delay={td})
.model slew1 slew(rise_slope={1/trise} fall_slope={1/tfall})
.model switch1 aswitch(r_off={roff} r_on={ron} log=TRUE limit=TRUE)
.ends

**********************************************
** AND gate (2-input) using behavioral sources
**********************************************
.subckt and2 in1 in2 outp outn lgnd params: rin=1G cin=1p cout=1p ron=30 roff=30 vhigh=1 vlow=0 trise=1n tfall=1n td=1p resr=10m vhys=0.01

*Input nodes
rin1 in1 lgnd {rin}
rin1e in1 rin1esr {resr}
cin1 rin1esr lgnd {cin}

rin2 in2 lgnd {rin}
rin2e in2 rin2esr {resr} 
cin2 rin2esr lgnd {cin}

* Behavioural evaluation
B1 bufval1 0 v='(v(in1)-v(lgnd)+{vhys}*(v(bufval1)-0.5))>(({vhigh}+{vlow})/2)? 1 : 0'
B2 bufval2 0 v='(v(in2)-v(lgnd)+{vhys}*(v(bufval2)-0.5))>(({vhigh}+{vlow})/2)? 1 : 0'
B3 andval 0 v='v(bufval1) * v(bufval2)'

* Output Delay and Slew Rate
A1 andval andvald dctrl delay1
R2 dctrl 0 1G
A2 andvald andvalslew slew1

*Output Drive
B4 drivep lgnd v='{vlow}+v(andvalslew)*({vhigh}-{vlow})'
A3 andvalslew %gd(drivep outp) switch1
B5 driven lgnd v='{vhigh}+v(andvalslew)*({vlow}-{vhigh})'
A4 andvalslew %gd(driven outn) switch2

*Output capacitance
rope outp ropesr {resr}
cop ropesr lgnd {cout}
rone outn ronesr {resr}
con ronesr lgnd {cout}

* Model Statements
.model delay1 delay(delay={td})
.model slew1 slew(rise_slope={1/trise} fall_slope={1/tfall})
.model switch1 aswitch(r_off={roff} r_on={ron} log=TRUE limit=TRUE)
.model switch2 aswitch(r_off={ron} r_on={roff} log=TRUE limit=TRUE)
.ends

******************************************************
** AND gate (2-input) using XSPICE adc,dac & and gate
******************************************************

.subckt and2_2 in1 in2 outp outn lgnd params: rin=1G cin=1p cout=1p ron=30 roff=30 vhigh=1 vlow=0 trise=1e-12 tfall=1e-12 td=1p resr=10m vhys=0.01

*Input nodes
rin1 in1 lgnd {rin}
rin1e in1 rin1esr {resr}
cin1 rin1esr lgnd {cin}

rin2 in2 lgnd {rin}
rin2e in2 rin2esr {resr} 
cin2 rin2esr lgnd {cin}

aadc %vd[in1 lgnd in2 lgnd] [din1 din2] ladc
aand [din1 din2] dout andg
adac [dout] [andvalslew] ldac

*Output Drive
B4 drivep lgnd v='{vlow}+v(andvalslew)*({vhigh}-{vlow})'
A3 andvalslew %gd(drivep outp) switch1
B5 driven lgnd v='{vhigh}+v(andvalslew)*({vlow}-{vhigh})'
A4 andvalslew %gd(driven outn) switch2

*Output capacitance
rope outp ropesr {resr}
cop ropesr lgnd {cout}
rone outn ronesr {resr}
con ronesr lgnd {cout}

.model ladc adc_bridge(in_low={(vhigh-vlow+vhys)/2} in_high={(vhigh-vlow-vhys)/2} rise_delay = {td} fall_delay = {td})
.model ldac dac_bridge(out_low={vlow} out_high={vhigh} t_rise = {trise} t_fall = {tfall})
.model andg d_and((rise_delay = 1e-12 fall_delay = 1e-12 input_load = 0)
.model switch1 aswitch(r_off={roff} r_on={ron} log=TRUE limit=TRUE)
.model switch2 aswitch(r_off={ron} r_on={roff} log=TRUE limit=TRUE)

.ends and2_2


****************************
** OR gate (2-input)
****************************
.subckt or2 in1 in2 outp outn lgnd params: rin=1G cin=1p cout=1p ron=30 roff=30 vhigh=1 vlow=0 trise=1n tfall=1n td=1p resr=10m vhys=0.01

*Input nodes
rin1 in1 lgnd {rin}
rin1e in1 rin1esr {resr}
cin1 rin1esr lgnd {cin}

rin2 in2 lgnd {rin}
rin2e in2 rin2esr {resr} 
cin2 rin2esr lgnd {cin}

* Behavioural evaluation
B1 bufval1 0 v='(v(in1)-v(lgnd)+{vhys}*(v(determvalds)-0.5))>(({vhigh}+{vlow})/2)? 1 : 0'
B2 bufval2 0 v='(v(in2)-v(lgnd)+{vhys}*(v(determvalds)-0.5))>(({vhigh}+{vlow})/2)? 1 : 0'
B3 determval 0 v='max(v(bufval1), v(bufval2))'

* Output Delay and Slew Rate
A1 determval determvald dctrl delay1
R2 dctrl 0 1G
A2 determvald determvalds slew1

*Output Drive
B4 drivep lgnd v='{vlow}+v(determvalds)*({vhigh}-{vlow})'
A3 determvalds %gd(drivep outp) switch1
B5 driven lgnd v='{vhigh}+v(determvalds)*({vlow}-{vhigh})'
A4 determvalds %gd(driven outn) switch2

*Output capacitance
rope outp ropesr {resr}
cop ropesr lgnd {cout}
rone outn ronesr {resr}
con ronesr lgnd {cout}

* Model Statements
.model delay1 delay(delay={td})
.model slew1 slew(rise_slope={1/trise} fall_slope={1/tfall})
.model switch1 aswitch(r_off={roff} r_on={ron} log=TRUE limit=TRUE)
.model switch2 aswitch(r_off={ron} r_on={roff} log=TRUE limit=TRUE)
.ends


******************************************************
** XOR gate (2-input) using XSPICE adc,dac & xor gate
******************************************************

.subckt xor2 in1 in2 outp outn lgnd params: rin=1G cin=1p cout=1p ron=30 roff=30 vhigh=1 vlow=0 trise=1e-12 tfall=1e-12 td=1e-12 resr=10m vhys=0.01

*Input nodes
rin1 in1 lgnd {rin}
rin1e in1 rin1esr {resr}
cin1 rin1esr lgnd {cin}

rin2 in2 lgnd {rin}
rin2e in2 rin2esr {resr} 
cin2 rin2esr lgnd {cin}

aadc %vd[in1 lgnd in2 lgnd] [din1 din2] ladc
axor [din1 din2] dout xorg
adac [dout] [andvalslew] ldac

*Output Drive
B4 drivep lgnd v='{vlow}+v(andvalslew)*({vhigh}-{vlow})'
A3 andvalslew %gd(drivep outp) switch1
B5 driven lgnd v='{vhigh}+v(andvalslew)*({vlow}-{vhigh})'
A4 andvalslew %gd(driven outn) switch2

*Output capacitance
rope outp ropesr {resr}
cop ropesr lgnd {cout}
rone outn ronesr {resr}
con ronesr lgnd {cout}

.model ladc adc_bridge(in_low={(vhigh-vlow+vhys)/2} in_high={(vhigh-vlow-vhys)/2} rise_delay = {td} fall_delay = {td})
.model ldac dac_bridge(out_low={vlow} out_high={vhigh} t_rise = {trise} t_fall = {tfall})
.model xorg d_xor((rise_delay = 1e-12 fall_delay = 1e-12 input_load = 0)
.model switch1 aswitch(r_off={roff} r_on={ron} log=TRUE limit=TRUE)
.model switch2 aswitch(r_off={ron} r_on={roff} log=TRUE limit=TRUE)

.ends and2_2


****************************
** D Flip Flop 
****************************
.subckt dff d clk sset rset outp outn lgnd params: rin=1G cin=1p cout=1p ron=30 roff=30 vhigh=1 vlow=0 trise=1e-12 tfall=1e-12 td=1e-12 resr=10m vhys=0.01 tdck=1e-12 tds=1e-12 tdr=1e-12

*Input nodes
rid d lgnd {rin}
ride d ridesr {resr}
cid ridesr lgnd {cin}

riclk clk lgnd {rin}
riclke clk riclkesr {resr} 
ciclk riclkesr lgnd {cin}

ris sset lgnd {rin}
rise d risesr {resr}
cis risesr lgnd {cin}

rirs rset lgnd {rin}
rirse rset rirsesr {resr} 
cirs rirsesr lgnd {cin}

* Behavioural evaluation
aadc %vd[d lgnd clk lgnd sset lgnd rset lgnd ] [dd dclk dset drset] ladc

A5 dd dclk dset drset dovalp dovaln dflop
A10 [dovalp dovaln] [determvalds determvaln] ldac


* Output Delay and Slew Rate
*A1 determval determvald dctrl delay1
*R2 dctrl 0 1G
*A2 determvald determvalds slew1

*Output Drive
B4 drivep lgnd v='{vlow}+v(determvalds)*({vhigh}-{vlow})'
A3 determvalds %gd(drivep outp) switch1
B5 driven lgnd v='{vhigh}+v(determvalds)*({vlow}-{vhigh})'
A4 determvalds %gd(driven outn) switch2

*Output capacitance
rope outp ropesr {resr}
cop ropesr lgnd {cout}
rone outn ronesr {resr}
con ronesr lgnd {cout}

* Model Statements
.model delay1 delay(delay={td})
.model dflop d_dff(clk_delay={tdck} set_delay={tds} reset_delay={tdr} rise_delay = 1e-12 fall_delay = 1e-12)
.model slew1 slew(rise_slope={1/trise} fall_slope={1/tfall})
.model switch1 aswitch(r_off={roff} r_on={ron} log=TRUE limit=TRUE)
.model switch2 aswitch(r_off={ron} r_on={roff} log=TRUE limit=TRUE)
.model ladc adc_bridge(in_low={(vhigh-vlow+vhys)/2} in_high={(vhigh-vlow-vhys)/2} rise_delay = {td} fall_delay = {td})
.model ldac dac_bridge(out_low={vlow} out_high={vhigh} t_rise = {trise} t_fall = {tfall})
.model pulld d_pulldown()
.ends

****************************
** Mystery Flip Flop 
****************************
.subckt mff clk sset rset outp outn lgnd params: rin=1G cin=1p cout=1p ron=30 roff=30 vhigh=1 vlow=0 trise=1n tfall=1n td=1p resr=10m vhys=0.01 tdck=1e-12 tds=1e-12 tdr=1e-12

*Input nodes

riclk clk lgnd {rin}
riclke clk riclkesr {resr} 
ciclk riclkesr lgnd {cin}

ris sset lgnd {rin}
rise sset risesr {resr}
cis risesr lgnd {cin}

rirs rset lgnd {rin}
rirse rset rirsesr {resr} 
cirs rirsesr lgnd {cin}

* Behavioural evaluation
VR1 vr 0 dc 0 trrandom (2 10m 0 1) ; Gaussian with mean 0
aadc %vd[d lgnd clk lgnd sset lgnd rset lgnd ] [dset drset den] ladc

*B1 bufval1 0 v='(v(d)-v(lgnd)+{vhys}*(v(determvalds)-0.5))>(({vhigh}+{vlow})/2)? 1 : 0'
*B2 bufval2 0 v='(v(clk)-v(lgnd)+{vhys}*(v(determvalds)-0.5))>(({vhigh}+{vlow})/2)? 1 : 0'
*B6 bufval3 0 v='(v(sset)-v(lgnd)+{vhys}*(v(determvalds)-0.5))>(({vhigh}+{vlow})/2)? 1 : 0'
*B7 bufval4 0 v='(v(rset)-v(lgnd)+{vhys}*(v(determvalds)-0.5))>(({vhigh}+{vlow})/2)? 1 : 0'
*A6 [bufval1] [dval1] adcbr
*A7 [bufval2] [dval2] adcbr
*A8 [bufval3] [dval3] adcbr
*A9 [bufval4] [dval4] adcbr

A5 dval1 dval2 dval3 dval4 dovalp determvaln dflop
R1 determvaln 0 1G

A10 [dovalp] [determval] dacbr

* Output Delay and Slew Rate
A1 determval determvald dctrl delay1
R2 dctrl 0 1G
A2 determvald determvalds slew1

*Output Drive
B4 drivep lgnd v='{vlow}+v(determvalds)*({vhigh}-{vlow})'
A3 determvalds %gd(drivep outp) switch1
B5 driven lgnd v='{vhigh}+v(determvalds)*({vlow}-{vhigh})'
A4 determvalds %gd(driven outn) switch2

*Output capacitance
rope outp ropesr {resr}
cop ropesr lgnd {cout}
rone outn ronesr {resr}
con ronesr lgnd {cout}

* Model Statements
.model delay1 delay(delay={td})
.model dflop d_dff(clk_delay={tdck} set_delay={tds} reset_delay={tdr} rise_delay = 1e-12 fall_delay = 1e-12)
.model slew1 slew(rise_slope={1/trise} fall_slope={1/tfall})
.model switch1 aswitch(r_off={roff} r_on={ron} log=TRUE limit=TRUE)
.model switch2 aswitch(r_off={ron} r_on={roff} log=TRUE limit=TRUE)
.model ladc adc_bridge(in_low={(vhigh-vlow+vhys)/2} in_high={(vhigh-vlow-vhys)/2} rise_delay = {td} fall_delay = {td})
.model ldac dac_bridge(out_low={vlow} out_high={vhigh} t_rise = {trise} t_fall = {tfall})
.ends

****************************
** SR Flip Flop 
****************************
.subckt srff set rset en outp outn lgnd params: rin=1G cin=1p cout=1p ron=30 roff=30 vhigh=1 vlow=0 trise=1n tfall=1n td=1p resr=10m vhys=0.01 tden=1e-12 tds=1e-12 tdr=1e-12

*Input nodes
rie en lgnd {rin}
riee en rieesr {resr}
cie rieesr lgnd {cin}

ris set lgnd {rin}
rise d risesr {resr}
cis risesr lgnd {cin}

rirs rset lgnd {rin}
rirse rset rirsesr {resr} 
cirs rirsesr lgnd {cin}

* Behavioural evaluation
apd asr pulld
aadc %vd[set lgnd rset lgnd en lgnd] [dset drset den] ladc
asrf dset drset den asr asr dout doutn srflop
adac [dout] [determvalds] ldac

*Output Drive
B4 drivep lgnd v='{vlow}+v(determvalds)*({vhigh}-{vlow})'
A3 determvalds %gd(drivep outp) switch1
B5 driven lgnd v='{vhigh}+v(determvalds)*({vlow}-{vhigh})'
A4 determvalds %gd(driven outn) switch2

*Output capacitance
rope outp ropesr {resr}
cop ropesr lgnd {cout}
rone outn ronesr {resr}
con ronesr lgnd {cout}

* Model Statements
.model ladc adc_bridge(in_low={(vhigh-vlow+vhys)/2} in_high={(vhigh-vlow-vhys)/2} rise_delay = {td} fall_delay = {td})
.model ldac dac_bridge(out_low={vlow} out_high={vhigh} t_rise = {trise} t_fall = {tfall})
.model srflop d_srlatch(sr_delay=1p enable_delay=1p set_delay=1p reset_delay=1p  rise_delay = 1e-12 fall_delay = 1e-12)
.model switch1 aswitch(r_off={roff} r_on={ron} log=TRUE limit=TRUE)
.model switch2 aswitch(r_off={ron} r_on={roff} log=TRUE limit=TRUE)
.model pulld d_pulldown()

.ends

****************************
** Multiplexer  
****************************
.subckt mux2 in1 in2 sel outp outn lgnd params: rin=1G cin=1p cout=1p ron=30 roff=30 vhigh=1 vlow=0 trise=1n tfall=1n td=1p resr=10m vhys=0.01 

*Input nodes
rie en lgnd {rin}
riee en rieesr {resr}
cie rieesr lgnd {cin}

ris set lgnd {rin}
rise d risesr {resr}
cis risesr lgnd {cin}

rirs rset lgnd {rin}
rirse rset rirsesr {resr} 
cirs rirsesr lgnd {cin}

* Behavioural evaluation
B2 bufval2 0 v='(v(en)-v(lgnd)+{vhys}*(v(bufval2)-0.5))>(({vhigh}+{vlow})/2)? 1 : 0'
B6 bufval3 0 v='(v(set)-v(lgnd)+{vhys}*(v(bufval3)-0.5))>(({vhigh}+{vlow})/2)? 1 : 0'
B7 bufval4 0 v='(v(rset)-v(lgnd)+{vhys}*(v(bufval4)-0.5))>(({vhigh}+{vlow})/2)? 1 : 0'
B3 determval 0 v='(v(bufval4)>0.5)? v(bufval2):v(bufval3)'

*R1 determvaln 0 1G

* Output Delay and Slew Rate
A1 determval determvald dctrl delay1
R2 dctrl 0 1G
A2 determvald determvalds slew1

*Output Drive
B4 drivep lgnd v='{vlow}+v(determvalds)*({vhigh}-{vlow})'
A3 determvalds %gd(drivep outp) switch1
B5 driven lgnd v='{vhigh}+v(determvalds)*({vlow}-{vhigh})'
A4 determvalds %gd(driven outn) switch2

*Output capacitance
rope outp ropesr {resr}
cop ropesr lgnd {cout}
rone outn ronesr {resr}
con ronesr lgnd {cout}

* Model Statements
.model delay1 delay(delay={td})
.model slew1 slew(rise_slope={1/trise} fall_slope={1/tfall})
.model switch1 aswitch(r_off={roff} r_on={ron} log=TRUE limit=TRUE)
.model switch2 aswitch(r_off={ron} r_on={roff} log=TRUE limit=TRUE)
.ends
