import navigator
from config import Config

URL_API = 'https://www.virustotal.com/vtapi/v2/domain/report?domain={0}&apikey={1}'
DOMAINS_LIST = []


def returnDomains(domain, silent=False):
    req = navigator.Navigator()
    keys = Config().read('virustotal')
    if keys:
        for key in keys:
            json = req.downloadResponse(URL_API.format(domain, key), 'JSON', 'GET')
            try:
                for _ in json['subdomains']:
                    if domain in _ and '*' not in _:
                        DOMAINS_LIST.append(_)
                if not silent:
                    req.ModuleLoaded('virustotal', DOMAINS_LIST)
                return DOMAINS_LIST
            except:
                return []
    else:
        return []
