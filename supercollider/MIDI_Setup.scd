(

MIDIClient.init;
MIDIIn.connect(0);
// how to deal with midi polyphony
~notes = Array.newClear(128);
~bend = 8192;


~notes

MIDIdef.noteOn(\noteOnTest, {
	arg vel, nn, chan, src;
	[vel, nn,].postln;
	~notes[nn] = Synth.new(
		\threeOscSynth,
		[
			\freq, nn.midicps,
			\amp, vel.linexp(1,127,0.2,1),
			\gate, 1,
	]
	).register;
	~notes[nn].map(
	\length, ~length,
	\frequency, ~frequency,
	\widthAmp, ~widthAmp,
	\widthFreq, ~widthFreq,
	\opacityAmp, ~opacityAmp,
	\opacityFreq, ~opacityFreq,
	\red, ~red,
	\green, ~green,
	\blue, ~blue
);
});

MIDIdef.noteOff(\noteOffTest, {
	arg vel, nn;
	[vel, nn,].postln;
	~notes[nn].set(\gate, 0);
	~notes[nn] = nil;
});


MIDIdef.bend(\bendTest, {
	arg val, chan, src;
	[val, chan, src].postln;
	~bend = val;
	~notes.do{arg synth; synth.set(\bend, val.linlin(0,16383,-2,2))}
});
)

a = Synth.new(
		\threeOscSynth,
		[
			\freq, 64.midicps,
			\amp, 0.5,
			\gate, 1,
	]
)
a.free