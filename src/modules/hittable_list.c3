module modules::hittable_list;

import modules::vec3;
import modules::point3;
import modules::ray;
import modules::hittable;
import std::collections::list;

struct HittableList (Hittable) {
    List(<Hittable>) objects;
}

fn HittableList HittableList.new(HittableList* self = null) {
    HittableList hl = HittableList{};
    hl.objects.new_init();
    return hl;
}

fn void HittableList.add(&self, Hittable object) {
    self.objects.push(object);
}

fn bool HittableList.hit(HittableList* self, Ray* r, double t_min, double t_max, HitRecord* rec) @dynamic {
    HitRecord temp_rec;
    bool hit_anything = false;
    double closest_so_far = t_max;

    foreach (&object : self.objects) {
        if (object.hit(r, t_min, closest_so_far, &temp_rec)) {
            hit_anything = true;
            closest_so_far = temp_rec.t;
            *rec = temp_rec;
        }
    }

    return hit_anything;
}