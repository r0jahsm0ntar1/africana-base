import navigator
from config import *

URL_API = 'https://api.binaryedge.io/v2/query/domains/subdomain/{0}'
DOMAINS_LIST = []


def returnDomains(domain, silent=False):
    req = navigator.Navigator()
    keys = Config().read('binaryedge')
    if keys:
        for key in keys:
            json = req.downloadResponse(URL_API.format(domain), 'JSON', 'GET', header={'X-Key': key})
            try:
                for _ in json['events']:
                    DOMAINS_LIST.append(_)
                if not silent:
                    req.ModuleLoaded('binaryedge.io', DOMAINS_LIST)
                return DOMAINS_LIST
            except:
                return []
    else:
        return []