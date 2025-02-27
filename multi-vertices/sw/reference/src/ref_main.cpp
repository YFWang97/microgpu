#include <iostream>
#include <cmath>
#include <fstream>
#include <string>
#include <vector>
#include <cstring>

#ifdef SDL
#include <SDL2/SDL.h>
#include <SDL2/SDL_render.h>
#define SDL_ERROR_MSG(...) cout << __VA_ARGS__ << "! " << "SDL_Error: " << SDL_GetError() << endl
#endif

using namespace std;

#define PI 3.14159265
#define SCREEN_WIDTH 640.0
#define SCREEN_HEIGHT 480.0

#define MIN(a, b) (((a) < (b)) ? (a) : (b))
#define MAX(a, b) (((a) > (b)) ? (a) : (b))

#ifdef SDL
SDL_Window* gWindow;
SDL_Renderer* gRenderer;
#endif

class Vec {
    public:
        int size;
        vector<float> vec;

        Vec(int size_) : size(size_), vec(size_) {
            for (int i = 0; i < size_; i++) {
                vec[i] = float(0);
            }
        }

        Vec(const Vec& ref) : size(ref.size), vec(ref.size){
            for (int i = 0; i < ref.size; i++) {
                vec[i] = ref.vec[i];
            }
        }

        float dot(const Vec& rhs) {
            float ret = 0;

            for (int i = 0; i < size; i++) {
                ret += vec[i] * rhs.vec[i];
            }
            return ret;
        }

        void normalize() {
            float length = 0;
            for (int i = 0; i < size; i++) {
                length += vec[i] * vec[i];
            }

            length = sqrtf(length);

            for (int i = 0; i < size; i++) {
                vec[i] /= length;
            }
        }

        void print(const char* name) {
            printf("Vector %d: %s\n", size, name);
            for (int i = 0; i < size; i++) {
                printf("%f ", vec[i]);
            }
            printf("\n");
        }
};

class Vec3 : public Vec {
    public:
        Vec3() : Vec(3) {}

        Vec3 operator-(const Vec3& rhs) {
            Vec3 ret;
            for (int i = 0; i < size; i++) {
                //printf("%d\n", i);
                ret.vec[i] = vec[i] - rhs.vec[i];
            }
            return ret;
        }

        Vec3 cross(Vec3 rhs) {
            Vec3 ret;

            ret.vec[0] = vec[1] * rhs.vec[2] - vec[2] * rhs.vec[1];
            ret.vec[1] = vec[2] * rhs.vec[0] - vec[0] * rhs.vec[2];
            ret.vec[2] = vec[0] * rhs.vec[1] - vec[1] * rhs.vec[0];
            return ret;
        }
};


class Vec4 : public Vec {
    public:
        Vec4() : Vec(4) {}

        Vec4(const Vec3& ref) : Vec(4) {
            for (int i = 0; i < 3; i++) {
                vec[i] = ref.vec[i];
            }
            vec[3] = float(1);
        }
        
        void normalize_to_z() {
            for (int i = 0; i < 4; i++) {
                vec[i] /= vec[3];
            }
        }
};

class Vec2 : public Vec {
    public:
        Vec2() : Vec(2) {}

        Vec2 operator-(const Vec2& rhs) {
            Vec2 ret;
            for (int i = 0; i < size; i++) {
                ret.vec[i] = vec[i] - rhs.vec[i];
            }
            return ret;
        }

        Vec2(Vec4 ref) : Vec2() {
            vec[0] = ref.vec[0];
            vec[1] = ref.vec[1];
        }

#ifdef SDL
        void render() {
            for (int i = -5; i < 5; i++) {
                for (int j = -5; j < 5; j++) {
                    SDL_RenderDrawPoint(gRenderer, i + vec[0], j + vec[1]);
                } 
            }
        }
#endif

        int cross(Vec2 rhs) {
            int ret;
            ret = vec[0] * rhs.vec[1] - vec[1] * rhs.vec[0];
            return ret;
        }

        void round() {
            vec[0] = int(vec[0]);
            vec[1] = int(vec[1]);
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

class Mat3 {

    public:

        float mat[3][3];

        Mat3() {
            for (int i = 0; i < 3; i++) {
                for (int j = 0; j < 3; j++) {
                    mat[i][j] = float(0);
                }
            }
        }

        Vec3 dot(Vec3 rhs) {
            Vec3 ret;
            for (int i = 0; i < 3; i++) {
                float accumulation = 0.0;
                for (int j = 0; j < 3; j++) {
                    accumulation += mat[i][j] * rhs.vec[j];
                }
                ret.vec[i] = accumulation;
            }
            return ret;
        }

        void print(const char* name) {
            printf("Matrix 3x3: %s\n", name);
            for (int i = 0; i < 3; i++) {
                for (int j = 0; j < 3; j++) {
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
Vec2* result_vertex_buffer;

int* index_buffer;
int* valid_buffer;

void assembler();

void vertex_shader();

void rasterizer();

bool is_top_left(Vec2 edge) {
    bool is_top_edge = edge.vec[1] == 0 && edge.vec[0] > 0;
    bool is_left_edge = edge.vec[1] < 0;

    return is_left_edge || is_top_edge;
}

#ifdef SDL
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
#endif


int main (void) {

    char color_r[8] = {0xF0, 0xFF, 0xFF, 0xFF, 0x00, 0x00, 0x00, 0x00};
    char color_g[8] = {0xF0, 0xFF, 0x00, 0x00, 0xFF, 0xFF, 0x00, 0x00};
    char color_b[8] = {0xF0, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00};

    const float fovy = 45.0;
    const float n = 1.0;
    const float f = 50.0;

    //const float aspect = 640.0/480.0;
    const float aspect = SCREEN_WIDTH / SCREEN_HEIGHT;

    float rot_x, rot_y, rot_z;

    rot_x = 0;
    rot_y = 0;
    rot_z = 0;

    Mat3 mat_rotation_x_object;
    Mat3 mat_rotation_y_object;
    Mat3 mat_rotation_z_object;

    mat_rotation_z_object.mat[0][0] = cos(rot_z * PI / 180.0); 
    mat_rotation_z_object.mat[0][1] = -sin(rot_z * PI / 180.0); 
    mat_rotation_z_object.mat[1][0] = sin(rot_z * PI / 180.0); 
    mat_rotation_z_object.mat[1][1] = cos(rot_z * PI / 180.0); 
    mat_rotation_z_object.mat[2][2] = float(1);

    mat_rotation_y_object.mat[0][0] = cos(rot_y * PI / 180.0); 
    mat_rotation_y_object.mat[0][2] = sin(rot_y * PI / 180.0); 
    mat_rotation_y_object.mat[1][1] = float(1);
    mat_rotation_y_object.mat[2][0] = -sin(rot_y * PI / 180.0); 
    mat_rotation_y_object.mat[2][2] = cos(rot_y * PI / 180.0); 

    mat_rotation_x_object.mat[0][0] = float(1);
    mat_rotation_x_object.mat[1][1] = cos(rot_x * PI / 180.0); 
    mat_rotation_x_object.mat[1][2] = -sin(rot_x * PI / 180.0); 
    mat_rotation_x_object.mat[2][1] = sin(rot_x * PI / 180.0); 
    mat_rotation_x_object.mat[2][2] = cos(rot_x * PI / 180.0); 

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

    vertex_buffer = new Vec3[8];

    ifstream vertices_file("./model/vertices.txt");

    int vertex_index = 0;

    if (!vertices_file) {
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

    if (!index_file) {
        printf("Error: Unable to find model index file\n");
        return -1;
    }

    int index_cnt = 0;

    while (!index_file.eof()) {
        index_file >> index_buffer[index_cnt++];
    }

    vertices_file.close();
    index_file.close();

    vertex_vec4_buffer = new Vec4[8];

    vertex_world_buffer = new Vec3[8];

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


    result_vertex_buffer = new Vec2[8];

    string temp;

    for (int i = 0; i < 8; i++) {
        Vec3 vertex_vec3;
        vertex_vec3 = mat_rotation_x_object.dot(vertex_buffer[i]);
        vertex_vec3 = mat_rotation_y_object.dot(vertex_vec3);
        vertex_vec3 = mat_rotation_z_object.dot(vertex_vec3);

        vertex_vec3.print("1");

        vertex_vec4_buffer[i] = mat_translation_world.dot(Vec4(vertex_vec3));
        vertex_vec4_buffer[i].print("2");
        vertex_vec4_buffer[i] = mat_translation_view.dot(vertex_vec4_buffer[i]);
        vertex_vec4_buffer[i].print("3");

        //temp = "after_view_translation " + to_string(i);
        //vertex_vec4_buffer[i].print(temp.c_str());

        vertex_vec4_buffer[i] = mat_rotation_view.dot(vertex_vec4_buffer[i]);
        vertex_vec4_buffer[i].print("4");

        //temp = "after_view_rotation " + to_string(i);
        //vertex_vec4_buffer[i].print(temp.c_str());

        vertex_world_buffer[i].vec[0] = vertex_vec4_buffer[i].vec[0]; 
        vertex_world_buffer[i].vec[1] = vertex_vec4_buffer[i].vec[1]; 
        vertex_world_buffer[i].vec[2] = vertex_vec4_buffer[i].vec[2]; 

        vertex_vec4_buffer[i] = mat_persp.dot(vertex_vec4_buffer[i]);
        vertex_vec4_buffer[i].print("5");

        //temp = "after_perspective " + to_string(i);
        //vertex_vec4_buffer[i].print(temp.c_str());

        vertex_vec4_buffer[i].normalize_to_z();
        vertex_vec4_buffer[i].print("6");

        vertex_vec4_buffer[i] = mat_viewpoint.dot(vertex_vec4_buffer[i]);
        vertex_vec4_buffer[i].print("7");

        //temp = "after_viewpoint " + to_string(i);
        //vertex_vec4_buffer[i].print(temp.c_str());

        Vec2 result(vertex_vec4_buffer[i]);
        result.print("8");

        result_vertex_buffer[i] = result;
        result_vertex_buffer[i].round();
    }     

    valid_buffer = (int*) malloc(12 * sizeof(int));

    for (int i = 0; i < 12; i++) {
        Vec3 vec01 = vertex_world_buffer[index_buffer[3 * i + 1]] - vertex_world_buffer[index_buffer[3 * i]];
        Vec3 vec02 = vertex_world_buffer[index_buffer[3 * i + 2]] - vertex_world_buffer[index_buffer[3 * i]];

        Vec3 norm = vec01.cross(vec02);
        float camera_dir_dot_surface_norm = norm.dot(vertex_world_buffer[index_buffer[3 * i]]);

        valid_buffer[i] = (camera_dir_dot_surface_norm < 0.0);
        printf("Debug: Tri %d is %d\n", i, valid_buffer[i]);
    }

    char frame_buffer[640*480][3];

    memset(frame_buffer, 0xFF, 640*480*3); 

    int w0[12];
    int w1[12];
    int w2[12];

    int w0_row[12];
    int w1_row[12];
    int w2_row[12];

    int delta_w0_row[12];
    int delta_w1_row[12];
    int delta_w2_row[12];

    int delta_w0_col[12];
    int delta_w1_col[12];
    int delta_w2_col[12];

    for (int row = 0; row < 480; row++) {
        for (int col = 0; col < 640; col++) {
            for (int i = 0; i < 12; i++) {
                if (row == 0 && col == 0) {
                    Vec2 v0(result_vertex_buffer[index_buffer[3 * i]]);
                    Vec2 v1(result_vertex_buffer[index_buffer[3 * i + 1]]);
                    Vec2 v2(result_vertex_buffer[index_buffer[3 * i + 2]]);

                    Vec2 edge_w0, edge_w1, edge_w2;

                    edge_w0 = v2 - v1;
                    edge_w1 = v0 - v2;
                    edge_w2 = v1 - v0;

                    // Compute the constant delta_s that will be used for the horizontal and vertical steps
                    delta_w0_col[i] = -edge_w0.vec[1];
                    delta_w1_col[i] = -edge_w1.vec[1];
                    delta_w2_col[i] = -edge_w2.vec[1];
                    delta_w0_row[i] = edge_w0.vec[0];
                    delta_w1_row[i] = edge_w1.vec[0];
                    delta_w2_row[i] = edge_w2.vec[0];

                    //// Rasterization fill rule, not 100% precise due to floating point innacuracy
                    //float bias0 = is_top_left(edge_w0) ? 0 : -0.0001;
                    //float bias1 = is_top_left(edge_w1) ? 0 : -0.0001;
                    //float bias2 = is_top_left(edge_w2) ? 0 : -0.0001;

                    // Compute the edge functions for the fist (top-left) point
                    Vec2 p0;
                    p0.vec[0] = float(0);
                    p0.vec[1] = float(0);

                    w0_row[i] = edge_w0.cross(p0-v1);
                    w1_row[i] = edge_w1.cross(p0-v2);
                    w2_row[i] = edge_w2.cross(p0-v0);
                }

                if (col == 0) {
                    w0[i] = w0_row[i];
                    w1[i] = w1_row[i];
                    w2[i] = w2_row[i];
                } else {
                    w0[i] += delta_w0_col[i];
                    w1[i] += delta_w1_col[i];
                    w2[i] += delta_w2_col[i];
                }

                if (col == 639) {
                    w0_row[i] += delta_w0_row[i];
                    w1_row[i] += delta_w1_row[i];
                    w2_row[i] += delta_w2_row[i];
                }

                bool is_inside = (w0[i] < 0 && w1[i] < 0 && w2[i] < 0);

                if (is_inside && valid_buffer[i]) {
                    frame_buffer[col + row * 640][0] = color_r[i];
                    frame_buffer[col + row * 640][1] = color_g[i];
                    frame_buffer[col + row * 640][2] = color_b[i];
                }
            }
        }
    }

#ifdef SDL
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

        for (int y = 0; y < 480; y++) {
            for (int x = 0; x < 640; x++) {
                SDL_SetRenderDrawColor(gRenderer, frame_buffer[x + y * 640][0], frame_buffer[x + y * 640][1], frame_buffer[x + y * 640][2], 0xFF);
                SDL_RenderDrawPoint(gRenderer, x, y);
            }
        }


        for (int i = 0; i < 8; i++) {
            SDL_SetRenderDrawColor(gRenderer, color_r[i], color_g[i], color_b[i], 0xFF);
            result_vertex_buffer[i].render();
        }

        SDL_SetRenderDrawColor(gRenderer, 0xFF, 0xFF, 0xFF, 0xFF);

        SDL_RenderPresent(gRenderer);
    }
#endif
}
