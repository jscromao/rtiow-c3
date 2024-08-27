module modules::color;
import modules::vec3;
import modules::common;
import std::io;

// in this project Color is an alias for Vec3
def Color = Vec3;

// fn void write_color(Color pixel_color) {
//     int r = (int)(255.999 * pixel_color.x);
//     int g = (int)(255.999 * pixel_color.y);
//     int b = (int)(255.999 * pixel_color.z);
//     io::printfn("%d %d %d", r, g, b);
// }

fn void write_color(Color pixel_color, int samples_per_pixel) {
    // Divide the color by the number of samples
    double scale = 1.0 / (double) samples_per_pixel;
    Color multed_color = pixel_color.mul_scalar(scale);
    Color scaled_color = Color{
        common::sqrt_double(multed_color.x),
        common::sqrt_double(multed_color.y),
        common::sqrt_double(multed_color.z)
    };

    int r = (int)(256.0 * common::clamp(scaled_color.x, 0.0, 0.999));
    int g = (int)(256.0 * common::clamp(scaled_color.y, 0.0, 0.999));
    int b = (int)(256.0 * common::clamp(scaled_color.z, 0.0, 0.999));
    io::printfn("%d %d %d", r, g, b);
}