export LD_RUN_PATH=./build/
g++ -g -std=c++17 ./app/*.cpp -L./build/ -lGemini -lvulkan -lglfw -I./gemini/ -I./ -o ./app.run