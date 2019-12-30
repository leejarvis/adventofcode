// clang++ -std=c++11 day08.cpp && ./a.out && rm a.out

#include <iostream>
#include <fstream>
#include <vector>

#define HEIGHT 25
#define WIDTH 6

using Layers = std::vector<std::vector<int> >;

Layers input_to_layers() {
    std::ifstream input("res/day8.txt");
    Layers layers;
    char c;

    while (!input.eof()) {
        std::vector<int> layer;

        for (int i = 0; i < HEIGHT * WIDTH; i++) {
            input >> c;
            layer.push_back(c);
        }

        layers.push_back(layer);
    }

    layers.pop_back();

    input.close();

    return layers;
}

int count(std::vector<int>& layer, char c) {
    int res = 0;
    for (int i = 0; i < layer.size(); i++) {
        if (layer[i] == c) res++;
    }
    return res;
}

std::vector<int> min_layer(Layers& layers) {
    std::vector<int> res = layers[0];

    for (int i = 0; i < layers.size(); i++) {
        if (count(layers[i], '0') < count(res, '0')) res = layers[i];
    }

    return res;
}

std::vector<int> decode(Layers& layers) {
    std::vector<int> out;

    for (int i = layers.size() - 1; i >= 0; i--) {
        for (int j = 0; j < out.size(); j++) {
            int p = layers[i][j];

            if (p != 2) {
                out[j] = p;
            }
        }
    }

    return out;
}

void print(std::vector<int> image) {
    for (int i = 0; i < HEIGHT; i++) {
        for (int j = 0; j < WIDTH; j++) {
            int p = image[i * WIDTH + j];

            if (p == 0) {
                std::cout << " ";
            } else {
                std::cout << "X";
            }

            std::cout << "\n";
        }
    }
}

int main() {
    Layers layers = input_to_layers();
    std::vector<int> layer = min_layer(layers);

    int checksum = count(layer, '1') * count(layer, '2');
    std::cout << checksum << "\n";

    print(decode(layers));

    return 0;
}
