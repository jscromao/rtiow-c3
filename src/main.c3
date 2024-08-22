module rtiow_c3;
import std::io;

def T_i8 = ichar;
def T_i16 = short;
def T_i32 = int;
def T_i64 = long;
def T_i128 = int128;
def T_isize = isz;

def T_u8 = char;
def T_u16 = ushort;
def T_u32 = uint;
def T_u64 = ulong;
def T_u128 = uint128;
def T_usize = usz;

def T_f32 = float;
def T_f64 = double;


fn int main(String[] args)
{
	const short MY_IMMUT_VAL = 3;
	io::printn(MY_IMMUT_VAL);
	io::printn("Hello, World!");
	foreach (String arg : args)
	{
		io::printn(arg);
	}
	return 0;
}
