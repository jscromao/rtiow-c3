module rtiow_c3;
import std::io;
import modules::vec3;
import modules::color;
import std::core::dstring;
import std::core::cinterop;
//import std::core::dstring;

/*
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
*/


fn int main(String[] args) {
	const IMAGE_WIDTH = 256i32;
	const int IMAGE_HEIGHT = 256;

	io::printf("P3 \n %d %d\n255\n", IMAGE_WIDTH, IMAGE_HEIGHT);

	for (int j = IMAGE_HEIGHT -1 ; j >= 0 ; j -= 1)
	{
		io::eprintf("\rScanlines remaining: %d ", j);

		for (int i = 0; i < IMAGE_WIDTH; i += 1)
		{
			double r = (double)i / (IMAGE_WIDTH - 1);
			double g = (double)j / (IMAGE_HEIGHT - 1);
			double b = 0.25;

			// int ir = (int)(255.999 * r);
			// int ig = (int)(255.999 * g);
			// int ib = (int)(255.999 * b);

			// io::printfn("%d %d %d", ir, ig, ib);
			color::write_color(Color{r, g, b});
		}
	}

	io::eprintn("\nDone.");

	Vec3 lal = Vec3.new(.x=1.0, .y=2.0, .z=4.0);
	Vec3 lel = vec3::new(1.0, 3.0, 9.0);
	Vec3 lil = {1.0, 4.0, 16.0};
	Vec3 lol = {.e = {1.0, 5.0, 25.0}};
	Vec3 lul = Vec3{.x=1.0, .y=6.0, .z=36.0};

	io::eprintfn("lal was:\n%s", lal.to_string());
	io::eprintfn("lel was:\n%s", lel.to_string());
	io::eprintfn("lil was:\n%s", lil.to_string());
	io::eprintfn("lol was:\n%s", lol.to_string());
	io::eprintfn("lul was:\n%s", lul.to_string());
	return 0;
}
