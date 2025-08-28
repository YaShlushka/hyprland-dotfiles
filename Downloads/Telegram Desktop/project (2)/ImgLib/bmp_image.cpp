#include "bmp_image.h"
#include "pack_defines.h"
#include <fstream>
#include <vector>
#include <cstdint>

using namespace std;

namespace img_lib {

PACKED_STRUCT_BEGIN BitmapFileHeader {
    uint16_t bfType;
    uint32_t bfSize;
    uint16_t bfReserved1;
    uint16_t bfReserved2;
    uint32_t bfOffBits;
}
PACKED_STRUCT_END

PACKED_STRUCT_BEGIN BitmapInfoHeader {
    uint32_t biSize;
    int32_t  biWidth;
    int32_t  biHeight;
    uint16_t biPlanes;
    uint16_t biBitCount;
    uint32_t biCompression;
    uint32_t biSizeImage;
    int32_t  biXPelsPerMeter;
    int32_t  biYPelsPerMeter;
    uint32_t biClrUsed;
    uint32_t biClrImportant;
}
PACKED_STRUCT_END

static int GetBMPStride(int w) {
    return 4 * ((w * 3 + 3) / 4);
}

bool SaveBMP(const Path& file, const Image& image) {
    ofstream ofs(file, ios::binary);
    if (!ofs) return false;

    const int w = image.GetWidth();
    const int h = image.GetHeight();
    const int stride = GetBMPStride(w);
    
    const uint32_t imageDataSize = stride * h;
    const uint32_t headerSize = sizeof(BitmapFileHeader) + sizeof(BitmapInfoHeader);
    const uint32_t fileSize = headerSize + imageDataSize;

    // Заполняем заголовок файла
    BitmapFileHeader fileHeader = {};
    fileHeader.bfType = 0x4D42;  // 'BM'
    fileHeader.bfSize = fileSize;
    fileHeader.bfReserved1 = 0;
    fileHeader.bfReserved2 = 0;
    fileHeader.bfOffBits = headerSize;  // = 54

    // Заполняем информационный заголовок
    BitmapInfoHeader infoHeader = {};
    infoHeader.biSize = sizeof(BitmapInfoHeader);  // = 40
    infoHeader.biWidth = w;
    infoHeader.biHeight = h;
    infoHeader.biPlanes = 1;
    infoHeader.biBitCount = 24;
    infoHeader.biCompression = 0;
    infoHeader.biSizeImage = imageDataSize;
    infoHeader.biXPelsPerMeter = 11811;  // 300 DPI
    infoHeader.biYPelsPerMeter = 11811;  // 300 DPI
    infoHeader.biClrUsed = 0;
    infoHeader.biClrImportant = 0x1000000;  // ИСПРАВЛЕНО: 0x1000000 вместо 0

    // Записываем заголовки
    ofs.write(reinterpret_cast<const char*>(&fileHeader), sizeof(fileHeader));
    ofs.write(reinterpret_cast<const char*>(&infoHeader), sizeof(infoHeader));
    if (!ofs) return false;

    // Записываем данные изображения
    vector<unsigned char> rowBuffer(stride, 0);
    for (int y = h - 1; y >= 0; --y) {  // BMP: снизу вверх
        const Color* line = image.GetLine(y);
        
        // Заполняем строку в формате BGR
        for (int x = 0; x < w; ++x) {
            rowBuffer[x * 3 + 0] = static_cast<unsigned char>(line[x].b);  // B
            rowBuffer[x * 3 + 1] = static_cast<unsigned char>(line[x].g);  // G
            rowBuffer[x * 3 + 2] = static_cast<unsigned char>(line[x].r);  // R
        }
        
        ofs.write(reinterpret_cast<const char*>(rowBuffer.data()), stride);
        if (!ofs) return false;
    }

    return true;
}

Image LoadBMP(const Path& file) {
    ifstream ifs(file, ios::binary);
    if (!ifs) return {};

    BitmapFileHeader fileHeader;
    BitmapInfoHeader infoHeader;

    ifs.read(reinterpret_cast<char*>(&fileHeader), sizeof(fileHeader));
    ifs.read(reinterpret_cast<char*>(&infoHeader), sizeof(infoHeader));
    if (!ifs) return {};

    // Проверяем заголовки
    if (fileHeader.bfType != 0x4D42 ||
        infoHeader.biSize != sizeof(BitmapInfoHeader) ||
        infoHeader.biPlanes != 1 ||
        infoHeader.biBitCount != 24 ||
        infoHeader.biCompression != 0 ||
        infoHeader.biWidth <= 0 ||
        infoHeader.biHeight <= 0) {
        return {};
    }

    const int w = infoHeader.biWidth;
    const int h = infoHeader.biHeight;
    const int stride = GetBMPStride(w);

    ifs.seekg(fileHeader.bfOffBits, ios::beg);
    if (!ifs) return {};

    Image result(w, h, Color::Black());
    vector<unsigned char> rowBuffer(stride);

    for (int y = h - 1; y >= 0; --y) {
        Color* line = result.GetLine(y);
        ifs.read(reinterpret_cast<char*>(rowBuffer.data()), stride);
        if (!ifs) return {};

        for (int x = 0; x < w; ++x) {
            line[x].b = static_cast<std::byte>(rowBuffer[x * 3 + 0]);
            line[x].g = static_cast<std::byte>(rowBuffer[x * 3 + 1]);
            line[x].r = static_cast<std::byte>(rowBuffer[x * 3 + 2]);
            line[x].a = std::byte{255};
        }
    }

    return result;
}

} // namespace img_lib
