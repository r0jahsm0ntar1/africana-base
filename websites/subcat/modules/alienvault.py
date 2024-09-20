import navigator

URL_API = 'https://otx.alienvault.com/api/v1/indicators/domain/{}/passive_dns'
DOMAINS_LIST = []


def returnDomains(domain, silent=False):
    req = navigator.Navigator()

    json = req.downloadResponse(URL_API.format(domain), 'JSON', 'GET')
    for _ in json['passive_dns']:
        if domain in _['hostname'] and '*' not in _['hostname']:
            DOMAINS_LIST.append(req.filterUrl(_['hostname']))
    if not silent:
        req.ModuleLoaded('alienvault.com', DOMAINS_LIST)
    return DOMAINS_LIST
