import navigator

URL_API = 'https://www.threatcrowd.org/searchApi/v2/domain/report/?domain={}'
DOMAINS_LIST = []


def returnDomains(domain, silent=False):
    req = navigator.Navigator()
    json = req.downloadResponse(URL_API.format(domain), 'JSON', 'GET')
    try:
        if "response_code" in json:
            for x in json['subdomains']:
                if domain in req.filterUrl(x):
                    DOMAINS_LIST.append(req.filterUrl(x))
            if not silent:
                req.ModuleLoaded('threatcrowd.org', DOMAINS_LIST)
            return DOMAINS_LIST
        else:
            return []
    except:
        return []
