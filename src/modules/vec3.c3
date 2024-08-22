module modules::vec3;

union Vec3
{
	struct {
		double x, y, z;
	}
	double[3] e;
}

fn Vec3 Vec3.new(Vec3* self = null, double x, double y, double z)
{
	return Vec3{ .e={x, y, z} };
}

fn Vec3 new(double x, double y, double z)
{
	//return Vec3{ .e={x, y, z} };
	return Vec3.new(.x=x, .y=y, .z=z);
}

fn String Vec3.to_string(&self)
{
	DString out;
	out.appendfn("Vec3 {\n  x: %f,\n  y: %f,\n  z: %f\n}", self.e[0], self.e[1], self.e[2]);
	return out.tcopy_str();
}