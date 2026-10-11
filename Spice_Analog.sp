****************************
** Analog.mod
** A model description for digital devices
** (2026) Sigurd Henriksen
****************************


*Pot

**********************************************
** Switch1 Hyperbolic transistion
**********************************************
.subckt asw1 in1 in2 out1 out2 params: r1=10MEG r2=10 vt=1.5 k=5
r1 out1 out2 r=(({r2}-{r1})/2)*tanh({k}*(v(in1)-v(in2)-{vt}))+(({r1}+{r2})/2)
.ends




**********************************************
*Diode (Likely does not need a subcircuit, since already analog.)
************************************************ 
.subckt adiode anode cathode params: roff=10MEG ron=1 vf=0.7 vr=100 kt=4
a1 anode cathode ad1
.model ad1 sidiode(Roff={roff} Ron={ron} Rrev=2 Vfwd={vf}
+ Vrev={vr} Revepsilon=0.2 Epsilon=0.2)
.ends

**********************************************
*Diode (Likely does not need a subcircuit, since already analog.)
************************************************ 
.subckt adiode2 anode cathode params: roff=10MEG ron=1 vf=0.7 vr=100 kt=4
a1 anode cathode ad1
.model ad1 sidiode(Roff={roff} Ron={ron} Rrev=2 Vfwd={vf}
+ Vrev={vr} Revepsilon=0.2 Epsilon=0.2)
.ends



***************************************************
*MOSFET Transistor 1
***************************************************
.subckt amosfet1 gate source drain params: roff=10MEG ron=1 vgt=1 vdf=0.3 vbr=30 rdo=3 k1=40 k2=40 k3=40 
X1 asw1 gate source drain source r1={2*roff} r2={ron} vt={vgt} k={k1}
X2 adiode source drain roff={2*roff} ron={rdo} vf={vdf} vr={vbr}
.ends



***************************************************
*MOSFET Transistor 2 (Not finished)
***************************************************
.subckt amosfet2 gate source drain params: roff=10MEG ron=1 vgt=1 rg=1 cgs1=1p cgs2=3p vbr=30 rdo=3 
a1 anode cathode ad1
.model ad1 sidiode(Roff={roff} Ron={ron} Rrev=2 Vfwd={vf}
+ Vrev={vr} Revepsilon=0.2 Epsilon=0.2 Ilimit=7 Revilimit=7)
.ends
