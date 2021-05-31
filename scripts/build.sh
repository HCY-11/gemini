cd ~/workspace/gemini-engine/build
cmake .. && make

cd ../gemini/shaders/
glslangValidator -V shader.vert -o vert.spv
glslangValidator -V shader.frag -o frag.spv

cd ../../
g++ -g -std=c++17 ./app/*.cpp -L./build/ -lGemini -lvulkan -lglfw -I./gemini/ -I./ -o ./app.run
