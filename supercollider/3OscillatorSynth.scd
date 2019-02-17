/*
3 oscillator square wave synth with modulation amplitudes and filter frequencies
*/
s.reboot
s.queryAllNodes

~length = Bus.control(s, 3);
~frequency = Bus.control(s, 3);
~widthAmp = Bus.control(s, 3);
~widthFreq = Bus.control(s, 3);
~opacityAmp = Bus.control(s, 3);
~opacityFreq = Bus.control(s, 3);
~red = Bus.control(s, 3);
~green = Bus.control(s, 3);
~blue = Bus.control(s, 3);

(
SynthDef(\threeOscSynth, {
    // standard meanings
    arg out = 0, freq = 440, gate = 1, pan = 0, amp = 0.1,
    // all of these range from 0 to 1
    vel = 0.8, modIndex = 0.2, mix = 0.2, lfoSpeed = 0.00, lfoDepth = 0.01,

	length = #[0.8, 0.0, 0.0],
	frequency = #[1, 3, 6],
	widthAmp = #[0.5, 0.5, 0.5],
	widthFreq = #[5, 2, 3],
	opacityAmp = #[1, 0.5, 0.5],
	opacityFreq = #[1, 2, 3],
	red = #[255, 0, 0],
	green = #[0, 255, 0],
	blue = #[0, 0, 255];


    var env1, env2, env3;
	var ampMod;
    var osc, snd;

	lfoSpeed = lfoSpeed * 12;

    //env1 = EnvGen.ar(Env.adsr(0.001, 1.25, 0.0, 0.04, curve: \lin));
    //env2 = EnvGen.ar(Env.adsr(0.001, 1.00, 0.0, 0.04, curve: \lin));
    //env3 = EnvGen.ar(Env.adsr(0.001, 1.50, 0.0, 0.04, curve: \lin));

	ampMod = [
		SinOsc.kr(widthFreq[0], 0, widthAmp[0], 1),
		SinOsc.kr(widthFreq[1], 0, widthAmp[1], 1),
		SinOsc.kr(widthFreq[2], 0, widthAmp[2], 1)
	];

	osc = Array.fill(3, { arg oscNum;
		[
			RLPF.ar(
				Pulse.ar(freq * frequency[oscNum], 0.5, ampMod[oscNum]),
				SinOsc.kr(opacityFreq[oscNum], 0, (opacityAmp[oscNum]), 1).linlin(0, 2, 500, 3000),
				opacityAmp[oscNum].linlin(0,1, 3, 0.8)
			) * vel;
		]
	});

	snd = Mix((length[0] * osc[0]) + (length[1] * osc[1]) + (length[2] * osc[2]));
    snd = snd * (SinOsc.ar(lfoSpeed) * lfoDepth + 1);

    // using the doneAction: 2 on the other envs can create clicks (bc of the linear curve maybe?)
	snd = snd * EnvGen.ar(Env.asr(0, 1, 0.1), gate, doneAction: 2);
    snd = Pan2.ar(snd, pan, amp);

    Out.ar(out, snd);
}).add;
)

a = Synth(\threeOscSynth, );
a.set(\freq, 100)

a.map(
	\length, ~length,
	\frequency, ~frequency,
	\widthAmp, ~widthAmp,
	\widthFreq, ~widthFreq,
	\opacityAmp, ~opacityAmp,
	\opacityFreq, ~opacityFreq,
	\red, ~red,
	\green, ~green,
	\blue, ~blue,
)

a.set(\length, [1,0.5,0.4])
a.set(\frequency, [2,7,4])
a.set(\widthFreq, [1,2,3])
a.set(\widthAmp, [1,1,1])
a.set(\opacityFreq, [1,1,2])
a.set(\opacityAmp, [0.0,0.5,0.0])

(
Pbind(
	\instrument, \threeOscSynth,
	\scale, Scale.mixolydian,
	\octave, 6,
	\root, 2,
	\legato, Pseq([0.9, 0.5, 0.5, 0.9, 0.9, 0.9, 0.9, 0.5, 1, 0.5, 1, 0.6, 0.3], inf),
	\dur, Pseq([1 + (1/3), 1/3, 1/3, 1/7, 6/7, 5/6, 1/6, 1/2, 2/6, 1/6, 2 + 1/2, 1, 1/2], inf),
	\degree, Pseq([
		[0, 2, 4], 2, 4, 7, 8, 7, 0, [1, 3, 6], 5, [1, 3, 6], Rest(), [-1, 1, 3], [1, 3, 5],
		[0, 2, 4], 2, 4, 8, 9, 7, 0, [1, 3, 6], 5, [1, 3, 6], Rest(), [-1, 1, 3], [1, 3, 5],
	], inf),
	\mix, 0.2,
	\modIndex, 0.2,
	\lfoSpeed, 0.5,
	\lfoDepth, 0.4,
	\vel, Pgauss(0.8, 0.1, inf),
	\amp, 0.3

).play(TempoClock(1.5));
)



~length.set(0.5, 0.5, 0.5);
~frequency.set(1, 2, 3);
~widthAmp.set(0.1, 0.2, 0.3);
~widthFreq.set(1, 2, 3);
~opacityAmp.set(0.1, 0.2, 0.3);
~opacityFreq.set(1, 2, 3);
