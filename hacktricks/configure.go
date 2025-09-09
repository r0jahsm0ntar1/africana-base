package main

import (
    "fmt"
    "os"
    "os/exec"
    "os/signal"
    "runtime"
    "strings"
    "sync"
    "math/rand"
    "io/ioutil"
)

var (
    err error
    mu sync.Mutex
    flag, shell, process string
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


var (
    Endc   = "\033[0m"
    Bold   = "\033[1m"
    Dim    = "\033[2m"
    Italic = "\033[3m"
    Underl = "\033[4m"
    Blink  = "\033[5m"
    Blink2 = "\033[6m"
    Invert = "\033[7m"
    Hidden = "\033[8m"
    Strike = "\033[9m"

    Black   = "\033[30m"
    Red     = "\033[31m"
    Green   = "\033[32m"
    Yellow  = "\033[33m"
    Blue    = "\033[34m"
    Magenta = "\033[35m"
    Cyan    = "\033[36m"
    White   = "\033[37m"

    Grey          = "\033[90m"
    BrightRed     = "\033[91m"
    BrightGreen   = "\033[92m"
    BrightYellow  = "\033[93m"
    BrightBlue    = "\033[94m"
    BrightMagenta = "\033[95m"
    BrightCyan    = "\033[96m"
    BrightWhite   = "\033[97m"

    BackBlack   = "\033[40m"
    BackRed     = "\033[41m"
    BackGreen   = "\033[42m"
    BackYellow  = "\033[43m"
    BackBlue    = "\033[44m"
    BackMagenta = "\033[45m"
    BackCyan    = "\033[46m"
    BackWhite   = "\033[47m"

    BackGrey          = "\033[100m"
    BackBrightRed     = "\033[101m"
    BackBrightGreen   = "\033[102m"
    BackBrightYellow  = "\033[103m"
    BackBrightBlue    = "\033[104m"
    BackBrightMagenta = "\033[105m"
    BackBrightCyan    = "\033[106m"
    BackBrightWhite   = "\033[107m"

    XTERM_FG    []string
    XTERM_BG    []string
    colorTaken  []string
)

func init() {
    XTERM_FG = make([]string, 256)
    XTERM_BG = make([]string, 256)
    for i := 0; i < 256; i++ {
        XTERM_FG[i] = fmt.Sprintf("\033[38;5;%dm", i)
        XTERM_BG[i] = fmt.Sprintf("\033[48;5;%dm", i)
    }

    if runtime.GOOS == "windows" {
        Endc, Bold, Dim, Italic, Underl, Blink, Blink2, Invert, Hidden, Strike = "", "", "", "", "", "", "", "", "", ""
        Black, Red, Green, Yellow, Blue, Magenta, Cyan, White = "", "", "", "", "", "", "", ""
        Grey, BrightRed, BrightGreen, BrightYellow, BrightBlue, BrightMagenta, BrightCyan, BrightWhite = "", "", "", "", "", "", "", ""
        BackBlack, BackRed, BackGreen, BackYellow, BackBlue, BackMagenta, BackCyan, BackWhite = "", "", "", "", "", "", "", ""
        BackGrey, BackBrightRed, BackBrightGreen, BackBrightYellow, BackBrightBlue, BackBrightMagenta, BackBrightCyan, BackBrightWhite = "", "", "", "", "", "", "", ""

        for i := range XTERM_FG {
            XTERM_FG[i] = ""
            XTERM_BG[i] = ""
        }
    }
}

func Colors(args ...string) string {
    colors := []string{
        BrightRed, BrightGreen, BrightYellow, BrightBlue,
        BrightMagenta, BrightCyan, BrightWhite, Yellow,
        Magenta, Cyan, Green, Blue, Red,
        XTERM_FG[9],
        XTERM_FG[10],
        XTERM_FG[11],
        XTERM_FG[12],
        XTERM_FG[13],
        XTERM_FG[14],
        XTERM_FG[15],
        XTERM_FG[45],
        XTERM_FG[51],
        XTERM_FG[82],
        XTERM_FG[201],
    }

    if len(args) > 0 {
        return args[0]
    }

    availableColors := []string{}
    for _, c := range colors {
        used := false
        for _, t := range colorTaken {
            if c == t {
                used = true
                break
            }
        }
        if !used {
            availableColors = append(availableColors, c)
        }
    }

    if len(availableColors) == 0 {
        colorTaken = []string{}
        availableColors = colors
    }

    color := availableColors[rand.Intn(len(availableColors))]
    colorTaken = append(colorTaken, color)
    return color
}

func XtermColor(index int) string {
    if index < 0 || index > 255 {
        return Endc
    }
    return XTERM_FG[index]
}

func XtermBgColor(index int) string {
    if index < 0 || index > 255 {
        return Endc
    }
    return XTERM_BG[index]
}

func XtermColorRGB(r, g, b int) string {
    if r < 0 || r > 5 || g < 0 || g > 5 || b < 0 || b > 5 {
        return Endc
    }
    index := 16 + (36 * r) + (6 * g) + b
    return XTERM_FG[index]
}

func XtermBgColorRGB(r, g, b int) string {
    if r < 0 || r > 5 || g < 0 || g > 5 || b < 0 || b > 5 {
        return Endc
    }
    index := 16 + (36 * r) + (6 * g) + b
    return XTERM_BG[index]
}

func XtermGrayscale(level int) string {
    if level < 0 || level > 23 {
        return Endc
    }
    return XTERM_FG[232 + level]
}

func XtermBgGrayscale(level int) string {
    if level < 0 || level > 23 {
        return Endc
    }
    return XTERM_BG[232 + level]
}

func Popen(command string) {
    cmd := exec.Command(shell, flag, command)
    cmd.Stdin = os.Stdin
    cmd.Stdout = os.Stdout
    cmd.Stderr = os.Stderr

    sigs := make(chan os.Signal, 1)
    signal.Notify(sigs, os.Interrupt)

    go func() {
        <-sigs
        if cmd.Process != nil {
            _ = cmd.Process.Signal(os.Interrupt)
        }
    }()

    if err := cmd.Start(); err != nil {
        msg, _ := fmt.Printf("%s[!] %sError starting command ... %s%s_", BrightRed, BrightBlue, Endc, err)
        fmt.Fprintln(os.Stderr, msg)
        return
    }

    if err := cmd.Wait(); err != nil {
        msg, _ := fmt.Printf("%s[!] %sProcess is incomplete ... %s%s_", BrightRed, Endc, Endc, err)
        fmt.Fprintln(os.Stderr, msg)
    }

    signal.Stop(sigs)
    close(sigs)
}

func replaceStringsInFile(fileName string, replacements map[string]string) error {
    content, err := ioutil.ReadFile(fileName)
    if err != nil {
        return err
    }
    textContent := string(content)
    for old, new := range replacements {
        textContent = strings.Replace(textContent, old, new, -1)
    }
    return ioutil.WriteFile(fileName, []byte(textContent), 0644)
}

func Editors(filesToReplacements map[string]map[string]string) {
    for fileName, replacements := range filesToReplacements {
        err := replaceStringsInFile(fileName, replacements)
        if err != nil {
            fmt.Printf("%s[!] %sError: Configuring %s%v ...\n", BrightRed, Endc, fileName, err)
        } else {
            fmt.Printf("%s[*] %sDone: Configuring %s%s%s ...\n", Green, Endc, BrightBlue, fileName, Endc)
        }
    }
}

func ConfigAll() {
    filesToReplacements := map[string]map[string]string{
        "/etc/default/grub": {
            `GRUB_CMDLINE_LINUX_DEFAULT="quiet"`: `GRUB_CMDLINE_LINUX_DEFAULT=""`,
            `#GRUB_TERMINAL=console`: `GRUB_TERMINAL=console`,
        },
    }
    filesToReplacements0 := map[string]map[string]string{
        "/etc/default/grub.d/kali-themes.cfg": {
            `if ! echo "$GRUB_CMDLINE_LINUX_DEFAULT" | grep -q splash; then`: `#if ! echo "$GRUB_CMDLINE_LINUX_DEFAULT" | grep -q splash; then`,
            `    GRUB_CMDLINE_LINUX_DEFAULT="$GRUB_CMDLINE_LINUX_DEFAULT splash"`: `#    GRUB_CMDLINE_LINUX_DEFAULT="$GRUB_CMDLINE_LINUX_DEFAULT splash"`,
            `fi`: `#fi`,
        },
    }
    filesToReplacements1 := map[string]map[string]string{
        "/etc/grub.d/06_dark_theme": {
            `echo "set menu_color_normal=white/black"`: `echo "set menu_color_normal=green/black"`,
            `echo "set menu_color_highlight=yellow/black"`: `echo "set menu_color_highlight=white/black"`,
            `echo "set color_normal=white/black"`: `echo "set color_normal=white/black"`,
            `echo "set color_highlight=yellow/black"`: `echo "set color_highlight=green/black"`,
        },
    }

    Editors(filesToReplacements)
    Editors(filesToReplacements0)
    Editors(filesToReplacements1)
}


func PrintWork(Work string) {
    fmt.Printf("%s[*] %sDone: %s ...\n", Green, Endc, Work)
}

func main() {
    PrintWork("Creating .afr dir")
    filePath := "/root/.afr3/"
    if _, err := os.Stat(filePath); os.IsNotExist(err) {
        Popen(`mkdir -p /root/.afr3/`)
    }

    PrintWork("Relocating africana-base")
    Popen("mv afr_base/ /root/.afr3/africana-base")

    PrintWork("Changing acount .face ...")
    Popen("rm -rf /home/redhat/.face; cp -r ./afr_extras/back_grounds/face.png /home/redhat/.face")

    PrintWork("Changing Background")
    Popen("mv /usr/share/backgrounds/kali-16x9/default /usr/share/backgrounds/kali-16x9/default.org; cp -r ./afr_extras/back_grounds/linux_pinguins.jpg /usr/share/backgrounds/kali-16x9/default")

    PrintWork("Changing p10k theme")
    Popen("cp -r ./afr_extras/gitstatus/ /root/.cache/; chmod +x /root/.cache/gitstatus/gitstatusd-linux-x86_64; cp -r ./afr_extras/p10k.zsh /root/.p10k.zsh; cp -r ./afr_extras/zsh/ /root/.zsh; mv /root/.zshrc /root/.zshrc.org; cp -r ./afr_extras/zshrc /root/.zshrc")

    PrintWork("Adding ubuntu fonts")
    Popen("cp -r ./afr_extras/ubuntu_fonts/ /usr/local/share/fonts/")

    PrintWork("Creating python3-venv")
    Popen(`cd /root/.afr3/; python3 -m venv afr_venv; tar xf /home/redhat/Documents/africana-framework/afr_extras/py_modules.tar.gz --use-compress-program='gzip -9'; xterm -fullscreen -T 'Glory be To Lord God Jesus Christ' -e "source ~/.zshrc; python3 -m pip install --pre --upgrade --no-index --find-links ./py_modules -r /root/.afr3/africana-base/requirements.txt; rm -rf ./py_modules"`)

    PrintWork("Stopping timesyncd")
    Popen("systemctl stop systemd-timesyncd.service; systemctl disable systemd-timesyncd.service")

    PrintWork("Updating Boot-Grub")
    ConfigAll()
    Popen("update-grub2")
}

// apt install tor dnsmasq proxychains privoxy squid powershell curl make rlwrap ncat golang python3 python3-pip python3.13-venv
// cd /root/.afr3; python3-venv venv afr_venv; python3 -m pip install --pre --upgrade --no-index --find-links /home/redhat/Documents/africana-framework/afr_extras/py_modules/ -r /root/.afr3/afr_base/requirements.txt
// wget https://archive.kali.org/archive-keyring.gpg -O /usr/share/keyrings/kali-archive-keyring.gpg
// wget -qO - https://mirror.mwt.me/shiftkey-desktop/gpgkey | gpg --dearmor | sudo tee /usr/share/keyrings/mwt-desktop.gpg > /dev/null; sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/mwt-desktop.gpg] https://mirror.mwt.me/shiftkey-desktop/deb/ any main" > /etc/apt/sources.list.d/mwt-desktop.list'
//curl https://raw.githubusercontent.com/rapid7/metasploit-omnibus/master/config/templates/metasploit-framework-wrappers/msfupdate.erb > msfinstall && \
//  chmod 755 msfinstall && \
//  ./msfinstall
