import navigator

URL_API = 'https://crt.sh/?q={}&output=json'
DOMAINS_LIST = []


def returnDomains(domain, silent=False):
    req = navigator.Navigator()
    json = req.downloadResponse(URL_API.format(domain), 'JSON', 'GET')
    try:
        for _ in json:
            if domain in _['common_name'] and '*' not in _['common_name']:
                DOMAINS_LIST.append(req.filterUrl(_['common_name']))
        if not silent:
            req.ModuleLoaded('crt.sh', DOMAINS_LIST)
        return DOMAINS_LIST
    except:
        return []
