module modules::vec3;
import std::math;
import modules::common;

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

fn Vec3 Vec3.random(Vec3* self = null) {
	return Vec3{common::random_double(), common::random_double(), common::random_double()};
}

fn Vec3 Vec3.random_range(Vec3* self = null, double min, double max) {
	return Vec3{
		common::random_double_range(min, max),
		common::random_double_range(min, max),
		common::random_double_range(min, max)
	};
}

fn Vec3 Vec3.random_in_unit_sphere(Vec3* self = null) {
	while (true) {
		Vec3 p = Vec3.random_range(.min = -1.0, .max = 1.0);
		if (p.length_squared() >= 1.0) {
			continue;
		}
		return p;
	}
}

fn Vec3 Vec3.random_unit_vector(Vec3* self = null) {
	return Vec3.random_in_unit_sphere(self).unit_vector();
}

fn Vec3 Vec3.reflect(&self, Vec3 n) {
	double dp = self.dot(n);
	return self.sub_vec(n.mul_scalar(2.0 * dp));
}

fn Vec3 Vec3.refract(&self, Vec3 n, double etai_over_etat) {
	double dp = self.mul_scalar(-1.0).dot(n);
	double cos_theta = (dp < 1.0) ? dp : 1.0;
	Vec3 r_out_perpendicular = self.add_vec(n.mul_scalar(cos_theta)).mul_scalar(etai_over_etat);
	double calcs = -1.0 * common::sqrt_double(common::abs(1.0 - r_out_perpendicular.length_squared()));
	Vec3 r_out_parallel = n.mul_scalar(calcs);
	return r_out_perpendicular.add_vec(r_out_parallel);
}

fn bool Vec3.near_zero(&self) {
	//const double EPS = 1.0e-8;
	double eps = common::EPS;
	// Return true if the vec is close to zero in all dimensions
	return (common::abs(self.x) < eps) && (common::abs(self.y) < eps) && (common::abs(self.z) < eps);
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
