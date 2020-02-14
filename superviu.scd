(
SynthDef(\superviu, {
	var out = \out.kr(0);
	var pan = \pan.kr(0);
	var sustain = \sustain.kr(1);
	var freq = \freq.kr(440);
	var amp = \amp.kr(440);
	var env = EnvGen.ar(Env.linen(0.002, 0.996, 0.002, 1,-3), timeScale:sustain, doneAction:2);

	var sound = VarSaw.ar(freq + detune, width: width);

	OffsetOut.ar(out, DirtPan.ar(sound, ~dirt.numChannels, pan, env))
}).add;
)
SuperDirt.start