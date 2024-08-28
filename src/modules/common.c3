module modules::common;

import std::math;

fn double sqrt(double value) {
    return math::sqrt(value);
}

def MY_PI = math::PI;
const DOUBLE_INFINITY = double.inf;
const double EPS = math::DOUBLE_EPSILON;

fn double sqrt_double(double value) {
    return math::sqrt(value);
}

fn double degrees_to_radians(double degrees) {
    return degrees * math::PI / 180.0;
}

fn double random_double() {
    return (double) math::random::rand(100) / 100.0;
}

fn double random_double_range(double min, double max) {
    // Return a random real in [min, max)
    return min + (max - min) * random_double();
}

fn double clamp(double x, double min, double max) {
    if (x < min) return min;
    if (x > max) return max;
    return x;
}

fn double abs(double val) {
    return (double) math::abs(val);
}