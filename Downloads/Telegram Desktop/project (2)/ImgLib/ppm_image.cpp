#include "ppm_image.h"

#include <cstddef>
#include <fstream>
#include <iostream>
#include <string_view>

using namespace std;

namespace img_lib {

static const string_view PPM_SIG = "P6"sv;
static const int PPM_MAX = 255;

// реализуем функцию SavePPM
bool SavePPM(const Path& file, const Image& image) {
    ofstream ofs(file, std::ios::binary);
    if (!ofs) {
        return false;
    }

    // записываем заголовок PPM
    ofs << "P6\n";
    ofs << image.GetWidth() << ' ' << image.GetHeight() << '\n';
    ofs << "255\n";

    // проверяем, что заголовок записался корректно
    if (!ofs) {
        return false;
    }

    // создаем временный буфер для хранения строки перед записью
    // размером в три ширины изображения (R, G, B компоненты)
    std::vector<char> buff(image.GetWidth() * 3);

    // записываем данные изображения построчно
    for (int y = 0; y < image.GetHeight(); ++y) {
        const Color* line = image.GetLine(y);
        // конвертируем компоненты цвета из byte в char
        for (int x = 0; x < image.GetWidth(); ++x) {
            buff[x * 3 + 0] = static_cast<char>(line[x].r);
            buff[x * 3 + 1] = static_cast<char>(line[x].g);
            buff[x * 3 + 2] = static_cast<char>(line[x].b);
        }

        // записываем всю строку целиком
        ofs.write(buff.data(), image.GetWidth() * 3);
        
        if (!ofs) {
            return false;
        }
    }

    return true;
}

Image LoadPPM(const Path& file) {
    // открываем поток с флагом ios::binary
    // поскольку будем читать даные в двоичном формате
    ifstream ifs(file, ios::binary);
    std::string sign;
    int w, h, color_max;

    // читаем заголовок: он содержит формат, размеры изображения
    // и максимальное значение цвета
    ifs >> sign >> w >> h >> color_max;

    // мы поддерживаем изображения только формата P6
    // с максимальным значением цвета 255
    if (sign != PPM_SIG || color_max != PPM_MAX) {
        return {};
    }

    // пропускаем один байт - это конец строки
    const char next = ifs.get();
    if (next != '\n') {
        return {};
    }

    Image result(w, h, Color::Black());
    std::vector<char> buff(w * 3);

    for (int y = 0; y < h; ++y) {
        Color* line = result.GetLine(y);
        ifs.read(buff.data(), w * 3);

        for (int x = 0; x < w; ++x) {
            line[x].r = static_cast<std::byte>(buff[x * 3 + 0]);
            line[x].g = static_cast<std::byte>(buff[x * 3 + 1]);
            line[x].b = static_cast<std::byte>(buff[x * 3 + 2]);
        }
    }

    return result;
}

void NegateInplace(Image& image) {
    std::cout << "Начинаю инвертирование изображения..." << std::endl;
    std::cout << "Размер: " << image.GetWidth() << "x" << image.GetHeight() << std::endl;
    
    // Правильно - по строкам
    for (int y = 0; y < image.GetHeight(); ++y) {
        for (int x = 0; x < image.GetWidth(); ++x) {
            Color& color = image.GetPixel(x, y);
            
            // Конвертируем в int, инвертируем, конвертируем обратно
            int r_value = static_cast<int>(color.r);
            int g_value = static_cast<int>(color.g);
            int b_value = static_cast<int>(color.b);

            int inverted_r = 255 - r_value;
            int inverted_g = 255 - g_value;
            int inverted_b = 255 - b_value;

            // Записываем обратно в byte (используем static_cast)
            color.r = static_cast<std::byte>(inverted_r);
            color.g = static_cast<std::byte>(inverted_g);
            color.b = static_cast<std::byte>(inverted_b);
            
            // Альфа-канал НЕ трогаем!
        }
    }
    
    std::cout << "Инвертирование завершено!" << std::endl;
}

}  // namespace img_lib
