module rtiow_c3;
import std::io;

// def T_i8 = ichar;
// def T_i16 = short;
// def T_i32 = int;
// def T_i64 = long;
// def T_i128 = int128;
// def T_isize = isz;

// def T_u8 = char;
// def T_u16 = ushort;
// def T_u32 = uint;
// def T_u64 = ulong;
// def T_u128 = uint128;
// def T_usize = usz;

// def T_f32 = float;
// def T_f64 = double;


fn int main(String[] args)
{
	const IMAGE_WIDTH = 256i32;
	const int IMAGE_HEIGHT = 256i64;

	io::printf("P3 \n %d %d\n255\n", IMAGE_WIDTH, IMAGE_HEIGHT);

	for (int j = IMAGE_HEIGHT -1 ; j >= 0 ; j -= 1) {
		io::eprintf("\rScanlines remaining: %d ", j);

		for (int i = 0; i < IMAGE_WIDTH; i += 1) {
			double r = (double)i / (double)(IMAGE_WIDTH - 1);
			double g = (double)j / (double)(IMAGE_HEIGHT - 1);
			double b = 0.25;

			int ir = (int)(255.999 * r);
			int ig = (int)(255.999 * g);
			int ib = (int)(255.999 * b);

			io::printfn("%d %d %d", ir, ig, ib);
			
		}
	}

	io::eprintn("\nDone.");

	// const short MY_IMMUT_VAL = 3;
	// io::printn(MY_IMMUT_VAL);
	// io::printn("Hello, World!");
	// foreach (String arg : args)
	// {
	// 	io::printn(arg);
	// }

	return 0;
}
