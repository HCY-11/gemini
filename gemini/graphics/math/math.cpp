#include "math.h"

namespace gm
{
    glm::mat4 Math::createModelMatrix(Entity* entity)
    {
        glm::mat4 matrix = glm::mat4(1.0f);
        matrix = glm::translate(matrix, entity->getTransform().position);

        matrix = glm::rotate(matrix, glm::radians(entity->getTransform().rotation.x), glm::vec3(1, 0, 0));
        matrix = glm::rotate(matrix, glm::radians(entity->getTransform().rotation.y), glm::vec3(0, 1, 0));
        matrix = glm::rotate(matrix, glm::radians(entity->getTransform().rotation.z), glm::vec3(0, 0, 1));

        matrix = glm::scale(matrix, entity->getTransform().scale);
        
        return matrix;
    }

    glm::mat4 Math::createProjectionViewMatrix(Window* window, const Camera& camera)
    {
        glm::mat4 matrix = glm::mat4(1.0f);

        int width, height;
        glfwGetWindowSize(window->get(), &width, &height);

        matrix = glm::perspective(camera.fovAngle, 
                                                  static_cast<float>(width) / static_cast<float>(height),
                                                  0.1f, // Near plane
                                                  100.0f // Far Plane
                                                );
        
        matrix = glm::translate(matrix, -camera.position);

        matrix = glm::rotate(matrix, -camera.rotation.x, glm::vec3(1, 0, 0));
        matrix = glm::rotate(matrix, -camera.rotation.y, glm::vec3(0, 1, 0));
        matrix = glm::rotate(matrix, -camera.rotation.z, glm::vec3(0, 0, 1));

        return matrix;
    }
} 
