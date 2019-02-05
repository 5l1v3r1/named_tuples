//
// Author: Erez Strauss <erez@erezstrauss.com>
//

#pragma once
#include <named_tuple.h>
#include <exception>
#include <sstream>
#include <tuple>
#include <type_traits>

template<typename... TS>
class exception_tuple : public std::exception {
   public:
    std::tuple<std::decay_t<TS>...> _data;
    std::string mutable _str;

    exception_tuple<TS...>(TS... vs) : _data(vs...) {}

    virtual const char* what() const noexcept {
        std::stringstream buff{};
        (..., (buff << ", " << std::get<TS>(_data)));
        _str = buff.str();
        return _str.c_str();
    }
};

#define NT_EXCEPTION(...)                                          \
    exception_tuple(("file"_ = __FILE__), ("line"_ = __LINE__),    \
                    ("func"_ = __PRETTY_FUNCTION__) __VA_OPT__(, ) \
                        __VA_ARGS__)
