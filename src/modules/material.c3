module modules::material;

import std::io;
import modules::hittable;
import modules::ray;
import modules::vec3;
import modules::color;
import modules::common;

fn double schlick_reflectance(double cosine, double ref_idx) {
    // Use Schlick's approximation for material reflectance
    double r0 = (1.0 - ref_idx) / (1.0 + ref_idx);
    r0 = r0 * r0;
    return r0 + (1.0 - r0) * common::pow(1.0 - cosine, 5);
}

// MATERIAL INTERFACE

interface Material {
    fn bool scatter(Ray* r_in, HitRecord* rec, Color* attenuation, Ray* scattered);
}

// DIFFUSE MATERIAL
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

// METAL MATERIAL
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

// GLASS MATERIAL
struct Dielectric (Material) {
    double ir;
}

fn bool Dielectric.scatter(&self, Ray* r_in, HitRecord* rec, Color* attenuation, Ray* scattered) @dynamic {
    double refraction_ratio = (rec.front_face) ? (1.0 / self.ir) : self.ir;

    // Vec3 unit_direction = r_in.direction().unit_vector();
    // Vec3 refracted = unit_direction.refract(rec.normal, refraction_ratio);
    // *attenuation = Color{1.0, 1.0, 1.0};
    // *scattered = Ray.new(.origin=rec.p, .direction=refracted);

    Vec3 unit_direction = r_in.direction().unit_vector();
	double dp = unit_direction.mul_scalar(-1.0).dot(rec.normal);
	double cos_theta = (dp < 1.0) ? dp : 1.0;
    double sin_theta = common::sqrt_double(1.0 - cos_theta * cos_theta);

    bool cannot_refract = (refraction_ratio * sin_theta) > 1.0;
    Vec3 direction = (cannot_refract || (schlick_reflectance(cos_theta, refraction_ratio) > common::random_double())) 
        ? unit_direction.reflect(rec.normal) 
        : unit_direction.refract(rec.normal, refraction_ratio);

    *attenuation = Color{1.0, 1.0, 1.0};
    *scattered = Ray.new(.origin=rec.p, .direction=direction);

    return true;
}

fn Dielectric Dielectric.new(Dielectric* self = null, double index_of_refraction) {
    return Dielectric{.ir = index_of_refraction};
}

