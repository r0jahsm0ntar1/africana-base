import navigator

URL_API = 'https://api.hackertarget.com/hostsearch/?q={}'
DOMAINS_LIST = []


def returnDomains(domain, silent=False):
    req = navigator.Navigator()

    html = req.downloadResponse(URL_API.format(domain), 'HTML', 'GET').split('\n')
    try:
        for _ in html:
            if domain in _.split(',')[0]:
                DOMAINS_LIST.append(_.split(',')[0])
        if not silent:
            req.ModuleLoaded('hackertarget.com', DOMAINS_LIST)
        return DOMAINS_LIST
    except:
        return []