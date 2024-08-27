module modules::ray;
import modules::vec3;
import modules::point3;

struct Ray {
    Point3 orig;
    Vec3 dir;
}

fn Ray Ray.new(Ray* self = null, Point3 origin, Vec3 direction) {
    return Ray{
        .orig = origin,
        .dir = direction
    };
}

fn Point3 Ray.origin(&self) {
    return self.orig;
}

fn Vec3 Ray.direction(&self) {
    return self.dir;
}

fn Ray new(Point3 origin, Vec3 direction) {
    return Ray.new(.origin = origin, .direction = direction);
}

fn Point3 Ray.at(&self, double t) {
    return self.orig.add_vec(self.dir.mul_scalar(t));
}