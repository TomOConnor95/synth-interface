

(

OSCdef.new(
	\length,
	{
		arg msg, time, addr, port;
		msg.postln;
		~length.set(msg[1], msg[2], msg[3]);
	},
	'/length'
);



OSCdef.new(
	\freq,
	{
		arg msg, time, addr, port;
		msg.postln;
		~frequency.set(msg[1], msg[2], msg[3]);
	},
	'/freq'
);



OSCdef.new(
	\widthAmp,
	{
		arg msg, time, addr, port;
		msg.postln;
		~widthAmp.set(msg[1], msg[2], msg[3]);
	},
	'/widthAmp'
);



OSCdef.new(
	\widthFreq,
	{
		arg msg, time, addr, port;
		msg.postln;
		~widthFreq.set(msg[1], msg[2], msg[3]);
	},
	'/widthFreq'
);



OSCdef.new(
	\opacityAmp,
	{
		arg msg, time, addr, port;
		msg.postln;
		~opacityAmp.set(msg[1], msg[2], msg[3]);
	},
	'/opacityAmp'
);



OSCdef.new(
	\opacityFreq,
	{
		arg msg, time, addr, port;
		msg.postln;
		~opacityFreq.set(msg[1], msg[2], msg[3]);
	},
	'/opacityFreq'
);

OSCdef.new(
	\red,
	{
		arg msg, time, addr, port;
		msg.postln;
		~red.set(msg[1], msg[2], msg[3]);
	},
	'/red'
);

OSCdef.new(
	\green,
	{
		arg msg, time, addr, port;
		msg.postln;
		~green.set(msg[1], msg[2], msg[3]);
	},
	'/green'
);

OSCdef.new(
	\blue,
	{
		arg msg, time, addr, port;
		msg.postln;
		~blue.set(msg[1], msg[2], msg[3]);
	},
	'/blue'
);


)


