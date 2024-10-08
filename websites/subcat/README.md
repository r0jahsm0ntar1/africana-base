
# SubCat

![alt text](https://img.shields.io/github/stars/duty1g/subcat "")
![alt text](https://img.shields.io/github/languages/top/duty1g/subcat "")
![alt text](https://img.shields.io/github/license/duty1g/subcat "")
<a href="https://twitter.com/duty_1g"><img src="https://img.shields.io/twitter/follow/duty_1g.svg?logo=twitter"></a>


<p align="center"><img src="https://user-images.githubusercontent.com/3162883/168605639-8a2cb290-38d3-4edb-9587-584d17f4fac3.png#gh-dark-mode-only" width="60%"/>
  <img src="https://user-images.githubusercontent.com/3162883/169028346-3151e07e-ea94-4911-8009-942a5f384c77.png#gh-light-mode-only" width="60%"/>
</p>
<h4 align="center">Fast subdomain enumeration tool.</h4>

<p align="center">
  <a href="#features">Features</a> •
  <a href="#Install">Install</a> •
  <a href="#post-installation">Post Installation</a> •
  <a href="#Usage">Usage</a> •
  <a href="#running-subcat">Running SubCat</a>
</p>

#
SubCat a subdomain discovery tool that discovers valid subdomains for websites by using passive online sources. It has a simple modular architecture and is optimized for speed. SubCat is built for doing one thing only - passive subdomain enumeration, and it does that very well.

We have designed SubCat to comply with all passive sources licenses, and usage restrictions, as well as maintained a consistently passive model to make it useful to both penetration testers and bug bounty hunters alike.


### Features

<img width="1000" alt="demo" src="https://user-images.githubusercontent.com/3162883/170030037-4e5cf0f7-3ed5-46aa-afaa-4d992a2c1eb3.gif">

- Fast and powerful resolution and wildcard elimination module
- **Curated** passive sources to maximize results
- Optimized for speed, very fast and **lightweight** on resources
- **STDIN/OUT** support for integrating in workflows
- Scope limitation based on given IP ranges list 

### Install
```
# Linux, Windows, MacOS
pip3 install -r requirements.txt
```

### Post Installation

API Key is needed before querying on third-party sites, such as ```Shodan, SecurityTrails, Virustotal,``` and ```BinaryEdge```.

- The API key setting can be done via `config.yaml`.

An example provider config file 

```yaml

binaryedge:
  - 0bf8919b-aab9-42e4-9574-d3b639324597
  - ac244e2f-b635-4581-878a-33f4e79a2c13

virustotal:
  - AAAAClP1bJJSRMEAAAAClP1bJJSRMEYJazgwhJKrggRwKAYJazgwhJKrggRwKA
securitytrails: []
shodan:
  - AAAAClP1bJJSRMEYJazgwhJKrggRwKA


```

### Usage

```console
python3 subcat.py -h
```
This will display help for the tool. Here are all the switches it supports.

```yaml
Flags:
INPUT:
   -d --domain string    domains to find subdomains for
   -l DOMAINLIST         file containing list of domains for subdomain discovery
   --scope SCOPE         show only subdomains in scope

OUTPUT:
   -sc, --status-code    show response status code
   -ip, --ip             resolve IP address
   -title, --title       show page title
   -silent, --silent     show only subdomains in output
   -o OUTPUT, --output OUTPUT
                        file to write output to
   
CONFIG:
   -t THREADS, --threads THREADS
                        number of concurrent threads for resolving (default 40)

DEBUG:
   -v                    show verbose output
   -h, --help            show this help message and exit
```

### Running SubCat
```console
cat domains | python3 subcat.py
```

```console
echo hackerone.com | python3 subcat.py -silent | httpx -silent

http://hackerone.com
http://www.hackerone.com
http://docs.hackerone.com
http://api.hackerone.com
https://docs.hackerone.com
http://mta-sts.managed.hackerone.com
```

```console
python3 subcat.py -d hackerone.com

 
	                      ;            ;                  
	                    ρββΚ          ;ββΝ                
	                  έΆχββββββββββββββββββΒ              
	                ;ΣΆχΜ΅΅ΫΝββββββββ Ϋ΅΅ΫβββΝ            
	               όΆΆχβ   Ά   ββββ΅  Ά΅  βββββ           
	              χΆΆΆφβΒ; Ϋ΅;έββββΒ; Ϋ΅ ρββββββ          
	              ΆΆΆΆδβββββββββ;χββββββμβββββββ          
	              ΪχχχχΧβββββββββββββββββββθθθθΚ          
	             ·ϊβθβζ  Ϊθθβββββββββββββββμ ;όβΫ΅        
	              ·΅   ΅ΫΫΫΆΆθβββββββββθθΫ΅   ΅Ϋ΅         
	                      ;ΣΆθββββΒΝρρρμ                  
	                     ;ΣΆΆβββββββββββμ
	 ▄∞∞∞∞∞▄, ╒∞∞▄   ∞∞▄ ▄∞∞∞∞∞∞▄   ,▄∞∞∞∞▄      ▄∞∞4▄  ╒∞∞∞∞∞∞∞▄,
	▐▄ ═▄▄▄ ▐█▐ ,▀  j' █▌█  ▄▄▄ ▀█▌█▀ ╓▄▄  ▀▄  ¡█  , ▐█ ▐▄▄▄  ▄▄██
	▐▄ `'""▀██▐  █▌ j  █▌█  `"" ▄█▌█ ▐█▀`▀▄██' M  $██  █, `█ ▐█```
	j▀▀███▌ ▐█▐  ▀▌▄█  ▀▀█ ▐███  █▌▄ ▀█▄▄▀ ▐█M▀.       ▀█▄.▀ J▀
	╚▄,,¬¬⌐▄█▌ ▀▄,,, ▄██ █,,,,,▓██▌ ▀▄,,,,▄█╩j▌,██▀▀▀▀▌,█▌`█,▐█
	  ▀▀▀▀▀▀▀    ▀▀▀▀▀▀ ""▀▀▀▀▀▀      ▀▀▀""`  ▀▀▀     ▀▀▀   ▀▀▀
	               ΅qΆΆΆΆβββββββββββββββββββββΡ΅  
	                  ΫθΆΆΆββββββββββββββββΡ΅         
	                      ΅ΫΫΫΫΝNNΝΫΫΫΐ΅΅      
	                    
	                    
	                    v{1.1.1#dev}@duty1g
	                            


[13:05:51] [INFO]: binaryedge.io 13 asset                                             
[13:05:52] [INFO]: virustotal 18 asset                                             
[13:05:53] [INFO]: urlscan.io 98 asset                                             
[13:05:54] [INFO]: alienvault.com 59 asset                                             
[13:06:28] [INFO]: wayback 193046 asset                                             
[13:06:29] [INFO]: hackertarget.com 4 asset                                             
[13:06:31] [INFO]: crt.sh 268 asset                                             
[13:06:32] [INFO]: certspotter.com 12 asset                                             
[13:06:33] [INFO]: bufferover.run 11 asset                                             
[13:06:33] [INFO]: threatcrowd.org 4 asset                                             
[13:06:33] [INFO]: Found 21 for hackerone.com

mta-sts.managed.hackerone.com
mta-sts.hackerone.com
mta-sts.forwarding.hackerone.com
a.ns.hackerone.com
b.ns.hackerone.com
docs.hackerone.com
go.hackerone.com
info.hackerone.com
links.hackerone.com
support.hackerone.com
api.hackerone.com
www.hackerone.com
hackerone.com
zendesk1.hackerone.com
zendesk3.hackerone.com
gslink.hackerone.com
zendesk4.hackerone.com
resources.hackerone.com
events.hackerone.com
zendesk2.hackerone.com
3d.hackerone.com


```

To run the tool on a target, just use the following command.
### License

SubCat is made with 🖤 by duty1g
