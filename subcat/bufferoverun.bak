import navigator

URL_API = 'https://dns.bufferover.run/dns?q=.{}'
DOMAINS_LIST = []


def returnDomains(domain, silent=False):
    olddomain = domain
    req = navigator.Navigator()
    json = req.downloadResponse(URL_API.format(domain), 'JSON', 'GET')
    try:
        if json['FDNS_A'] == None:
            return []

        for _ in json['FDNS_A']:
            domainIp, domain = _.split(',')
            if olddomain in req.filterUrl(domain):
                DOMAINS_LIST.append(req.filterUrl(domain))
        if not silent:
            req.ModuleLoaded('bufferover.run', DOMAINS_LIST)
        return DOMAINS_LIST
    except:
        return []
