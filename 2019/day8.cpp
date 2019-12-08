// g++ day8.cpp && ./a.out && rm a.out

#include <iostream>
#include <fstream>
#include <vector>

#define HEIGHT 25
#define WIDTH 6

std::vector<std::vector<int> > input_to_layers() {
    std::ifstream input("res/day8.txt");
    std::vector<std::vector<int> > layers;
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

std::vector<int> min_layer(std::vector<std::vector<int> >& layers) {
    std::vector<int> res = layers[0];

    for (int i = 0; i < layers.size(); i++) {
        if (count(layers[i], '0') < count(res, '0')) res = layers[i];
    }

    return res;
}

int main() {
    std::vector<std::vector<int> > layers = input_to_layers();
    std::vector<int> layer = min_layer(layers);

    int result = count(layer, '1') * count(layer, '2');

    std::cout << result << "\n";

    return 0;
}
