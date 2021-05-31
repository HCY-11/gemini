cd ~/workspace/gemini-engine/build
cmake .. && make

#cd ../gemini/shaders/
#glslangValidator -V shader.vert -o vert.spv
#glslangValidator -V shader.frag -o frag.spv

cd ../
export LD_RUN_PATH=./build/
g++ -g -std=c++20 ./app/*.cpp -L./build/ -lGemini -lvulkan -lglfw -I./gemini/ -I./ -o ./app.run
