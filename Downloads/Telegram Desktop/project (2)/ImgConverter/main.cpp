#include <iostream>
#include <string_view>
#include "img_lib.h"
#include "ppm_image.h"
#include "jpeg_image.h"
#include "bmp_image.h"

using namespace std;
using namespace img_lib;

enum class Format {
    UNKNOWN,
    PPM,
    JPEG,
    BMP
};

Format GetFormatByExtension(const Path& file) {
    string ext = file.extension().string();
    if (ext == ".jpg"sv || ext == ".jpeg"sv) return Format::JPEG;
    if (ext == ".ppm"sv) return Format::PPM;
    if (ext == ".bmp"sv) return Format::BMP;
    return Format::UNKNOWN;
}

class ImageFormatInterface {
public:
    virtual bool SaveImage(const Path& file, const Image& image) const = 0;
    virtual Image LoadImage(const Path& file) const = 0;
    virtual ~ImageFormatInterface() = default;
};

namespace FormatInterfaces {
class PPM : public ImageFormatInterface {
public:
    bool SaveImage(const Path& file, const Image& image) const override {
        return SavePPM(file, image);
    }
    Image LoadImage(const Path& file) const override {
        return LoadPPM(file);
    }
};
class JPEG : public ImageFormatInterface {
public:
    bool SaveImage(const Path& file, const Image& image) const override {
        return SaveJPEG(file, image);
    }
    Image LoadImage(const Path& file) const override {
        return LoadJPEG(file);
    }
};
class BMP : public ImageFormatInterface {
public:
    bool SaveImage(const Path& file, const Image& image) const override {
        return SaveBMP(file, image);
    }
    Image LoadImage(const Path& file) const override {
        return LoadBMP(file);
    }
};
} // namespace FormatInterfaces

const ImageFormatInterface* GetFormatInterface(const Path& path) {
    static const FormatInterfaces::PPM  ppmInterface;
    static const FormatInterfaces::JPEG jpegInterface;
    static const FormatInterfaces::BMP  bmpInterface;
    switch (GetFormatByExtension(path)) {
        case Format::PPM:  return &ppmInterface;
        case Format::JPEG: return &jpegInterface;
        case Format::BMP:  return &bmpInterface;
        default:           return nullptr;
    }
}

int main(int argc, const char** argv) {
    if (argc != 3) {
        cerr << "Usage: "sv << argv[0] << " <in_file> <out_file>"sv << endl;
        return 1;
    }

    Path in_path  = argv[1];
    Path out_path = argv[2];

    const ImageFormatInterface* inFormat  = GetFormatInterface(in_path);
    const ImageFormatInterface* outFormat = GetFormatInterface(out_path);

    if (!inFormat) {
        cerr << "Unknown format of the input file."sv << endl;
        return 2;
    }
    if (!outFormat) {
        cerr << "Unknown format of the output file."sv << endl;
        return 3;
    }

    Image image = inFormat->LoadImage(in_path);
    if (!image) {
        cerr << "Loading failed"sv << endl;
        return 4;
    }
    if (!outFormat->SaveImage(out_path, image)) {
        cerr << "Saving failed"sv << endl;
        return 5;
    }

    cout << "Successfully converted"sv << endl;
    return 0;
}
