// This template implements the bare bones of a SynthDef that works with Tidalcycles and 
// makes it available like any other sound in Tidal.
//
// The symbol (name) of the SynthDef is the name of the sound in Tidal.
//
// The arguments (input parameters) of the SynthDef are accessed with the parameters in Tidal.
// You can add any parameters you like.  
//
// You can use or overwrite parameter names already available in Tidal, but beware that 
// you'll be loosing its original use.
//
// If you add a custom parameter with a name not available in Tidal, you need to declare and
// evaluate it in the Tidal document with the following syntax:
// 
// let paramname = pF "paramname"
//
// 'paramname' is whatever name you give to your parameter.
// 'pF' tells Tidal that this will be a float.  If you need integers use 'pI', but should work with 'pF' as well
//
// 'paramname' is the name you declare in Supercollider.  To keep it consistent, it's a good idea to 
// use the same name everywhere.  So, in your Supercollider SynthDef, you'd declare something like:
//
// SynthDef(\superviu, {
//  ...
//  var paramname = \paramname.kr(1);
//  ...
//
// where .kr is for control rate (use .ar if you need audio-rate) and '1' is the default value.
//
// Some parameters like 'freq' and 'amp' are used by others like 'n' or 'note' or 'gain' in 
// Tidal, so you don't need to explicitly declare them in Tidal even you use them in your SynthDef.
// Actually, you should only need 'freq' in your SynthDef, not 'n', 'note', etc.
//
// Envelope's attack and decay are handled internally by SuperDirt, so just use the envelope provided
// here if you don't need or want to create your own envelope.  This is an ASR envelope.
// 
// If you want to use your SynthDef with Tidal's effects, keep the Out function OffsetOut.ar(blablabla) as it is.
(
SynthDef(\superviu, {
	var out = \out.kr(0);
	var pan = \pan.kr(0);
	var sustain = \sustain.kr(1);
	var freq = \freq.kr(440);
	var amp = \amp.kr(440);
	var env = EnvGen.ar(Env.linen(0.002, 0.996, 0.002, 1,-3), timeScale:sustain, doneAction:2);

	var sound = VarSaw.ar(freq, width: width);

	OffsetOut.ar(out, DirtPan.ar(sound, ~dirt.numChannels, pan, env))
}).add;
)
SuperDirt.start
