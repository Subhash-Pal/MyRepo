#include <iostream>
#include <queue>
#include <thread>
#include <mutex>
#include <condition_variable>
#include <optional>
#include <chrono>

template <typename T>
class Channel {
public:
    // Send data into the channel (producer)
    void send(T value) {
        std::unique_lock<std::mutex> lock(mtx);
        q.push(value);
        cond_var.notify_one();
    }

    // Receive data from the channel (consumer)
    std::optional<T> receive() {
        std::unique_lock<std::mutex> lock(mtx);
        cond_var.wait(lock, [&] { return !q.empty(); });
        T value = q.front();
        q.pop();
        return value;
    }

    // Check if the channel is empty
    bool empty() {
        std::unique_lock<std::mutex> lock(mtx);
        return q.empty();
    }

private:
    std::queue<T> q;
    std::mutex mtx;
    std::condition_variable cond_var;
};

void producer(Channel<int>& channel) {
    for (int i = 1; i <= 10; ++i) {
        std::this_thread::sleep_for(std::chrono::milliseconds(100)); // Simulate work
        std::cout << "Producing: " << i << std::endl;
        channel.send(i);  // Send data to the channel
    }
}

void consumer(Channel<int>& channel) {
    for (int i = 0; i < 10; ++i) {
        auto value = channel.receive(); // Receive data from the channel
        if (value) {
            std::cout << "Consuming: " << *value << std::endl;
        }
    }
}

int main() {
    Channel<int> channel;

    auto start = std::chrono::high_resolution_clock::now(); // Start time

    std::thread prod(producer, std::ref(channel));
    std::thread cons(consumer, std::ref(channel));

    prod.join();
    cons.join();

    auto end = std::chrono::high_resolution_clock::now(); // End time

    std::chrono::duration<double> elapsed = end - start; // Calculate duration
    std::cout << "Execution time: " << elapsed.count() << " seconds" << std::endl;

    return 0;
}
