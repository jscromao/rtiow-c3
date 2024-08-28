module modules::material;

import std::io;
import modules::hittable;
import modules::ray;
import modules::vec3;
import modules::color;

interface Material {
    fn bool scatter(Ray* r_in, HitRecord* rec, Color* attenuation, Ray* scattered);
}

struct Lambertian (Material) {
    Color albedo;
}

fn bool Lambertian.scatter(Lambertian* self, Ray* r_in, HitRecord* rec, Color* attenuation, Ray* scattered) @dynamic {
    Vec3 scatter_direction = rec.normal.add_vec(Vec3.random_unit_vector());

    // Catch degenerate scatter direction
    if ( scatter_direction.near_zero() ) {
        scatter_direction = rec.normal;
    }

    *attenuation = self.albedo;
    *scattered = Ray.new(.origin=rec.p, .direction=scatter_direction);
    return true;
}

fn Lambertian Lambertian.new(Lambertian* self = null, Color alb) {
    return Lambertian{.albedo=alb};
}

struct Metal (Material) {
    Color albedo;
    double fuzz;
}

fn bool Metal.scatter(&self, Ray* r_in, HitRecord* rec, Color* attenuation, Ray* scattered) @dynamic {
    Vec3 uvec = r_in.direction().unit_vector();
    Vec3 reflected = uvec.reflect(rec.normal);

    *attenuation = self.albedo;
    *scattered = Ray.new(
        .origin = rec.p,
        .direction = reflected.add_vec(Vec3.random_in_unit_sphere().mul_scalar(self.fuzz))
    );
    double dp = scattered.direction().dot(rec.normal);
    return dp > 0.0;
}

fn Metal Metal.new(Metal* self = null, Color alb, double f) {
    return Metal{
        .albedo = alb,
        .fuzz = (f < 1.0) ? f : 1.0
    };
}