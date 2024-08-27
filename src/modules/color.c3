module modules::color;
import modules::vec3;
import std::io;

// in this project Color is an alias for Vec3
def Color = Vec3;

fn void write_color(Color pixel_color) {
    int r = (int)(255.999 * pixel_color.x);
    int g = (int)(255.999 * pixel_color.y);
    int b = (int)(255.999 * pixel_color.z);
    io::printfn("%d %d %d", r, g, b);
}