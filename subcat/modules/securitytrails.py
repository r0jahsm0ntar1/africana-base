import navigator
from config import Config

URL_API = 'https://api.securitytrails.com/v1/domain/{0}/subdomains'
DOMAINS_LIST = []


def returnDomains(domain, silent=False):
    req = navigator.Navigator()
    keys = Config().read('securitytrails')
    if keys:
        for key in keys:
            json = req.downloadResponse(URL_API.format(domain), 'JSON', 'GET', header={'apikey': key})
            try:
                for _ in json['subdomains']:
                    DOMAINS_LIST.append('{0}.{1}'.format(_, domain))
                if not silent:
                    req.ModuleLoaded('securitytrails.com', DOMAINS_LIST)
                return DOMAINS_LIST
            except:
                return []
    else:
        return []
