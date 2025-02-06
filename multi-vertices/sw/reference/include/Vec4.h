#ifndef VEC3_H
#define VEC3_H

#include "Vec3.h"

class Vec4 {
    public:
        float vec[4];


        Vec4() {
            for (int i = 0; i < 4; i++) {
                vec[i] = float(0);
            }
        }

        Vec4(Vec3 ref) {
            for (int i = 0; i < 3; i++) {
                vec[i] = ref.vec[i];
            }
            vec[3] = float(1);
        }

        void print(const char* name) {
            printf("Vector: %s\n", name);
            for (int i = 0; i < 4; i++) {
                printf("%f ", vec[i]);
            }

            printf("\n");
        }

        void normalize_to_z() {
            for (int i = 0; i < 4; i++) {
                vec[i] /= vec[3];
            }
        }
};
#endif
