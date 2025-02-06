#include <iostream>
#include <cmath>
#include <fstream>
#include <string>

#include <SDL2/SDL.h>
#include <SDL2/SDL_render.h>

using namespace std;

#define PI 3.14159265
#define SCREEN_WIDTH 640.0
#define SCREEN_HEIGHT 480.0

#define SDL_ERROR_MSG(...) cout << __VA_ARGS__ << "! " << "SDL_Error: " << SDL_GetError() << endl

SDL_Window* gWindow;
SDL_Renderer* gRenderer;

class Vec3 {
    public:
        float vec[3];

        Vec3() {
            for (int i = 0; i < 3; i++) {
                vec[i] = float(0);
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

class Vec2 {
    public:
        float vec[2];

        Vec2(Vec4 ref) {
            vec[0] = ref.vec[0];
            vec[1] = ref.vec[1];
        }

        void print(const char* name) {
            printf("Vector: %s\n", name);
            for (int i = 0; i < 2; i++) {
                printf("%f ", vec[i]);
            }

            printf("\n");
        }

        void render() {
            for (int i = -5; i < 5; i++) {
                for (int j = -5; j < 5; j++) {
                    SDL_RenderDrawPoint(gRenderer, i + vec[0], j + vec[1]);
                } 
            }
        }
};


class Mat4 {

    public:

        float mat[4][4];

        Mat4() {
            for (int i = 0; i < 4; i++) {
                for (int j = 0; j < 4; j++) {
                    mat[i][j] = float(0);
                }
            }
        }

        Vec4 dot(Vec4 rhs) {
            Vec4 ret;
            for (int i = 0; i < 4; i++) {
                float accumulation = 0.0;
                for (int j = 0; j < 4; j++) {
                    accumulation += mat[i][j] * rhs.vec[j];
                }
                ret.vec[i] = accumulation;
            }
            return ret;
        }

        void print(const char* name) {
            printf("Matrix 4x4: %s\n", name);
            for (int i = 0; i < 4; i++) {
                for (int j = 0; j < 4; j++) {
                    printf("%f ", mat[i][j]);
                }
                printf("\n");
            }
            printf("\n");
        }
};




Vec3* vertex_buffer;
Vec4* vertex_vec4_buffer;
Vec3* vertex_world_buffer;
Vec2* result_vetex_buffer;

int* index_buffer;
int* valid_buffer;

void assembler();

void vertex_shader();

void rasterizer();

int initialize_sdl() {
    if(SDL_Init(SDL_INIT_VIDEO) < 0) {
        SDL_ERROR_MSG("SDL: Failed to initialize");
        return -1;
    }

    gWindow = SDL_CreateWindow("3D Graphics", SDL_WINDOWPOS_UNDEFINED, SDL_WINDOWPOS_UNDEFINED, SCREEN_WIDTH, SCREEN_HEIGHT, SDL_WINDOW_SHOWN);

    if (gWindow == NULL) {
        SDL_ERROR_MSG("SDL: Failed to create window");
        return -1;	
    } 

    // Get the current display attributes 
    SDL_DisplayMode current;

    SDL_GetCurrentDisplayMode(0, &current);

    gRenderer = SDL_CreateRenderer(gWindow, -1, SDL_RENDERER_ACCELERATED);
    //gRenderer = SDL_CreateRenderer(gWindow, -1, SDL_RENDERER_ACCELERATED | SDL_RENDERER_PRESENTVSYNC);

    if (gRenderer == NULL) {
        SDL_ERROR_MSG("SDL: Failed to create renderer");
        return -1;
    }

    SDL_SetRenderDrawColor(gRenderer, 0xFF, 0xFF, 0xFF, 0x00);

    return 0;
}

int main (void) {

    const float fovy = 45.0;
    const float n = 1.0;
    const float f = 50.0;

    //const float aspect = 640.0/480.0;
    const float aspect = SCREEN_WIDTH / SCREEN_HEIGHT;

    float l, r, b, t;

    t = tan(fovy / 2 * PI / 180.0) * n;
    b = -t;

    l = b * aspect;
    r = -l;

    printf("%f %f %f %f\n", l, r, b, t);

    Mat4 mat_persp;

    mat_persp.mat[0][0] = 2.0 * n / (r - l);
    mat_persp.mat[1][1] = 2.0 * n / (t - b);
    mat_persp.mat[2][2] = (n + f) / (n - f);
    mat_persp.mat[2][3] = 2.0 * n * f / (n - f);
    mat_persp.mat[3][2] = float(-1);

    mat_persp.print("Perspective Transformation");

    Vec3 camera_coord;
    Vec3 camera_g;
    Vec3 camera_t;

    camera_coord.vec[0] = 5;
    camera_coord.vec[1] = 2;
    camera_coord.vec[2] = 0;

    camera_g.vec[0] = -4;
    camera_g.vec[1] = 0;
    camera_g.vec[2] = -9;

    camera_t.vec[0] = 0;
    camera_t.vec[1] = 1;
    camera_t.vec[2] = 0;

    camera_g.normalize();
    camera_t.normalize();

    Vec3 camera_g_x_t = camera_g.cross(camera_t);

    camera_g_x_t.print("Camera g cross t");

    Mat4 mat_translation_view;
    mat_translation_view.mat[0][0] = float(1);
    mat_translation_view.mat[1][1] = float(1);
    mat_translation_view.mat[2][2] = float(1);
    mat_translation_view.mat[3][3] = float(1);
    mat_translation_view.mat[0][3] = -(camera_coord.vec[0]);
    mat_translation_view.mat[1][3] = -(camera_coord.vec[1]);
    mat_translation_view.mat[2][3] = -(camera_coord.vec[2]);

    Mat4 mat_rotation_view;
    mat_rotation_view.mat[0][0] = camera_g_x_t.vec[0];
    mat_rotation_view.mat[0][1] = camera_g_x_t.vec[1];
    mat_rotation_view.mat[0][2] = camera_g_x_t.vec[2];
    mat_rotation_view.mat[1][0] = camera_t.vec[0];
    mat_rotation_view.mat[1][1] = camera_t.vec[1];
    mat_rotation_view.mat[1][2] = camera_t.vec[2];
    mat_rotation_view.mat[2][0] = -camera_g.vec[0];
    mat_rotation_view.mat[2][1] = -camera_g.vec[1];
    mat_rotation_view.mat[2][2] = -camera_g.vec[2];
    mat_rotation_view.mat[3][3] = float(1);

    vertex_buffer = (Vec3*) malloc(8 * sizeof(Vec3));

    ifstream vertices_file("./model/vertices.txt");

    int vertex_index = 0;

    if (!vertices_file.is_open()) {
        printf("Error: Unable to find model vertex file\n");
        return -1;
    }

    while (!vertices_file.eof()) {
        for (int i = 0; i < 3; i++) {
            vertices_file >> vertex_buffer[vertex_index].vec[i]; 
        }
        vertex_index++;
    }

    index_buffer = (int*) malloc(12 * 3 * sizeof(int)); 
    
    //132
    //031
    //126
    //165
    //567
    //574
    //236
    //376
    //073
    //047
    //051
    //054
    ifstream index_file("./model/index.txt");

    if (!index_file.is_open()) {
        printf("Error: Unable to find model index file\n");
        return -1;
    }

    int index_cnt = 0;
    
    while (!index_file.eof()) {
        index_file >> index_buffer[index_cnt++];
    }

    vertex_vec4_buffer = (Vec4*) malloc(8 * sizeof(Vec4));

    vertex_world_buffer = (Vec3*) malloc(8 * sizeof(Vec3));

    Mat4 mat_translation_world;
    mat_translation_world.mat[0][0] = float(1);
    mat_translation_world.mat[1][1] = float(1);
    mat_translation_world.mat[2][2] = float(1);
    mat_translation_world.mat[3][3] = float(1);
    mat_translation_world.mat[2][3] = -10.0;

    Mat4 mat_viewpoint;
    mat_viewpoint.mat[0][0] = SCREEN_WIDTH / 2.0;
    mat_viewpoint.mat[0][3] = (SCREEN_WIDTH - 1.0) / 2.0;
    //This is inverted as SDL coordinate system has Y-Axis points downward
    mat_viewpoint.mat[1][1] = -SCREEN_HEIGHT / 2.0;
    mat_viewpoint.mat[1][3] = (SCREEN_HEIGHT - 1.0) / 2.0;


    result_vetex_buffer = (Vec2*) malloc(8 * sizeof(Vec2));

    string temp;

    for (int i = 0; i < 8; i++) {
        vertex_vec4_buffer[i] = mat_translation_world.dot(Vec4(vertex_buffer[i]));

        vertex_vec4_buffer[i] = mat_translation_view.dot(vertex_vec4_buffer[i]);

        //temp = "after_view_translation " + to_string(i);
        //vertex_vec4_buffer[i].print(temp.c_str());
        
        vertex_vec4_buffer[i] = mat_rotation_view.dot(vertex_vec4_buffer[i]);

        //temp = "after_view_rotation " + to_string(i);
        //vertex_vec4_buffer[i].print(temp.c_str());

        vertex_world_buffer[i].vec[0] = vertex_vec4_buffer[i].vec[0]; 
        vertex_world_buffer[i].vec[1] = vertex_vec4_buffer[i].vec[1]; 
        vertex_world_buffer[i].vec[2] = vertex_vec4_buffer[i].vec[2]; 

        vertex_vec4_buffer[i] = mat_persp.dot(vertex_vec4_buffer[i]);

        //temp = "after_perspective " + to_string(i);
        //vertex_vec4_buffer[i].print(temp.c_str());

        vertex_vec4_buffer[i].normalize_to_z();

        vertex_vec4_buffer[i] = mat_viewpoint.dot(vertex_vec4_buffer[i]);

        //temp = "after_viewpoint " + to_string(i);
        //vertex_vec4_buffer[i].print(temp.c_str());

        Vec2 result(vertex_vec4_buffer[i]);

        result_vetex_buffer[i] = result;
    }     

    valid_buffer = (int*) malloc(12 * sizeof(int));

    for (int i = 0; i < 12; i++) {
        valid_buffer[i] = 1;
    }

    for (int i = 0; i < 12; i++) {
        Vec3 vec01 = vertex_world_buffer[index_buffer[3 * i + 1]] - vertex_world_buffer[index_buffer[3 * i]];
        Vec3 vec02 = vertex_world_buffer[index_buffer[3 * i + 2]] - vertex_world_buffer[index_buffer[3 * i]];

        Vec3 norm = vec01.cross(vec02);
        float camera_dir_dot_surface_norm = norm.dot(vertex_world_buffer[index_buffer[3 * i]]);

        valid_buffer[i] = (camera_dir_dot_surface_norm < 0.0);
        printf("Debug: Tri %d is %d\n", i, valid_buffer[i]);
    }


    initialize_sdl();

    SDL_Event event;

    bool quit = 0;

    while (!quit) {
        if (SDL_PollEvent(&event)) {
            if (event.type == SDL_QUIT) {
                quit = 1;
            } else {
                if (event.type == SDL_KEYDOWN) {
                    switch(event.key.keysym.sym) {
                        case SDLK_DOWN:
                            
                            break;
                    }
                }
            }
        }
        SDL_RenderClear(gRenderer);

        char r[8] = {0xF0, 0xFF, 0xFF, 0xFF, 0x00, 0x00, 0x00, 0x00};
        char g[8] = {0xF0, 0xFF, 0x00, 0x00, 0xFF, 0xFF, 0x00, 0x00};
        char b[8] = {0xF0, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00};

        for (int i = 0; i < 8; i++) {
            SDL_SetRenderDrawColor(gRenderer, r[i], g[i], b[i], 0xFF);
            result_vetex_buffer[i].render();

        }

        SDL_SetRenderDrawColor(gRenderer, 0xFF, 0xFF, 0xFF, 0xFF);


        SDL_RenderPresent(gRenderer);
    }
}
