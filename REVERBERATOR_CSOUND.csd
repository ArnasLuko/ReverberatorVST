;RVERBERATOR Reverb generator. 
;Controled variables listed on device.
<CsoundSynthesizer>
<CsOptions>
</CsOptions>
<CsInstruments>

sr = 44100
ksmps = 128
nchnls = 2
0dbfs = 1.0

instr		1 ;The first instrument.
icps		cpsmidi ;Allows for midi read.

;Sound generation section of instrument, generates a sawtooth oscilator and a sine LFO.
kEnv linsegr 0, 1, 1, 0.6, 0 ;An apmlitude envelope aimed at reducing midi clipping.
kcon0 invalue "slider0" ; Determines the ramp chatacteristics of the sawtooth oscilator.
kcon1 invalue "knob0" ; Acts as gain control for the LFO oscilator.
kcon2 invalue "knob1" ; Determines the LFO oscilator frequency.
asig vco2 kEnv*0.01, icps, 4, kcon0 ;A sawtooth oscilator with an amplitude envelope, middi input and ramp characteristics control.
amod poscil kcon1, kcon2 ;Modulation oscilator for LFO, sine wave with gain and frequency iputs.
amod2 butlp amod, 500 ;A lowpass filter for the LFO frequency.
aout = asig+asig*amod2 ;Combination of sawtooth and LFO.

;Filter section of the instrument controled by Equalizer section of instrument
kcon3 invalue "slider1" ;Incoming value from the lowend slider of the EQ.
kcon4 invalue "slider2" ;Incoming value for the midrange slider of the EQ.
kcon5 invalue "slider3" ;Incoming value for the high end slider of the EQ.
kcon6 invalue "slider4" ;Incoming value from the reverb dry/wet slider.
alosig   butlp   aout, 50  ;Low end filter.     
atmpsig  buthp   aout, 2000    ;Midrange filter one, a lowpass set at 2000hz.
amidsig  butlp   atmpsig, 5000 ;Midrange filter two, taking input from midrange filter one, adds a high pass filter set at 5000hz. 
ahisig   buthp   aout, 8000            ;High end filter .      
aout = kcon3*alosig+kcon4*amidsig+kcon5*ahisig ;Combination of filtered sounds.
outs aout*0.8, aout*0.8 ;The output of the instrument in stereo, multiplied by 0.8.
chnmix aout*kcon6, "send"; Sending of signals to a "send" chanel according to the reverb dry/wet slider value.
endin ;End of instrument line.

instr		99 ; The reverb instrument.
kcon7 invalue "knob2" ;Incoming value for reverb room size manipulation.
kcon8 invalue "knob3" ;Incoming value for a lowpass filter applied to reverb signal.
ain chnget "send" ; Reads information from the "Send" channel.
aL, aR  reverbsc ain, ain, kcon7, kcon8, sr, 1, 1; Reverb command line, with signal inputs and 2 changing krate variables.
outs aL,aR ; The output of the instrument in stereo.
chnclear "send" ;Clears the chanel "Send".
endin ;End of instrument line.


</CsInstruments>
<CsScore>
i 99 0 3600 ;itime score event, plays the reverb instrument for 1 hour.
</CsScore>
</CsoundSynthesizer>
<bsbPanel>
 <label>Widgets</label>
 <objectName/>
 <x>100</x>
 <y>100</y>
 <width>320</width>
 <height>240</height>
 <visible>true</visible>
 <uuid/>
 <bgcolor mode="nobackground">
  <r>217</r>
  <g>106</g>
  <b>112</b>
 </bgcolor>
 <bsbObject type="BSBLabel" version="2">
  <objectName/>
  <x>13</x>
  <y>4</y>
  <width>436</width>
  <height>353</height>
  <uuid>{0c13f4ce-0f87-4f6c-b483-bcbecb5e3540}</uuid>
  <visible>true</visible>
  <midichan>0</midichan>
  <midicc>-3</midicc>
  <label/>
  <alignment>left</alignment>
  <font>Arial</font>
  <fontsize>10</fontsize>
  <precision>3</precision>
  <color>
   <r>0</r>
   <g>0</g>
   <b>0</b>
  </color>
  <bgcolor mode="background">
   <r>229</r>
   <g>110</g>
   <b>109</b>
  </bgcolor>
  <bordermode>border</bordermode>
  <borderradius>1</borderradius>
  <borderwidth>1</borderwidth>
 </bsbObject>
 <bsbObject type="BSBLabel" version="2">
  <objectName/>
  <x>70</x>
  <y>54</y>
  <width>217</width>
  <height>36</height>
  <uuid>{3724c6a8-4daf-4eb7-8244-33df023045d8}</uuid>
  <visible>true</visible>
  <midichan>0</midichan>
  <midicc>-3</midicc>
  <label>THE REVERBERATOR</label>
  <alignment>left</alignment>
  <font>MS Shell Dlg 2</font>
  <fontsize>23</fontsize>
  <precision>3</precision>
  <color>
   <r>0</r>
   <g>0</g>
   <b>0</b>
  </color>
  <bgcolor mode="nobackground">
   <r>186</r>
   <g>90</g>
   <b>71</b>
  </bgcolor>
  <bordermode>border</bordermode>
  <borderradius>1</borderradius>
  <borderwidth>1</borderwidth>
 </bsbObject>
 <bsbObject type="BSBVSlider" version="2">
  <objectName>slider0</objectName>
  <x>38</x>
  <y>18</y>
  <width>30</width>
  <height>271</height>
  <uuid>{05f0ea25-3d63-49f2-a5a6-487965f528f4}</uuid>
  <visible>true</visible>
  <midichan>0</midichan>
  <midicc>0</midicc>
  <minimum>0.05000000</minimum>
  <maximum>0.95000000</maximum>
  <value>0.58468635</value>
  <mode>lin</mode>
  <mouseControl act="jump">continuous</mouseControl>
  <resolution>-1.00000000</resolution>
  <randomizable group="0">false</randomizable>
 </bsbObject>
 <bsbObject type="BSBLabel" version="2">
  <objectName/>
  <x>7</x>
  <y>315</y>
  <width>98</width>
  <height>41</height>
  <uuid>{d6192abe-eccc-4001-90a3-2f1df4b8bec8}</uuid>
  <visible>true</visible>
  <midichan>0</midichan>
  <midicc>-3</midicc>
  <label>OSCILATOR RAMP</label>
  <alignment>center</alignment>
  <font>Arial</font>
  <fontsize>11</fontsize>
  <precision>3</precision>
  <color>
   <r>0</r>
   <g>0</g>
   <b>0</b>
  </color>
  <bgcolor mode="nobackground">
   <r>255</r>
   <g>255</g>
   <b>255</b>
  </bgcolor>
  <bordermode>noborder</bordermode>
  <borderradius>1</borderradius>
  <borderwidth>1</borderwidth>
 </bsbObject>
 <bsbObject type="BSBDisplay" version="2">
  <objectName>slider0</objectName>
  <x>33</x>
  <y>293</y>
  <width>40</width>
  <height>23</height>
  <uuid>{6b54c77e-018f-4206-96ac-3ff4e8f798c1}</uuid>
  <visible>true</visible>
  <midichan>0</midichan>
  <midicc>-3</midicc>
  <label>0.236</label>
  <alignment>left</alignment>
  <font>Arial</font>
  <fontsize>10</fontsize>
  <precision>3</precision>
  <color>
   <r>0</r>
   <g>0</g>
   <b>0</b>
  </color>
  <bgcolor mode="background">
   <r>255</r>
   <g>255</g>
   <b>255</b>
  </bgcolor>
  <bordermode>border</bordermode>
  <borderradius>1</borderradius>
  <borderwidth>1</borderwidth>
 </bsbObject>
 <bsbObject type="BSBLabel" version="2">
  <objectName/>
  <x>97</x>
  <y>97</y>
  <width>147</width>
  <height>253</height>
  <uuid>{7e6052be-faf2-402b-8d97-a08075d8b574}</uuid>
  <visible>true</visible>
  <midichan>0</midichan>
  <midicc>-3</midicc>
  <label/>
  <alignment>left</alignment>
  <font>Arial</font>
  <fontsize>10</fontsize>
  <precision>3</precision>
  <color>
   <r>0</r>
   <g>0</g>
   <b>0</b>
  </color>
  <bgcolor mode="background">
   <r>95</r>
   <g>95</g>
   <b>95</b>
  </bgcolor>
  <bordermode>noborder</bordermode>
  <borderradius>1</borderradius>
  <borderwidth>1</borderwidth>
 </bsbObject>
 <bsbObject type="BSBKnob" version="2">
  <objectName>knob1</objectName>
  <x>106</x>
  <y>242</y>
  <width>80</width>
  <height>80</height>
  <uuid>{285a81f9-a0af-4c39-981e-60ba59026b34}</uuid>
  <visible>true</visible>
  <midichan>0</midichan>
  <midicc>0</midicc>
  <minimum>0.00000000</minimum>
  <maximum>30.00000000</maximum>
  <value>4.50000000</value>
  <mode>lin</mode>
  <mouseControl act="jump">continuous</mouseControl>
  <resolution>0.01000000</resolution>
  <randomizable group="0">false</randomizable>
 </bsbObject>
 <bsbObject type="BSBKnob" version="2">
  <objectName>knob0</objectName>
  <x>106</x>
  <y>129</y>
  <width>80</width>
  <height>80</height>
  <uuid>{ffdd96e9-3771-4715-8f47-282f7cde6f3f}</uuid>
  <visible>true</visible>
  <midichan>0</midichan>
  <midicc>0</midicc>
  <minimum>0.01000000</minimum>
  <maximum>0.20000000</maximum>
  <value>0.01000000</value>
  <mode>lin</mode>
  <mouseControl act="jump">continuous</mouseControl>
  <resolution>0.01000000</resolution>
  <randomizable group="0">false</randomizable>
 </bsbObject>
 <bsbObject type="BSBLabel" version="2">
  <objectName/>
  <x>115</x>
  <y>210</y>
  <width>80</width>
  <height>25</height>
  <uuid>{54cbc4c0-a248-4a21-a818-58efdbda14ee}</uuid>
  <visible>true</visible>
  <midichan>0</midichan>
  <midicc>-3</midicc>
  <label>LFO GAIN</label>
  <alignment>left</alignment>
  <font>Arial</font>
  <fontsize>12</fontsize>
  <precision>3</precision>
  <color>
   <r>255</r>
   <g>255</g>
   <b>255</b>
  </color>
  <bgcolor mode="nobackground">
   <r>255</r>
   <g>255</g>
   <b>255</b>
  </bgcolor>
  <bordermode>noborder</bordermode>
  <borderradius>1</borderradius>
  <borderwidth>1</borderwidth>
 </bsbObject>
 <bsbObject type="BSBLabel" version="2">
  <objectName/>
  <x>106</x>
  <y>323</y>
  <width>117</width>
  <height>26</height>
  <uuid>{efc6a655-fed7-4df5-bcb2-54c7cbb4e5cd}</uuid>
  <visible>true</visible>
  <midichan>0</midichan>
  <midicc>-3</midicc>
  <label>LFO FREQUENCY</label>
  <alignment>left</alignment>
  <font>Arial</font>
  <fontsize>12</fontsize>
  <precision>3</precision>
  <color>
   <r>255</r>
   <g>255</g>
   <b>255</b>
  </color>
  <bgcolor mode="nobackground">
   <r>255</r>
   <g>255</g>
   <b>255</b>
  </bgcolor>
  <bordermode>noborder</bordermode>
  <borderradius>1</borderradius>
  <borderwidth>1</borderwidth>
 </bsbObject>
 <bsbObject type="BSBDisplay" version="2">
  <objectName>knob0</objectName>
  <x>191</x>
  <y>151</y>
  <width>38</width>
  <height>23</height>
  <uuid>{958453a2-faf9-4da3-94d1-32c36247d182}</uuid>
  <visible>true</visible>
  <midichan>0</midichan>
  <midicc>-3</midicc>
  <label>0.139</label>
  <alignment>left</alignment>
  <font>Arial</font>
  <fontsize>10</fontsize>
  <precision>3</precision>
  <color>
   <r>255</r>
   <g>255</g>
   <b>255</b>
  </color>
  <bgcolor mode="nobackground">
   <r>255</r>
   <g>255</g>
   <b>255</b>
  </bgcolor>
  <bordermode>border</bordermode>
  <borderradius>1</borderradius>
  <borderwidth>1</borderwidth>
 </bsbObject>
 <bsbObject type="BSBDisplay" version="2">
  <objectName>knob1</objectName>
  <x>193</x>
  <y>270</y>
  <width>38</width>
  <height>23</height>
  <uuid>{0cb552b2-f6e4-4137-8c54-1d88ec180402}</uuid>
  <visible>true</visible>
  <midichan>0</midichan>
  <midicc>-3</midicc>
  <label>4.500</label>
  <alignment>left</alignment>
  <font>Arial</font>
  <fontsize>10</fontsize>
  <precision>3</precision>
  <color>
   <r>255</r>
   <g>255</g>
   <b>255</b>
  </color>
  <bgcolor mode="nobackground">
   <r>255</r>
   <g>255</g>
   <b>255</b>
  </bgcolor>
  <bordermode>border</bordermode>
  <borderradius>1</borderradius>
  <borderwidth>1</borderwidth>
 </bsbObject>
 <bsbObject type="BSBLabel" version="2">
  <objectName/>
  <x>109</x>
  <y>102</y>
  <width>128</width>
  <height>29</height>
  <uuid>{b38987a8-bce5-47c5-8625-4bfc879a4bce}</uuid>
  <visible>true</visible>
  <midichan>0</midichan>
  <midicc>-3</midicc>
  <label>LFO CONTROLS</label>
  <alignment>left</alignment>
  <font>Arial</font>
  <fontsize>15</fontsize>
  <precision>3</precision>
  <color>
   <r>255</r>
   <g>255</g>
   <b>255</b>
  </color>
  <bgcolor mode="nobackground">
   <r>255</r>
   <g>255</g>
   <b>255</b>
  </bgcolor>
  <bordermode>noborder</bordermode>
  <borderradius>1</borderradius>
  <borderwidth>1</borderwidth>
 </bsbObject>
 <bsbObject type="BSBLabel" version="2">
  <objectName/>
  <x>247</x>
  <y>198</y>
  <width>193</width>
  <height>152</height>
  <uuid>{1aa4c545-32ff-4e70-9fcc-fa9662946dad}</uuid>
  <visible>true</visible>
  <midichan>0</midichan>
  <midicc>-3</midicc>
  <label/>
  <alignment>left</alignment>
  <font>Arial</font>
  <fontsize>10</fontsize>
  <precision>3</precision>
  <color>
   <r>0</r>
   <g>0</g>
   <b>0</b>
  </color>
  <bgcolor mode="background">
   <r>95</r>
   <g>95</g>
   <b>95</b>
  </bgcolor>
  <bordermode>noborder</bordermode>
  <borderradius>1</borderradius>
  <borderwidth>1</borderwidth>
 </bsbObject>
 <bsbObject type="BSBVSlider" version="2">
  <objectName>slider1</objectName>
  <x>270</x>
  <y>235</y>
  <width>20</width>
  <height>100</height>
  <uuid>{5e24582b-9905-4be0-9ada-f120132d5948}</uuid>
  <visible>true</visible>
  <midichan>0</midichan>
  <midicc>0</midicc>
  <minimum>0.00000000</minimum>
  <maximum>30.00000000</maximum>
  <value>27.60000000</value>
  <mode>lin</mode>
  <mouseControl act="jump">continuous</mouseControl>
  <resolution>-1.00000000</resolution>
  <randomizable group="0">false</randomizable>
 </bsbObject>
 <bsbObject type="BSBVSlider" version="2">
  <objectName>slider3</objectName>
  <x>337</x>
  <y>235</y>
  <width>20</width>
  <height>100</height>
  <uuid>{1326b51c-a71b-416d-a001-6b6039b0e889}</uuid>
  <visible>true</visible>
  <midichan>0</midichan>
  <midicc>0</midicc>
  <minimum>0.00000000</minimum>
  <maximum>30.00000000</maximum>
  <value>18.90000000</value>
  <mode>lin</mode>
  <mouseControl act="jump">continuous</mouseControl>
  <resolution>-1.00000000</resolution>
  <randomizable group="0">false</randomizable>
 </bsbObject>
 <bsbObject type="BSBVSlider" version="2">
  <objectName>slider2</objectName>
  <x>399</x>
  <y>235</y>
  <width>20</width>
  <height>100</height>
  <uuid>{53a0b5ad-4d26-4b81-a1ad-5f9c41e5a155}</uuid>
  <visible>true</visible>
  <midichan>0</midichan>
  <midicc>0</midicc>
  <minimum>0.00000000</minimum>
  <maximum>30.00000000</maximum>
  <value>24.90000000</value>
  <mode>lin</mode>
  <mouseControl act="jump">continuous</mouseControl>
  <resolution>-1.00000000</resolution>
  <randomizable group="0">false</randomizable>
 </bsbObject>
 <bsbObject type="BSBLabel" version="2">
  <objectName/>
  <x>265</x>
  <y>331</y>
  <width>37</width>
  <height>22</height>
  <uuid>{b5286f3f-5f61-4573-b508-d58bd854651b}</uuid>
  <visible>true</visible>
  <midichan>0</midichan>
  <midicc>-3</midicc>
  <label>LOW</label>
  <alignment>left</alignment>
  <font>Arial</font>
  <fontsize>11</fontsize>
  <precision>3</precision>
  <color>
   <r>255</r>
   <g>255</g>
   <b>255</b>
  </color>
  <bgcolor mode="nobackground">
   <r>255</r>
   <g>255</g>
   <b>255</b>
  </bgcolor>
  <bordermode>noborder</bordermode>
  <borderradius>1</borderradius>
  <borderwidth>1</borderwidth>
 </bsbObject>
 <bsbObject type="BSBLabel" version="2">
  <objectName/>
  <x>331</x>
  <y>331</y>
  <width>37</width>
  <height>22</height>
  <uuid>{e3395bbe-951a-4b9f-b8a3-faf6c7a053bc}</uuid>
  <visible>true</visible>
  <midichan>0</midichan>
  <midicc>-3</midicc>
  <label>MID</label>
  <alignment>left</alignment>
  <font>Arial</font>
  <fontsize>12</fontsize>
  <precision>3</precision>
  <color>
   <r>255</r>
   <g>255</g>
   <b>255</b>
  </color>
  <bgcolor mode="nobackground">
   <r>255</r>
   <g>255</g>
   <b>255</b>
  </bgcolor>
  <bordermode>noborder</bordermode>
  <borderradius>1</borderradius>
  <borderwidth>1</borderwidth>
 </bsbObject>
 <bsbObject type="BSBLabel" version="2">
  <objectName/>
  <x>392</x>
  <y>331</y>
  <width>37</width>
  <height>22</height>
  <uuid>{89dca6b6-c3c0-4dc9-9ce9-05657d18f247}</uuid>
  <visible>true</visible>
  <midichan>0</midichan>
  <midicc>-3</midicc>
  <label>HIGH</label>
  <alignment>left</alignment>
  <font>Arial</font>
  <fontsize>11</fontsize>
  <precision>3</precision>
  <color>
   <r>255</r>
   <g>255</g>
   <b>255</b>
  </color>
  <bgcolor mode="nobackground">
   <r>255</r>
   <g>255</g>
   <b>255</b>
  </bgcolor>
  <bordermode>noborder</bordermode>
  <borderradius>1</borderradius>
  <borderwidth>1</borderwidth>
 </bsbObject>
 <bsbObject type="BSBLabel" version="2">
  <objectName/>
  <x>287</x>
  <y>202</y>
  <width>117</width>
  <height>26</height>
  <uuid>{9204423b-52c6-4057-965e-3147a0e40e4c}</uuid>
  <visible>true</visible>
  <midichan>0</midichan>
  <midicc>-3</midicc>
  <label>EQUALIZER</label>
  <alignment>left</alignment>
  <font>Arial</font>
  <fontsize>18</fontsize>
  <precision>3</precision>
  <color>
   <r>255</r>
   <g>255</g>
   <b>255</b>
  </color>
  <bgcolor mode="nobackground">
   <r>255</r>
   <g>255</g>
   <b>255</b>
  </bgcolor>
  <bordermode>noborder</bordermode>
  <borderradius>1</borderradius>
  <borderwidth>1</borderwidth>
 </bsbObject>
 <bsbObject type="BSBKnob" version="2">
  <objectName>knob2</objectName>
  <x>378</x>
  <y>47</y>
  <width>61</width>
  <height>74</height>
  <uuid>{7cf5803c-759a-4ebe-b2a9-c69e9fcb4a8d}</uuid>
  <visible>true</visible>
  <midichan>0</midichan>
  <midicc>0</midicc>
  <minimum>0.00000000</minimum>
  <maximum>1.00000000</maximum>
  <value>0.95000000</value>
  <mode>lin</mode>
  <mouseControl act="jump">continuous</mouseControl>
  <resolution>0.01000000</resolution>
  <randomizable group="0">false</randomizable>
 </bsbObject>
 <bsbObject type="BSBKnob" version="2">
  <objectName>knob3</objectName>
  <x>378</x>
  <y>119</y>
  <width>61</width>
  <height>74</height>
  <uuid>{2fc2bcd8-4ef3-4978-9a1c-80711629c5cc}</uuid>
  <visible>true</visible>
  <midichan>0</midichan>
  <midicc>0</midicc>
  <minimum>0.00000000</minimum>
  <maximum>12000.00000000</maximum>
  <value>11880.00000000</value>
  <mode>lin</mode>
  <mouseControl act="jump">continuous</mouseControl>
  <resolution>0.01000000</resolution>
  <randomizable group="0">false</randomizable>
 </bsbObject>
 <bsbObject type="BSBHSlider" version="2">
  <objectName>slider4</objectName>
  <x>81</x>
  <y>9</y>
  <width>355</width>
  <height>27</height>
  <uuid>{91406abd-956d-4f61-882d-de9a585df25c}</uuid>
  <visible>true</visible>
  <midichan>0</midichan>
  <midicc>0</midicc>
  <minimum>0.00000000</minimum>
  <maximum>1.00000000</maximum>
  <value>0.98028169</value>
  <mode>lin</mode>
  <mouseControl act="jump">continuous</mouseControl>
  <resolution>-1.00000000</resolution>
  <randomizable group="0">false</randomizable>
 </bsbObject>
 <bsbObject type="BSBLabel" version="2">
  <objectName/>
  <x>190</x>
  <y>28</y>
  <width>141</width>
  <height>27</height>
  <uuid>{6c1e3d0e-3873-4b44-b944-84c6c6236832}</uuid>
  <visible>true</visible>
  <midichan>0</midichan>
  <midicc>-3</midicc>
  <label>REVERB DRY/WET</label>
  <alignment>left</alignment>
  <font>Arial</font>
  <fontsize>13</fontsize>
  <precision>3</precision>
  <color>
   <r>0</r>
   <g>0</g>
   <b>0</b>
  </color>
  <bgcolor mode="nobackground">
   <r>255</r>
   <g>255</g>
   <b>255</b>
  </bgcolor>
  <bordermode>noborder</bordermode>
  <borderradius>1</borderradius>
  <borderwidth>1</borderwidth>
 </bsbObject>
 <bsbObject type="BSBLabel" version="2">
  <objectName/>
  <x>286</x>
  <y>71</y>
  <width>109</width>
  <height>38</height>
  <uuid>{cdb66126-0d4b-4631-95c2-be0f7fb62159}</uuid>
  <visible>true</visible>
  <midichan>0</midichan>
  <midicc>-3</midicc>
  <label>ROOM SIZE</label>
  <alignment>left</alignment>
  <font>Arial</font>
  <fontsize>15</fontsize>
  <precision>3</precision>
  <color>
   <r>0</r>
   <g>0</g>
   <b>0</b>
  </color>
  <bgcolor mode="nobackground">
   <r>255</r>
   <g>255</g>
   <b>255</b>
  </bgcolor>
  <bordermode>noborder</bordermode>
  <borderradius>1</borderradius>
  <borderwidth>1</borderwidth>
 </bsbObject>
 <bsbObject type="BSBLabel" version="2">
  <objectName/>
  <x>279</x>
  <y>133</y>
  <width>109</width>
  <height>47</height>
  <uuid>{cf4ff063-367e-491a-bff4-a681ab7d565e}</uuid>
  <visible>true</visible>
  <midichan>0</midichan>
  <midicc>-3</midicc>
  <label>LOW PASS FILTER</label>
  <alignment>center</alignment>
  <font>Arial</font>
  <fontsize>15</fontsize>
  <precision>3</precision>
  <color>
   <r>0</r>
   <g>0</g>
   <b>0</b>
  </color>
  <bgcolor mode="nobackground">
   <r>255</r>
   <g>255</g>
   <b>255</b>
  </bgcolor>
  <bordermode>noborder</bordermode>
  <borderradius>1</borderradius>
  <borderwidth>1</borderwidth>
 </bsbObject>
</bsbPanel>
<bsbPresets>
</bsbPresets>
