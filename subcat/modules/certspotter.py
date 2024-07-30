import navigator

URL_API = 'https://api.certspotter.com/v1/issuances?domain={}&expand=dns_names&expand=issuer'
DOMAINS_LIST = []


def returnDomains(domain, silent=False):
    req = navigator.Navigator()
    json = req.downloadResponse(URL_API.format(domain), 'JSON', 'GET')
    try:
        if 'code' in json:
            return []
        for _ in json:
            for __ in _['dns_names']:
                if domain in req.filterUrl(__):
                    DOMAINS_LIST.append(req.filterUrl(__))
        if not silent:
            req.ModuleLoaded('certspotter.com', DOMAINS_LIST)
        return DOMAINS_LIST
    except:
        return []
