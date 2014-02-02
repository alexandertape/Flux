<CsoundSynthesizer>
<CsOptions>
-odac -d
</CsOptions>
<CsInstruments>
sr = 44100
ksmps = 1
nchnls = 2
0dbfs = 1
#define IPADDRESS	# "localhost" #
#define PORT 		# 12000 #


gisine ftgen 99, 0, 4096, 10, 1
garvbL init 0
garvbR init 0
gadelay init 0
gifn ftgen 0,0, 257, 9, .5,1,2700
alwayson 7

instr 1;;;;;; FM Synth Sound
kmodenv linseg 1, p3/32, 7
kndxenv linseg 16, p3/32, 8, p3/4, 4
;kenv linseg 0, .8, 1, p3/2 - .8, 0
kenv linsegr 0, p3, 1, 0.1, 0
kamp = p4
ipch = cpsmidinn(p5)
kpan = p6
klfo oscil 1, 2, gisine

afmsynth foscili kamp, ipch+klfo, 1, 2.005, kndxenv, gisine
afmsynth moogladder afmsynth, 1000, 0
aL, aR pan2 afmsynth, kpan

OSCsend 0, $IPADDRESS, $PORT, "/csound/circ", "f", 1.0


outs (aL * kenv), (aR * kenv)

garvbL = garvbL + (aL * .2)
garvbR = garvbR + (aR * .2)
gadelay = gadelay + ((aL)*0.4)
endin

instr 2;wavesetting guitars
ifn = p10
aamp = p4
aL, aR lposcilsa aamp, 1, 0, 96000, ifn
aL,aR bbcuts aL, aR, p5, p6, p7,p8, p9
aL phaser1 aL, 8000, 8, .9
aR phaser1 aR, 8000, 8, .9

OSCsend 0, $IPADDRESS, $PORT, "/csound/tri", "f", 1.0

aL = aL * 0.08
aR = aR * 0.08
outs aL, aR

garvbL = garvbL + (aL)
garvbR = garvbR + (aR)
gadelay = gadelay +((aL)*0.4)
endin

instr 3; plucked string
iplk = p4
kamp = p5
icps = cpsmidinn(p6)
kpick = p7
krefl = p8
kpan = p9
irvbsnd = p10

apluck wgpluck2 iplk, kamp, icps, kpick, krefl
aclk linsegr 0, 0.01, 1, 0.01, 0
aL, aR pan2 apluck * aclk, kpan
OSCsend 0, $IPADDRESS, $PORT, "/csound/line", "f", 1.0


out aL, aR

garvbL = garvbL + (aL * irvbsnd)
garvbR = garvbR + (aR * irvbsnd)
gadelay = gadelay +((aL)*0.9)

endin

instr 6
kamp = p4
kpitch = p5
ifn = p6
kpan = p7
irvbsnd = p8
asig flooper 0.2, kpitch, 0, 1, 0.05, ifn
aL, aR pan2 asig, kpan
OSCsend 0, $IPADDRESS, $PORT, "/csound/perc", "f", 1.0
aL = aL * 0.6
aR = aR *0.6
outs aL, aR

garvbL = garvbL + (aL * 0.6)
garvbR = garvbR + (aL * 0.6)
gadelay = gadelay + (aL * 0.5)
endin

instr 7; dust (persistant noise)
a1 dust 0.3, 5
a1 butbp a1, 3000, 500
outs a1, a1 

garvbL = garvbL + (a1 * 0.6)
garvbR = garvbR + (a1 * 0.6)
endin

;instruments for second mvt

instr 11
kamp = p4
kpitch = p5
kpan = p6
irvbsnd = p7
asig flooper 0.2, kpitch, 0, 1, 0.05, 101
aL, aR pan2 asig, kpan
OSCsend 0, $IPADDRESS, $PORT, "/csound/drumone", "f", kamp
aL = aL * 0.6
aR = aR *0.6
outs aL, aR

garvbL = garvbL + (aL * irvbsnd)
garvbR = garvbR + (aL * irvbsnd)
gadelay = gadelay + (aL * 0.4)
endin


instr 12
kamp = p4
kpitch = p5
kpan = p6
irvbsnd = p7
asig flooper 0.2, kpitch, 0, 1, 0.05, 102
aL, aR pan2 asig, kpan
OSCsend 0, $IPADDRESS, $PORT, "/csound/drumtwo", "f", kamp
aL = aL * 0.6
aR = aR *0.6
outs aL, aR

garvbL = garvbL + (aL * 0.6)
garvbR = garvbR + (aL * 0.6)
gadelay = gadelay + (aL * 0.4)
endin

instr 13
kamp = p4
kpitch = p5
kpan = p6
irvbsnd = p7
asig flooper 0.2, kpitch, 0, 1, 0.05, 103
aL, aR pan2 asig, kpan
OSCsend 0, $IPADDRESS, $PORT, "/csound/drumthree", "f", kamp
aL = aL * 0.6
aR = aR *0.6
outs aL, aR

garvbL = garvbL + (aL * 0.6)
garvbR = garvbR + (aL * 0.6)
gadelay = gadelay + (aL * 0.4)
endin

instr 14
kamp = p4
kpitch = p5
kpan = p6
irvbsnd = p7
asig flooper 0.2, kpitch, 0, 1, 0.05, 104
aL, aR pan2 asig, kpan
OSCsend 0, $IPADDRESS, $PORT, "/csound/drumfour", "f", kamp
aL = aL * 0.6
aR = aR *0.6
outs aL, aR

garvbL = garvbL + (aL * 0.6)
garvbR = garvbR + (aL * 0.6)
gadelay = gadelay + (aL * 0.4)
endin

instr 19
OSCsend 0, $IPADDRESS, $PORT, "/csound/bgblack", "f", 1.0
endin

instr 20
OSCsend 0, $IPADDRESS, $PORT, "/csound/bgtrigger", "f", 1.0
endin

instr 21;;;;;; FM Synth Sound
kmodenv linseg 1, p3/32, 7
kndxenv linseg 16, p3/32, 8, p3/4, 4
;kenv linseg 0, .8, 1, p3/2 - .8, 0
kenv linsegr 0, p3, 1, 0.1, 0
kamp = p4
ipch = cpsmidinn(p5)
kpan = p6
klfo oscil 1, 2, gisine

afmsynth foscili kamp, ipch+klfo, 1, 2.005, kndxenv, gisine
afmsynth moogladder afmsynth, 500, 0
afmsynth distort afmsynth, 0.8, gifn
afmsynth moogladder afmsynth, 500, 0
aL, aR pan2 afmsynth, kpan

OSCsend 0, $IPADDRESS, $PORT, "/csound/circ", "f", 1.0


outs (aL * kenv), (aR * kenv)

garvbL = garvbL + (aL * .2)
garvbR = garvbR + (aR * .2)
gadelay = gadelay + ((aL)*0.4)
endin

instr 22;wavesetting guitars
ifn = p10
aamp = p4
aL, aR lposcilsa aamp, 1, 0, 96000, ifn
aL,aR bbcuts aL, aR, p5, p6, p7,p8, p9
aL phaser1 aL, 8000, 80, .9
aL distort aL, 0.5, gifn
aR phaser1 aR, 8000, 80, .9
aR distort aR, 0.5, gifn
OSCsend 0, $IPADDRESS, $PORT, "/csound/tri", "f", 1.0

aL = aL * 0.08
aR = aR * 0.08
outs aL, aR

garvbL = garvbL + (aL)
garvbR = garvbR + (aR)
gadelay = gadelay +((aL)*0.4)
endin

instr 23; plucked string
iplk = p4
kamp = p5
icps = cpsmidinn(p6)
kpick = p7
krefl = p8
kpan = p9
irvbsnd = p10

apluck wgpluck2 iplk, kamp, icps, kpick, krefl
apluck distort apluck, 0.8, gifn
aclk linsegr 0, 0.01, 1, 0.01, 0
aL, aR pan2 apluck * aclk, kpan
OSCsend 0, $IPADDRESS, $PORT, "/csound/line", "f", 1.0


out aL, aR

garvbL = garvbL + (aL * irvbsnd)
garvbR = garvbR + (aR * irvbsnd)
gadelay = gadelay +((aL)*0.9)

endin

;global effects

instr 997
asig init 0
asig vdelay3 gadelay +(asig*0.6),3000, 20000 
asig butterlp asig, 2000
outs asig, asig
garvbL = garvbL + (asig*0.3)
garvbR = garvbR + (asig*0.3)
clear gadelay
endin

instr 998
asig init 0
asig vdelay3 gadelay +(asig*0.5),1000, 20000 
asig butterlp asig, 2000
outs asig, asig
garvbL = garvbL + (asig*0.3)
garvbR = garvbR + (asig*0.3)
clear gadelay
endin

instr 999
denorm garvbL, garvbL
aL, aR reverbsc garvbL, garvbR, 0.95, 40000
outs aL, aR
garvbL = 0
garvbR = 0
endin

</CsInstruments>
<CsScore>
f 1 0 262144 1 "ac.wav" 0 0 0	
f 2 0 262144 1 "crackle.wav" 0 0 0	
f 3 0 262144 1 "ac.wav" 0 0 0	
f 4 0 262144 1 "glass.wav" 0 0 0	
f 5 0 262144 1 "glitch.wav" 0 0 0	
f 6 0 262144 1 "glitch.wav" 0 0 0
f 7 0 262144 1 "speaker.wav" 0 0 0		
f 8 0 262144 1 "amel.wav" 0 0 0
f 9 0 262144 1 "amsev.wav" 0 0 0
f 10 0 262144 1 "cmajn.wav" 0 0 0
f 11 0 262144 1 "cmajsev.wav" 0 0 0
f 12 0 262144 1 "fmajn.wav" 0 0 0
f 13 0 262144 1 "fmajsev.wav" 0 0 0

f 101 0 262144 1 "one.wav" 0 0 0	
f 102 0 262144 1 "two.wav" 0 0 0
f 103 0 262144 1 "three.wav" 0 0 0
f 104 0 2621440 1 "four.wav" 0 0 0

i997 0 $INF
i998 0 $INF
i999 0 $INF

</CsScore>
</CsoundSynthesizer>
