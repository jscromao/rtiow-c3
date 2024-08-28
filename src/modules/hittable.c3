module modules::hittable;

import modules::vec3;
import modules::point3;
import modules::ray;
import modules::material;
import std::collections::maybe;

interface Hittable {
    fn bool hit(Ray* ray, double t_min, double t_max, HitRecord* rec);
}

fault HitRecordErr {
    NO_MATERIAL
}

struct HitRecord {
    Point3 p;
    Vec3 normal;
    double t;
    bool front_face;
    //Material! mat;
    Maybe(<Material>) mat;
}

fn HitRecord HitRecord.new(HitRecord* self = null) {
    //return HitRecord{.mat = HitRecordErr.NO_MATERIAL};
    return HitRecord{};
}

fn Material! HitRecord.material(&self) {
    return self.mat.get();
}

fn void HitRecord.set_face_normal(&self, Ray* r, Vec3 outward_normal) {
    self.front_face = (r.direction().dot(outward_normal)) < 0.0;
    self.normal = (self.front_face) ? outward_normal : outward_normal.mul_scalar(-1.0);
}