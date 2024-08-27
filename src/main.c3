module rtiow_c3;
import std::io;
import modules::vec3;
import modules::color;
import modules::point3;
import modules::ray;
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

fn bool hit_sphere(Point3 center, double radius, Ray* r) {
	Vec3 r_dir = r.direction();
	Vec3 oc = r.origin().sub_vec(center);
	double a = r_dir.dot(r_dir);
	double b = 2.0 * oc.dot(r_dir);
	double c = oc.dot(oc) - radius * radius;
	double discriminant = b * b - 4.0 * a * c;
	return discriminant >= 0.0;
}

fn Color ray_color(Ray* r) {
	if (hit_sphere(Point3{0.0, 0.0, -1.0}, 0.5, r)) {
		return Color{1.0, 0.0, 0.0};
	}

	Vec3 r_dir = r.direction();
	Vec3 unit_direction = r_dir.unit_vector();
	double t = 0.5 * (unit_direction.y + 1.0);
	return Color{1.0, 1.0, 1.0}.mul_scalar(1.0 - t).add_vec(Color{0.5, 0.7, 1.0}.mul_scalar(t));
}


fn int main(String[] args) {
	// Image
	const double ASPECT_RATIO = 16.0 / 9.0;
	const IMAGE_WIDTH = 400i32;
	const int IMAGE_HEIGHT = (int)((double)IMAGE_WIDTH / ASPECT_RATIO);

	// Camera
	double viewport_height = 2.0;
	double viewport_width = ASPECT_RATIO * viewport_height;
	double focal_length = 1.0;

	Point3 origin = Point3{0.0, 0.0, 0.0};
	Vec3 horizontal = Vec3{viewport_width, 0.0, 0.0};
	Vec3 vertical = Vec3{0.0, viewport_height, 0.0};
	Vec3 half_horizontal = horizontal.div_scalar(2.0);
	Vec3 half_vertical = vertical.div_scalar(2.0);
	Vec3 lower_left_corner = origin.sub_vec(half_horizontal).sub_vec(half_vertical).sub_vec(Vec3{0.0, 0.0, focal_length});

	// Render

	io::printf("P3 \n %d %d\n255\n", IMAGE_WIDTH, IMAGE_HEIGHT);

	for (int j = IMAGE_HEIGHT -1 ; j >= 0 ; j -= 1)
	{
		io::eprintf("\rScanlines remaining: %d ", j);

		for (int i = 0; i < IMAGE_WIDTH; i += 1)
		{
			// double r = (double)i / (IMAGE_WIDTH - 1);
			// double g = (double)j / (IMAGE_HEIGHT - 1);
			// double b = 0.25;
			// color::write_color(Color{r, g, b});

			double u = (double)i / (double)(IMAGE_WIDTH - 1);
			double v = (double)j / (double)(IMAGE_HEIGHT - 1);
			Vec3 our_dir = lower_left_corner.add_vec(horizontal.mul_scalar(u)).add_vec(vertical.mul_scalar(v)).sub_vec(origin);
			Ray r = Ray.new(.origin = origin, .direction = our_dir);
			Color pixel_color = ray_color(&r);
			color::write_color(pixel_color);
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
