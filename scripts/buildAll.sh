cd ~/workspace/gemini-engine/build
cmake .. && make

cd ../gemini/shaders/
glslangValidator -V shader.vert -o shader.vert.spv
glslangValidator -V shader.frag -o shader.frag.spv

cd ../../
g++ -g -std=c++17 ./app/*.cpp -L./build/ -lGemini -lvulkan -lglfw -I./gemini/ -I./ -o ./app.run
