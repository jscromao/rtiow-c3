module modules::sphere;

import modules::vec3;
import modules::point3;
import modules::hittable;
import modules::common;
import modules::ray;

struct Sphere (Hittable) {
    Point3 center;
    double radius;
}

fn Sphere Sphere.new(Sphere* self = null, Point3 cen, double r) {
    return Sphere{.center = cen, .radius = r};
}

fn bool Sphere.hit(Sphere* self, Ray* r, double t_min, double t_max, HitRecord* rec) @dynamic {
	Vec3 r_dir = r.direction();
	Vec3 oc = r.origin().sub_vec(self.center);
	double a = r_dir.length_squared();
	double half_b = oc.dot(r_dir);
	double c = oc.length_squared() - self.radius * self.radius;
	double discriminant = half_b * half_b - a * c;
	//return (discriminant < 0.0) ? -1.0 : (-half_b - common::sqrt(discriminant))/a;

    if (discriminant < 0.0) return false;

    double sqrt_d = common::sqrt(discriminant);

    // Find the nearest root that lies in the acceptable range
    double root = (-half_b - sqrt_d) / a;
    if ((root <= t_min) || (t_max <= root)) {
        root = (-half_b + sqrt_d) / a;
        if ((root <= t_min) || (t_max <= root)) {
            return false;
        }
    }

    rec.t = root;
    rec.p = r.at(rec.t);
    //rec.normal = rec.p.sub_vec(self.center).div_scalar(self.radius);
    Vec3 outward_normal = rec.p.sub_vec(self.center).div_scalar(self.radius);
    rec.set_face_normal(r, outward_normal);
    return true;
}