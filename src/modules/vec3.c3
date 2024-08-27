module modules::vec3;
import std::math;

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

fn Vec3 new(double x, double y, double z) {
	//return Vec3{ .e={x, y, z} };
	return Vec3.new(.x=x, .y=y, .z=z);
}

fn String Vec3.to_string(&self) {
	DString out;
	out.appendfn("Vec3 {\n  x: %f,\n  y: %f,\n  z: %f\n}", self.e[0], self.e[1], self.e[2]);
	return out.tcopy_str();
}

fn double Vec3.length_squared(&self) {
	return self.x * self.x + self.y * self.y + self.z * self.z;
}

fn double Vec3.length(&self) {
	return math::sqrt(self.length_squared());
}

fn Vec3 Vec3.add_vec(self, Vec3 v) {
	return new(self.x + v.x, self.y + v.y, self.z + v.z);
}

fn Vec3 Vec3.sub_vec(self, Vec3 v) {
	return new(self.x - v.x, self.y - v.y, self.z - v.z);
}

fn Vec3 Vec3.mul_vec(self, Vec3 v) {
	return new(self.x * v.x, self.y * v.y, self.z * v.z);
}

fn Vec3 Vec3.div_vec(self, Vec3 v) {
	return new(self.x / v.x, self.y / v.y, self.z / v.z);
}

fn Vec3 Vec3.add_scalar(self, double value) {
	return new(self.x + value, self.y + value, self.z + value);
}

fn Vec3 Vec3.sub_scalar(self, double value) {
	return new(self.x - value, self.y - value, self.z - value);
}

fn Vec3 Vec3.mul_scalar(self, double value) {
	return new(self.x * value, self.y * value, self.z * value);
}

fn Vec3 Vec3.div_scalar(self, double value) {
	return new(self.x / value, self.y / value, self.z / value);
}

fn Vec3 Vec3.unit_vector(&self) {
	return self.div_scalar(self.length());
}

fn double Vec3.dot(&self, Vec3 v) {
	return self.x * v.x + self.y * v.y + self.z * v.z;
}

fn Vec3 Vec3.cross(&self, Vec3 v) {
	return Vec3.new(
		.x = self.y * v.z - self.z * v.y,
		.y = self.z * v.x - self.x * v.z,
		.z = self.x * v.y - self.y * v.x
	);
}
