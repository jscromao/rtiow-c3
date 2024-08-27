module modules::camera;

import modules::vec3;
import modules::point3;
import modules::ray;

const double ASPECT_RATIO = 16.0 / 9.0;
const IMAGE_WIDTH = 400i32;
const int IMAGE_HEIGHT = (int)((double)IMAGE_WIDTH / ASPECT_RATIO);

struct Camera {
    Point3 origin;
    Point3 lower_left_corner;
    Vec3 horizontal;
    Vec3 vertical;
}

fn Camera Camera.new(Camera* self = null) {
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

    return Camera{
        .origin = origin,
        .lower_left_corner = lower_left_corner,
        .horizontal = horizontal,
        .vertical = vertical
    };
}

fn Ray Camera.get_ray(&self, double u, double v) {
    return Ray.new(
        .origin = self.origin,
        .direction = self.lower_left_corner.add_vec(self.horizontal.mul_scalar(u)).add_vec(self.vertical.mul_scalar(v)).sub_vec(self.origin)
    );
}