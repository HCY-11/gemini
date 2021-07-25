#pragma once

#include "core/core.h"

namespace gm
{
    struct DeletionQueue
    {
        std::deque<std::function<void()>> deletors;

        void push(const std::function<void()>& func)
        {
            deletors.push_back(func);
        }

        void flush()
        {
            for (auto it = deletors.end(); it != deletors.begin(); it--)
            {
                (*it)();
            }

            deletors.clear();
        }
    };
}