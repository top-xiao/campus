#include <cstdio> // 使用 C 风格文件操作以获得更高性能
#include <print>

int main() {
    // 使用 C 的 fopen，因为它与 std::print 的兼容性在当前标准下最直接
    std::FILE* file = std::fopen("modern.txt", "wb");
    
    if (file) {
        double pi = 3.1415926;
        // 直接向文件打印，支持所有格式化特性
        std::println(file, "Hello Modern C++!");
        std::println(file, "Pi to two decimal places: {:.2f}", pi);
        
        std::fclose(file);
    }
    return 0;
}
