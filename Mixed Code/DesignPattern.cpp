#include <iostream>
#include <vector>
#include <thread>
#include <mutex>
#include <condition_variable>
#include <chrono>

// Base class representing a connection
class Connection {
public:
    virtual void readData() = 0; // Pure virtual function for reading data
    virtual ~Connection() {}
};

// Derived class: ReadFromPanel
class ReadFromPanel : public Connection {
public:
    void readData() override {
        std::cout << "Reading data from the panel..." << std::endl;
        std::this_thread::sleep_for(std::chrono::milliseconds(500));
    }
};

// Derived class: ReadFromSocket
class ReadFromSocket : public Connection {
public:
    void readData() override {
        std::cout << "Reading data from the socket..." << std::endl;
        std::this_thread::sleep_for(std::chrono::milliseconds(500));
    }
};

// Decoder class simulating decoding operations
class Decoder {
public:
    void decodeData() {
        std::cout << "Decoding data..." << std::endl;
        std::this_thread::sleep_for(std::chrono::milliseconds(300));
    }
};

// Render class simulating rendering operations
class Render {
public:
    void renderScreen() {
        std::cout << "Rendering on screen..." << std::endl;
        std::this_thread::sleep_for(std::chrono::milliseconds(200));
    }
};

// MainWindow class managing threads and components
class MainWindow {
private:
    std::vector<std::thread> threads;
    std::mutex mtx;
    bool running;
    Decoder decoder;
    Render render;
    std::vector<Connection*> connections;

public:
    MainWindow() : running(true) {}

    // Add connections to the window (like ReadFromPanel, ReadFromSocket)
    void addConnection(Connection* conn) {
        connections.push_back(conn);
    }

    // Launches threads to read data, decode, and render
    void start() {
        // Start render thread
        threads.push_back(std::thread(&MainWindow::renderThread, this));

        // Start decoder thread
        threads.push_back(std::thread(&MainWindow::decoderThread, this));

        // Start reading threads for each connection
        for (Connection* conn : connections) {
            threads.push_back(std::thread(&MainWindow::connectionThread, this, conn));
        }
    }

    // Stop the threads gracefully
    void stop() {
        {
            std::lock_guard<std::mutex> lock(mtx);
            running = false;
        }

        for (auto& th : threads) {
            if (th.joinable()) {
                th.join();
            }
        }
    }

private:
    // Thread for rendering
    void renderThread() {
        while (running) {
            render.renderScreen();
        }
    }

    // Thread for decoding
    void decoderThread() {
        while (running) {
            decoder.decodeData();
        }
    }

    // Thread for reading data from a connection
    void connectionThread(Connection* conn) {
        while (running) {
            conn->readData();
        }
    }
};

// Main function demonstrating the use of the classes
int main() {
    MainWindow mainWindow;

    // Create connections
    ReadFromPanel panelConnection;
    ReadFromSocket socketConnection;

    // Add connections to the MainWindow
    mainWindow.addConnection(&panelConnection);
    mainWindow.addConnection(&socketConnection);

    // Start all threads
    mainWindow.start();

    // Let the system run for some time
    std::this_thread::sleep_for(std::chrono::seconds(5));

    // Stop the threads
    mainWindow.stop();

    return 0;
}
