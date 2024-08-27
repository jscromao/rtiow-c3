module modules::common;

import std::math;

fn double sqrt(double value) {
    return math::sqrt(value);
}

def MY_PI = math::PI;
const DOUBLE_INFINITY = double.inf;

fn double degrees_to_radians(double degrees) {
    return degrees * math::PI / 180.0;
}