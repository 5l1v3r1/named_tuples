
#CXXFLAGS := -fconcepts -I. -std=c++17 -W -Wall -Wshadow -O3 -ggdb3
CXXFLAGS := -I. -std=c++2a -W -Wall -Wshadow -Wpedantic -Werror -O3 -ggdb3 
#CXX := clang++ -Wno-gnu-string-literal-operator-template
CXX := g++

all: gtest_nvtuple named_tuple_example
	mkdir -p build; cd build ; cmake .. ; make -j VERBOSE=1 && ./named_tuple_example && ./gtest_nvtuple && ./gtest_excep_tuple

reformat:
	@for f in *.h *.cpp ; do echo $$f ; clang-format -style="{BasedOnStyle: Google, IndentWidth: 4, SpaceAfterTemplateKeyword: false}" -i $$f ; done

gtest_nvtuple: gtest_nvtuple.cpp named_tuple.h
	$(CXX) $(CXXFLAGS) -I . -DGTEST_HAS_PTHREAD=1 -pthread gtest_nvtuple.cpp -l gtest_main -l gtest -o gtest_nvtuple

gtest_excep_tuple: gtest_excep_tuple.cpp exception_tuple.h
	$(CXX) $(CXXFLAGS) -I . -DGTEST_HAS_PTHREAD=1 -pthread gtest_excep_tuple.cpp -l gtest_main -l gtest -o gtest_excep_tuple

clean:
	rm -rf named_tuple_example gtest_nvtuple build *~ *.o *.a *.s 
