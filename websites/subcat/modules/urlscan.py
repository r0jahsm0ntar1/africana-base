import navigator

URL_API = 'https://urlscan.io/api/v1/search/?q=domain:{}'
DOMAINS_LIST = []


def returnDomains(domain, silent=False):
    req = navigator.Navigator()
    json = req.downloadResponse(URL_API.format(domain), 'JSON', 'GET')
    try:
        for x in json['results']:
            if domain in req.Hostname(x['page']['url']):
                DOMAINS_LIST.append(req.Hostname(x['page']['url']))
        if not silent:
            req.ModuleLoaded('urlscan.io', DOMAINS_LIST)
        return DOMAINS_LIST
    except:
        return []