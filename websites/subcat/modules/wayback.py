import navigator

URL_API = 'http://web.archive.org/cdx/search/cdx?url=*.{}/*&output=json&collapse=urlkey'
DOMAINS_LIST = []


def returnDomains(domain, silent=False):
    req = navigator.Navigator()
    json = req.downloadResponse(URL_API.format(domain), 'JSON', 'GET')
    try:
        for _ in json:
            if domain in _[2] and '*' not in _[2]:
                DOMAINS_LIST.append(req.Hostname(_[2]))
        if not silent:
            req.ModuleLoaded('wayback', DOMAINS_LIST)
        return DOMAINS_LIST
    except:
        return []