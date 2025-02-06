#ifndef VEC4_H
#define VEC4_H

#include "Vec4.h"

class Vec3 {
    public:
        float vec[3];

        Vec3() {
            for (int i = 0; i < 3; i++) {
                vec[i] = float(0);
            }
        }

        Vec3(Vec4 ref) {
            for (int i = 0; i < 3; i++) {
                vec[i] = ref.vec[i];
            }
        }

        Vec3 cross(Vec3 rhs) {
            Vec3 ret;

            ret.vec[0] = vec[1] * rhs.vec[2] - vec[2] * rhs.vec[1];
            ret.vec[1] = vec[2] * rhs.vec[0] - vec[0] * rhs.vec[2];
            ret.vec[2] = vec[0] * rhs.vec[1] - vec[1] * rhs.vec[0];
            return ret;
        }

        float dot(Vec3 rhs) {
            float ret = 0.0;

            for (int i = 0; i < 3; i++) {
                ret += vec[i] * rhs.vec[i];
            }

            return ret;
        }

        Vec3 operator-(const Vec3& rhs) {
            Vec3 ret;
            ret.vec[0] = vec[0] - rhs.vec[0];
            ret.vec[1] = vec[1] - rhs.vec[1];
            ret.vec[2] = vec[2] - rhs.vec[2];
            return ret;
        }

        void normalize() {
            float length = sqrtf(vec[0] * vec[0] + vec[1] * vec[1] + vec[2] * vec[2]);

            vec[0] /= length;
            vec[1] /= length;
            vec[2] /= length;
        }

        void print(const char* name) {
            printf("Vector: %s\n", name);
            for (int i = 0; i < 3; i++) {
                printf("%f ", vec[i]);
            }

            printf("\n");
        }
};

#endif
